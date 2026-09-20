// ================================================================
// Uribe TP3 — common exact 24-equation model
//
// MODEL = 0 : full model used for the initial Table 4 + Table 5 IRF
// MODEL = 1 : Uribe-A, gm active and zm2 fixed at zero
// MODEL = 2 : Uribe-B, gm fixed at zero and zm2 persistent
//
// ESTIMATION = 0 : core 24-equation model only
// ESTIMATION = 1 : core model plus four observation equations
// ================================================================


// ---------------------------------------------------------------
// Endogenous variables
// ---------------------------------------------------------------

var gy irate_pai_diff girate gpai
    y h la w mu paitilde irate pai
    yback zm2back paitildeback paiback irateback
    xi theta z g zm zm2 gm;

@#if ESTIMATION == 1
var obs_dy obs_r obs_di obs_dpi;
@#endif

predetermined_variables yback zm2back paitildeback paiback irateback;


// ---------------------------------------------------------------
// Exogenous innovations
// ---------------------------------------------------------------

@#if MODEL == 0
varexo eps_xi eps_theta eps_z eps_g eps_zm eps_zm2 eps_gm;
@#elseif MODEL == 1
varexo eps_xi eps_theta eps_z eps_g eps_zm eps_gm;
@#elseif MODEL == 2
varexo eps_xi eps_theta eps_z eps_g eps_zm eps_zm2;
@#endif


// ---------------------------------------------------------------
// Parameters
// ---------------------------------------------------------------

parameters beta delta sigma chi alpha eta phi gamma_m
           alpha_pi alpha_y gamma_I
           gbar thetabar gmbar markup_ss
           rho_xi rho_theta rho_z rho_g rho_zm
           sigma_xi sigma_theta sigma_z sigma_g sigma_zm
           meas_dy meas_r meas_di;

@#if MODEL == 0
parameters rho_zm2 rho_gm sigma_zm2 sigma_gm;
@#elseif MODEL == 1
parameters rho_gm sigma_gm;
@#elseif MODEL == 2
parameters sigma_zm2;
@#endif


// ---------------------------------------------------------------
// Calibration: Table 4 plus posterior means of Table 5
// ---------------------------------------------------------------

@#if IRF_PARAMETER_FILE == 0
// Table 4: parameters taken as calibrated in the paper.
beta      = 0.9982;
sigma     = 2;
eta       = 6;
alpha     = 0.75;
gbar      = 0.004131;
thetabar  = 0.4055;
chi       = 0.625;
gmbar     = 0;

// Table 5: posterior means for the parameters estimated in the paper.
phi       = 146;
alpha_pi  = 2.32;
alpha_y   = 0.188;
gamma_m   = 0.606;
gamma_I   = 0.242;
delta     = 0.258;

rho_xi    = 0.915;
rho_theta = 0.708;
rho_z     = 0.700;
rho_g     = 0.221;
rho_zm    = 0.306;

sigma_xi    = 2.87;
sigma_theta = 0.164;
sigma_z     = 0.124;
sigma_g     = 0.758;
sigma_zm    = 0.0832;
meas_dy     = 0.2111871208;
meas_r      = 0.2133072901;
meas_di     = 0.0417133072;

@#if MODEL == 0
rho_zm2   = 0.796;
rho_gm    = 0.248;
sigma_zm2 = 0.131;
sigma_gm  = 0.0848;
@#elseif MODEL == 1
rho_gm    = 0.248;
sigma_gm  = 0.0848;
@#elseif MODEL == 2
// Uribe-B fixes the persistence of the transitory target shock.
// sigma_zm2 remains estimated in the B estimation.
sigma_zm2 = 0.131;
@#endif

markup_ss = eta/(eta-1);
@#else
// A MATLAB post-processing script writes this file from an estimation result.
// It is used only when computing IRF at an estimated parameter vector.
@#include "uribe_24_irf_parameters.inc"
@#endif


// ---------------------------------------------------------------
// Exact 24-equation system from nk_model.m
// ---------------------------------------------------------------

