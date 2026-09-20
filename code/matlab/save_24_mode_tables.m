function save_24_mode_tables()
%SAVE_24_MODE_TABLES Save mode tables and the Uribe-A mode/MH comparison.

P = project_paths();
save_one(fullfile(P.uribe_A,'uribe_A_24_mode5_results.mat'), ...
         fullfile(P.uribe_A,'uribe_A_24_mode_table.csv'), ...
         fullfile(P.uribe_A,'uribe_A_24_mode_table.mat'),true);
save_one(fullfile(P.uribe_B,'uribe_B_24_mode5_results.mat'), ...
         fullfile(P.uribe_B,'uribe_B_24_mode_table.csv'), ...
         fullfile(P.uribe_B,'uribe_B_24_mode_table.mat'),false);

mode5 = load(fullfile(P.uribe_A,'uribe_A_24_mode5_results.mat'),'oo_');
mode6 = load(fullfile(P.uribe_A,'uribe_A_24_mode6_results.mat'),'oo_');
mh    = load(fullfile(P.uribe_A,'uribe_A_24_mh_results.mat'),'oo_');

names = {'phi','alpha_pi','alpha_y','gamma_m','gamma_I','delta', ...
    'rho_xi','rho_theta','rho_z','rho_g','rho_gm','rho_zm', ...
    'sigma_xi','sigma_theta','sigma_z','sigma_g','sigma_gm','sigma_zm', ...
    'obs_dy','obs_r','obs_di'};
category = [repmat("structural",18,1); repmat("measurement_error_stderr",3,1)];
mode5v = values(mode5.oo_,names,category,'posterior_mode');
mode6v = values(mode6.oo_,names,category,'posterior_mode');
mhv = values(mh.oo_,names,category,'posterior_mean');
comparison = table(string(names(:)),category,mode5v,mode6v,mhv, ...
    'VariableNames',{'name','category','mode_compute_5','mode_compute_6','mh_posterior_mean'});
writetable(comparison,fullfile(P.uribe_A,'uribe_A_24_mode_MH_comparison.csv'));
save(fullfile(P.uribe_A,'uribe_A_24_mode_MH_comparison.mat'),'comparison');
disp(comparison);
end

function save_one(source,csv_file,mat_file,isA)
S = load(source,'oo_');
if isA
    names = {'phi','alpha_pi','alpha_y','gamma_m','gamma_I','delta', ...
        'rho_xi','rho_theta','rho_z','rho_g','rho_gm','rho_zm', ...
        'sigma_xi','sigma_theta','sigma_z','sigma_g','sigma_gm','sigma_zm', ...
        'obs_dy','obs_r','obs_di'};
else
    names = {'phi','alpha_pi','alpha_y','gamma_m','gamma_I','delta', ...
        'rho_xi','rho_theta','rho_z','rho_g','rho_zm', ...
        'sigma_xi','sigma_theta','sigma_z','sigma_g','sigma_zm','sigma_zm2', ...
        'obs_dy','obs_r','obs_di'};
end
category = [repmat("structural",numel(names)-3,1); ...
            repmat("measurement_error_stderr",3,1)];
mode = values(S.oo_,names,category,'posterior_mode');
local_sd = values(S.oo_,names,category,'posterior_std_at_mode');
mode_table = table(string(names(:)),category,mode,local_sd, ...
    'VariableNames',{'name','category','mode','local_sd'});
writetable(mode_table,csv_file);
save(mat_file,'mode_table');
end

function out = values(oo_,names,category,group)
out = nan(numel(names),1);
for j = 1:numel(names)
    if category(j) == "structural"
        out(j) = nested_value(oo_,group,'parameters',names{j});
    else
        out(j) = nested_value(oo_,group,'measurement_errors_std',names{j});
    end
end
end

function value = nested_value(oo_,group,subgroup,name)
value = NaN;
if ~isfield(oo_,group) || ~isstruct(oo_.(group)), return; end
container = oo_.(group);
if ~isfield(container,subgroup), return; end
container = container.(subgroup);
if isstruct(container) && isfield(container,name), value = container.(name); end
end
