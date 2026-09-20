function run_uribe_B_estimation_24()
%RUN_URIBE_B_ESTIMATION_24 Estimate Uribe-B with mode_compute=5 only.

P = project_paths();
assert(isfile(fullfile(P.data_processed,'uribe_data_pp.mat')), ...
    'Run build_data first.');

old = pwd;
cleanup = onCleanup(@() cd(old));
cd(P.dynare);
dynare('uribe_B_24_mode5','noclearall');

if ~isfolder(P.uribe_B), mkdir(P.uribe_B); end
source = fullfile(P.dynare,'uribe_B_24_mode5_results.mat');
if isfile(source), copyfile(source,fullfile(P.uribe_B,'uribe_B_24_mode5_results.mat')); end
logfile = fullfile(P.dynare,'uribe_B_24_mode5.log');
if isfile(logfile), copyfile(logfile,fullfile(P.uribe_B,'uribe_B_24_mode5.log')); end
clear cleanup
end
