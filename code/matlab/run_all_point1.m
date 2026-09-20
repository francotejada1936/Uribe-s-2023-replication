function run_all_point1(run_mh)
%RUN_ALL_POINT1 Execute the reproducible point-1 workflow in order.
% By default the long Uribe-A MH stage is included.

if nargin < 1, run_mh = true; end

build_data;
run_initial_irf_24;
run_uribe_A_estimation_24(run_mh);
run_uribe_B_estimation_24;
if run_mh
    run_point1_postprocessing_24;
end

disp('Core estimation workflow completed.');
disp('All point-1 post-processing was completed when run_mh=true.');
end
