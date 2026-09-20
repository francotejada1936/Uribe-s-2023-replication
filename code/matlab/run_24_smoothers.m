function run_24_smoothers()
%RUN_24_SMOOTHERS Obtain smoothed inflation changes and inflation levels.
%
% Smoothing is conditional on the fixed parameter vectors already obtained
% from estimation. No new mode or MH estimation is performed here.

P = project_paths();

sets = { ...
    struct('label','mode5','source',fullfile(P.uribe_A,'uribe_A_24_mode5_results.mat'), ...
           'driver','uribe_fixed_24_smoother_A','target',P.uribe_A,'mean',false), ...
    struct('label','mode6','source',fullfile(P.uribe_A,'uribe_A_24_mode6_results.mat'), ...
           'driver','uribe_fixed_24_smoother_A','target',P.uribe_A,'mean',false), ...
    struct('label','mh_mean','source',fullfile(P.uribe_A,'uribe_A_24_mh_results.mat'), ...
           'driver','uribe_fixed_24_smoother_A','target',P.uribe_A,'mean',true), ...
    struct('label','mode5','source',fullfile(P.uribe_B,'uribe_B_24_mode5_results.mat'), ...
           'driver','uribe_fixed_24_smoother_B','target',P.uribe_B,'mean',false)};

for j = 1:numel(sets)
    if ~isfile(sets{j}.source)
        error('Missing %s. Run the corresponding estimation first.',sets{j}.source);
    end
    S = load(sets{j}.source,'oo_','M_');
    values = parameter_vector(S,sets{j}.mean);
    write_parameter_include(P.dynare,S.M_,values);
    old = pwd;
    cleanup = onCleanup(@() cd(old));
    cd(P.dynare);
    dynare(sets{j}.driver,'noclearall');
    clear cleanup

    source = fullfile(P.dynare,'uribe_fixed_24_smoother_results.mat');
    if strcmp(sets{j}.target,P.uribe_A)
        destination = fullfile(P.uribe_A,['uribe_A_24_smoother_' sets{j}.label '.mat']);
    else
        destination = fullfile(P.uribe_B,['uribe_B_24_smoother_' sets{j}.label '.mat']);
    end
    copyfile(source,destination);
end

process_24_smoothed_inflation;
end

function values = parameter_vector(S,use_mean)
values = S.M_.params(:);
names = cellstr(S.M_.param_names);
if use_mean
    structural = S.oo_.posterior_mean.parameters;
    measurement = S.oo_.posterior_mean.measurement_errors_std;
else
    structural = S.oo_.posterior_mode.parameters;
    measurement = S.oo_.posterior_mode.measurement_errors_std;
end
for j = 1:numel(names)
    name = strtrim(names{j});
    if isstruct(structural) && isfield(structural,name)
        values(j) = structural.(name);
    elseif isstruct(measurement)
        switch name
            case 'meas_dy'
                values(j) = measurement.obs_dy;
            case 'meas_r'
                values(j) = measurement.obs_r;
            case 'meas_di'
                values(j) = measurement.obs_di;
        end
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
    fprintf(fid,'%s = %.16g;\n',strtrim(names{j}),values(j));
end
clear cleanup
end
