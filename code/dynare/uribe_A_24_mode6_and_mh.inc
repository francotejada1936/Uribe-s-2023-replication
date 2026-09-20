// This file shares the exact model and priors with uribe_A_24_mode5.mod.
// It is separate only because the TP3 requires mode_compute=6 for the MH step.
@#define INCLUDE_EST_COMMAND = 0
@#define IRF_PARAMETER_FILE = 0
@#define INCLUDE_PRIORS = 1
@#define SMOOTHER = 0
@#include "uribe_24_model_core.inc"

@#if A_STAGE == 6
estimation(datafile='../../data/processed/uribe_data_pp.mat',
           first_obs=1, nobs=255,
           mode_compute=6, cova_compute=1,
           mh_replic=0, plot_priors=1);
save uribe_A_24_mode6_results oo_ M_ options_;
@#elseif A_STAGE == 7
estimation(datafile='../../data/processed/uribe_data_pp.mat',
           first_obs=1, nobs=255,
           mode_compute=6, cova_compute=1,
           mh_replic=1000000, mh_nblocks=1, mh_drop=0.5,
           plot_priors=1);
save uribe_A_24_mh_results oo_ M_ options_;
@#endif
