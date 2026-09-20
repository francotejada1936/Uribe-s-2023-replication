function run_fixed_24_irfs()
%RUN_FIXED_24_IRFS Compute IRFs at the requested estimated vectors.
%
% The estimations are performed first. This routine then takes the saved
% mode/m posterior vectors, writes their structural parameters to a small
% Dynare include file, and runs the same exact 24-equation model with those
% parameters fixed. Thus the IRFs are not based on a second estimation.

P = project_paths();
sets = { ...
    struct('label','mode5','source','uribe_A_24_mode5_results.mat', ...
           'driver','uribe_fixed_24_irf'), ...
    struct('label','mode6','source','uribe_A_24_mode6_results.mat', ...
           'driver','uribe_fixed_24_irf'), ...
    struct('label','mh_mean','source','uribe_A_24_mh_results.mat', ...
           'driver','uribe_fixed_24_irf')};

for j = 1:numel(sets)
    source = fullfile(P.uribe_A,sets{j}.source);
    if ~isfile(source)
        error('Missing %s. Run the Uribe-A estimations first.',source);
    end
    S = load(source,'oo_','M_');
    values = parameter_vector(S,strcmp(sets{j}.label,'mh_mean'));
    write_parameter_include(P.dynare,S.M_,values);
    run_fixed_driver(P,sets{j}.driver);
    copyfile(fullfile(P.dynare,'uribe_fixed_24_irf_results.mat'), ...
             fullfile(P.uribe_A, ...
                      ['uribe_A_24_irf_' sets{j}.label '.mat']));
end

% Uribe-B has only one requested parameterization: its mode_compute=5 mode.
source = fullfile(P.uribe_B,'uribe_B_24_mode5_results.mat');
if ~isfile(source)
    error('Missing %s. Run the Uribe-B estimation first.',source);
end
S = load(source,'oo_','M_');
values = parameter_vector(S,false);
write_parameter_include(P.dynare,S.M_,values);
run_fixed_driver(P,'uribe_fixed_24_irf_B');
copyfile(fullfile(P.dynare,'uribe_fixed_24_irf_results.mat'), ...
         fullfile(P.uribe_B,'uribe_B_24_irf_mode5.mat'));

disp('Fixed-parameter IRFs saved under results/uribe_A and results/uribe_B.');
end

function values = parameter_vector(S,use_mean)
% Start from the model parameter vector so calibrated parameters remain in it.
values = S.M_.params(:);
names = cellstr(S.M_.param_names);

if use_mean
    posterior = S.oo_.posterior_mean.parameters;
else
    posterior = S.oo_.posterior_mode.parameters;
end

for j = 1:numel(names)
    name = strtrim(names{j});
    if isstruct(posterior) && isfield(posterior,name)
        values(j) = posterior.(name);
    end
end
end

function write_parameter_include(dynare_dir,M_,values)
file = fullfile(dynare_dir,'uribe_24_irf_parameters.inc');
fid = fopen(file,'w');
assert(fid >= 0,'Could not create %s.',file);
cleanup = onCleanup(@() fclose(fid));
names = cellstr(M_.param_names);
for j = 1:numel(names)
    name = strtrim(names{j});
    fprintf(fid,'%s = %.16g;\n',name,values(j));
end
clear cleanup
end

function run_fixed_driver(P,driver)
old = pwd;
cleanup = onCleanup(@() cd(old));
cd(P.dynare);
dynare(driver,'noclearall');
clear cleanup
end
