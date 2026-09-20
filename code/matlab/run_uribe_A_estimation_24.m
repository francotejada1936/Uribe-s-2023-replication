function run_uribe_A_estimation_24(run_mh)
%RUN_URIBE_A_ESTIMATION_24 Estimate Uribe-A with the exact 24-equation core.
%
% The order is the order required by the TP3:
%   mode_compute=5, mode_compute=6, then mode_compute=6 + MH.
% Set run_mh=false to perform only the two mode calculations.

if nargin < 1, run_mh = true; end
P = project_paths();
assert(isfile(fullfile(P.data_processed,'uribe_data_pp.mat')), ...
    'Run build_data first.');

old = pwd;
cleanup = onCleanup(@() cd(old));
cd(P.dynare);

dynare('uribe_A_24_mode5','noclearall');
copy_result(P.dynare,'uribe_A_24_mode5_results.mat',P.uribe_A);
copy_result(P.dynare,'uribe_A_24_mode5.log',P.uribe_A);

dynare('uribe_A_24_mode6','noclearall');
copy_result(P.dynare,'uribe_A_24_mode6_results.mat',P.uribe_A);
copy_result(P.dynare,'uribe_A_24_mode6.log',P.uribe_A);

if run_mh
    warning(['The MH stage uses 1,000,000 replications and may take a ', ...
             'long time.']);
    dynare('uribe_A_24_mh','noclearall');
    copy_result(P.dynare,'uribe_A_24_mh_results.mat',P.uribe_A);
    copy_result(P.dynare,'uribe_A_24_mh.log',P.uribe_A);
end
clear cleanup
end

function copy_result(source_dir,name,target_dir)
if ~isfolder(target_dir), mkdir(target_dir); end
source = fullfile(source_dir,name);
if isfile(source), copyfile(source,fullfile(target_dir,name)); end
end
