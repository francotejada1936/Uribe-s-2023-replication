function run_point1_postprocessing_24()
%RUN_POINT1_POSTPROCESSING_24 Create all tables, IRFs and requested figures.

save_24_mode_tables;
run_fixed_24_irfs;
save_24_variance_decomposition;
plot_point1_irfs_24;
run_24_smoothers;

disp('Point-1 tables and figures were created.');
end
