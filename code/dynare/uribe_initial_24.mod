// Initial point-1 IRF: one parameter vector combining Table 4 and Table 5.
@#define MODEL = 0
@#define ESTIMATION = 0
@#define INCLUDE_EST_COMMAND = 0
@#define IRF_PARAMETER_FILE = 0
@#define INCLUDE_PRIORS = 0
@#define SMOOTHER = 0
@#include "uribe_24_model_core.inc"

// One standard-deviation innovation is used for the diagnostic run. The
// parameter vector is unchanged; the shock normalization is made explicit.
shocks;
    var eps_xi;    stderr 1;
    var eps_theta; stderr 1;
    var eps_z;     stderr 1;
    var eps_g;     stderr 1;
    var eps_zm;    stderr 0.25/sigma_zm;
    var eps_zm2;   stderr 0.25/sigma_zm2;
    var eps_gm;    stderr 0.25/sigma_gm;
end;

stoch_simul(periods=0, order=1, irf=21, nograph);
save uribe_initial_24_irf_results oo_ M_ options_;