model;

    // Local steady-state expressions. Since they depend on estimated
    // parameters, Dynare recomputes them at every parameter draw.
    #h_ss = alpha/
           (exp(thetabar)*(alpha + markup_ss*chi
           *(1-delta*exp(-gbar))));
    #y_ss = h_ss^alpha;
    #i_ss = exp(gmbar + sigma*gbar)/beta - 1;
    #A_ss = (1+i_ss)/(y_ss^alpha_y);
    #irate_ss = 1+i_ss;
    #gy_ss = exp(gbar);

    // (1) Marginal utility of consumption
    la = exp(xi)
         *(y-delta*yback*exp(-g))^(-sigma)
         *(1-exp(theta)*h)^(chi*(1-sigma));

    // (2) Labor supply
    w = chi*exp(theta)
        *(y-delta*yback*exp(-g))
        /(1-exp(theta)*h);

    // (3) Euler equation
    la = beta*(1+irate)*la(+1)
         /(1+pai(+1))*exp(-gm(+1)-sigma*g(+1));

    // (4) Production
    y = exp(z)*h^alpha;

    // (5) Labor demand and markup
    w = alpha*exp(z)*h^(alpha-1)/mu;

    // (6) Rotemberg Phillips curve
    -eta*y*(1/markup_ss-1/mu)
    -phi/(1+paitilde)*(1+pai)
       *((1+pai)/(1+paitilde)-1)
    +phi*beta*exp((1-sigma)*g(+1))*la(+1)/la
       /(1+paitilde(+1))*(1+pai(+1))
       *((1+pai(+1))/(1+paitilde(+1))-1)
    = 0;

    // (7) Taylor rule in the stationary representation
    (1+irate)/exp(zm2)
    = (A_ss*((1+pai)/exp(zm2))^alpha_pi*y^alpha_y)^(1-gamma_I)
      *((1+irateback)/exp(zm2back))^gamma_I
      *exp(zm);

    // (8) Gross inflation growth
    gpai = (1+pai)/(1+paiback)*exp(gm);

    // (9) Gross nominal-interest-rate growth
    girate = (1+irate)/(1+irateback)*exp(gm);

    // (10) Gross output growth
    gy = y/yback*exp(g);

    // (11) Preference shock
    xi = rho_xi*xi(-1) + sigma_xi/100*eps_xi;

    // (12) Labor-supply shock, centered at the Table 4 mean
    theta = (1-rho_theta)*thetabar
            + rho_theta*theta(-1) + sigma_theta/100*eps_theta;

    // (13) Trend-growth shock, centered at the Table 4 mean
    g = (1-rho_g)*gbar + rho_g*g(-1) + sigma_g/100*eps_g;

    // (14) Stationary technology shock
    z = rho_z*z(-1) + sigma_z/100*eps_z;

@#if MODEL == 0
    // (15) Permanent monetary-target growth shock
    gm = rho_gm*gm(-1) + sigma_gm/100*eps_gm;
@#elseif MODEL == 1
    // (15) Uribe-A: the permanent target shock is active
    gm = rho_gm*gm(-1) + sigma_gm/100*eps_gm;
@#elseif MODEL == 2
    // (15) Uribe-B: retain the common state, but fix it at zero.
    gm = 0;
@#endif

    // (16) Transitory monetary shock
    zm = rho_zm*zm(-1) + sigma_zm/100*eps_zm;

    // (17) Inflation lag state
    paiback(+1) = pai;

    // (18) Nominal-interest-rate lag state
    irateback(+1) = irate;

    // (19) Output lag state
    yback(+1) = y;

    // (20) Inflation-reference equation
    1+paitilde = exp(-gamma_m*gm)
                 *(1+paitildeback)^gamma_m
                 *(1+pai)^(1-gamma_m);

    // (21) Inflation-reference lag state
    paitildeback(+1) = paitilde;

    // (22) Gross real-interest-rate ratio
    irate_pai_diff = (1+irate)/(1+pai);

@#if MODEL == 0
    // (23) Transitory inflation-target shock
    zm2 = rho_zm2*zm2(-1) + sigma_zm2/100*eps_zm2;
@#elseif MODEL == 1
    // (23) Uribe-A excludes the transitory target shock
    zm2 = 0;
@#elseif MODEL == 2
    // (23) Uribe-B fixes rho_zm2 at 0.999 and estimates sigma_zm2
    zm2 = 0.999*zm2(-1) + sigma_zm2/100*eps_zm2;
@#endif

    // (24) Lag state for the transitory target shock
    zm2back(+1) = zm2;

@#if ESTIMATION == 1
    // Measurement layer. These four equations do not alter the 24-equation
    // economic system; they map its variables into the TP3 observables.
    obs_dy  = 100*log(gy/gy_ss);
    obs_r   = 100*log(irate_pai_diff/irate_ss);
    obs_di  = 100*log(girate);
    obs_dpi = 100*log(gpai);
@#endif

end;


// ---------------------------------------------------------------
// Steady state
// ---------------------------------------------------------------

steady_state_model;

    h = alpha/
        (exp(thetabar)*(alpha + markup_ss*chi
        *(1-delta*exp(-gbar))));
    y = h^alpha;
    la = ((1-delta*exp(-gbar))*y)^(-sigma)
         *(1-exp(thetabar)*h)^(chi*(1-sigma));
    w = alpha*h^(alpha-1)/markup_ss;
    mu = markup_ss;

    pai       = 0;
    paitilde  = 0;
    irate     = exp(gmbar + sigma*gbar)/beta - 1;

    yback        = y;
    paiback      = pai;
    paitildeback = paitilde;
    irateback    = irate;
    zm2back      = 0;

    xi    = 0;
    theta = thetabar;
    z     = 0;
    g     = gbar;
    zm    = 0;
    zm2   = 0;
    gm    = gmbar;

    gy             = exp(gbar);
    irate_pai_diff = 1+irate;
    girate         = exp(gmbar);
    gpai           = exp(gmbar);

@#if ESTIMATION == 1
    obs_dy  = 0;
    obs_r   = 0;
    obs_di  = 0;
    obs_dpi = 0;
