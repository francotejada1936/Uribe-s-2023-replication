// Fixed-parameter smoother for Uribe-B.
// The parameter include is written by run_24_smoothers.m.
@#define MODEL = 2
@#define ESTIMATION = 1
@#define INCLUDE_EST_COMMAND = 0
@#define INCLUDE_PRIORS = 0
@#define IRF_PARAMETER_FILE = 1
@#define SMOOTHER = 1
@#include "uribe_24_model_core.inc"

calib_smoother(datafile='../../data/processed/uribe_data_pp.mat',
               first_obs=1, nobs=255) obs_dpi;
save uribe_fixed_24_smoother_results oo_ M_ options_;
