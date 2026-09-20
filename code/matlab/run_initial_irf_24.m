function run_initial_irf_24()
%RUN_INITIAL_IRF_24 Run the initial Table 4 + Table 5 IRF replication.
% The model uses one combined parameter vector, as required by the TP3.

P = project_paths();
assert(isfile(fullfile(P.data_processed,'uribe_data_pp.mat')), ...
    'Run build_data first.');

old = pwd;
cleanup = onCleanup(@() cd(old));
cd(P.dynare);
dynare('uribe_initial_24','noclearall');

copy_result(P.dynare,'uribe_initial_24_irf_results.mat',P.initial_irf);
copy_result(P.dynare,'uribe_initial_24.log',P.initial_irf);
clear cleanup
end

function copy_result(source_dir,name,target_dir)
if ~isfolder(target_dir), mkdir(target_dir); end
source = fullfile(source_dir,name);
if isfile(source), copyfile(source,fullfile(target_dir,name)); end
end