@#endif

end;


// Keep this check before estimation so a failed steady state is visible
// independently of the optimizer.
steady;
resid;
check;


@#if ESTIMATION == 1
// ---------------------------------------------------------------
// Observation layer and priors
// ---------------------------------------------------------------

varobs obs_dy obs_r obs_di;

shocks;
    var eps_xi;    stderr 1;
    var eps_theta; stderr 1;
    var eps_z;     stderr 1;
    var eps_g;     stderr 1;
    var eps_zm;    stderr 1;
@#if MODEL == 0 || MODEL == 1
    var eps_gm;    stderr 1;
@#endif
@#if MODEL == 0 || MODEL == 2
    var eps_zm2;   stderr 1;
@#endif
@#if SMOOTHER == 1
    var obs_dy;  stderr meas_dy;
    var obs_r;   stderr meas_r;
    var obs_di;  stderr meas_di;
@#endif
end;

@#if INCLUDE_PRIORS == 1
estimated_params;

    // Structural priors from the replication setup.
    phi,       , , , gamma_pdf,   50,       20;
    alpha_pi,  , , , gamma_pdf,   1.5,      0.25;
    alpha_y,   , , , gamma_pdf,   0.125,    0.1;
    gamma_m,   , , , uniform_pdf, 0.5,      1/sqrt(12);
    gamma_I,   , , , uniform_pdf, 0.5,      1/sqrt(12);
    delta,     , , , uniform_pdf, 0.5,      1/sqrt(12);

    rho_xi,    , , , beta_pdf,    0.7,      0.2;
    rho_theta, , , , beta_pdf,    0.7,      0.2;
    rho_z,     , , , beta_pdf,    0.7,      0.2;
    rho_g,     , , , beta_pdf,    0.3,      0.2;
    rho_zm,    , , , beta_pdf,    0.3,      0.2;

@#if MODEL == 0 || MODEL == 1
    rho_gm,    , , , beta_pdf,    0.3,      0.2;
@#endif

    // The TP3 asks for normal priors on the 100-scaled sigma parameters.
    // The lower bound is imposed during mode finding.
    sigma_xi,    , 0, , normal_pdf, 1,    1;
    sigma_theta, , 0, , normal_pdf, 1,    1;
    sigma_z,     , 0, , normal_pdf, 1,    1;
    sigma_g,     , 0, , normal_pdf, 1,    1;
    sigma_zm,    , 0, , normal_pdf, 0.25, 0.25;

@#if MODEL == 0 || MODEL == 1
    sigma_gm,    , 0, , normal_pdf, 0.25, 0.25;
@#endif
@#if MODEL == 0 || MODEL == 2
    sigma_zm2,   , 0, , normal_pdf, 0.25, 0.25;
@#endif

    // Dynare estimates stderr(obs_*) rather than R_ii directly.
    // These are the corresponding sqrt(R_ii) priors used for the
    // measurement-error standard deviations in the TP3 implementation.
    stderr obs_dy, , 0, , normal_pdf, 0.1943323469, 0.0560989164;
    stderr obs_r,  , 0, , normal_pdf, 0.1441669465, 0.0416174127;
    stderr obs_di, , 0, , normal_pdf, 0.0485348024, 0.0140107906;

end;

estimated_params_init;
    phi,       146;
    alpha_pi,  2.32;
    alpha_y,   0.188;
    gamma_m,   0.606;
    gamma_I,   0.242;
    delta,     0.258;
    rho_xi,    0.915;
    rho_theta, 0.708;
    rho_z,     0.700;
    rho_g,     0.221;
    rho_zm,    0.306;
    sigma_xi,  2.87;
    sigma_theta, 0.164;
    sigma_z,   0.124;
    sigma_g,   0.758;
    sigma_zm,  0.0832;

@#if MODEL == 0 || MODEL == 1
    rho_gm,    0.248;
    sigma_gm,  0.0848;
@#endif
@#if MODEL == 0 || MODEL == 2
    sigma_zm2, 0.131;
@#endif

    stderr obs_dy, 0.2111871208;
    stderr obs_r,  0.2133072901;
    stderr obs_di, 0.0417133072;
end;
@#endif

@#if INCLUDE_EST_COMMAND == 1
@#if MODEL == 1
// Uribe-A, mode_compute=5: first posterior-mode estimation.
estimation(datafile='../../data/processed/uribe_data_pp.mat',
           first_obs=1, nobs=255,
           mode_compute=5, mode_check, cova_compute=1,
           mh_replic=0, plot_priors=1);
save uribe_A_24_mode5_results oo_ M_ options_;
@#elseif MODEL == 2
// Uribe-B: the TP3 requests mode_compute=5 only.
estimation(datafile='../../data/processed/uribe_data_pp.mat',
           first_obs=1, nobs=255,
           mode_compute=5, mode_check, cova_compute=1,
           mh_replic=0, plot_priors=1);
save uribe_B_24_mode5_results oo_ M_ options_;
@#endif
@#endif
@#endif
