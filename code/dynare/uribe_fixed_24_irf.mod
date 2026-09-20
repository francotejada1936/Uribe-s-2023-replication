// Fixed-parameter IRF driver.
// run_fixed_24_irfs.m writes uribe_24_irf_parameters.inc before calling this.
@#define MODEL = 1
@#define ESTIMATION = 0
@#define INCLUDE_EST_COMMAND = 0
@#define IRF_PARAMETER_FILE = 1
@#define INCLUDE_PRIORS = 0
@#define SMOOTHER = 0
@#include "uribe_24_model_core.inc"

shocks;
    var eps_xi;    stderr 1;
    var eps_theta; stderr 1;
    var eps_z;     stderr 1;
    var eps_g;     stderr 1;
    var eps_zm;    stderr 0.25/sigma_zm;
    var eps_gm;    stderr 0.25/sigma_gm;
end;

stoch_simul(periods=0, order=1, irf=21, nograph);
save uribe_fixed_24_irf_results oo_ M_ options_;
