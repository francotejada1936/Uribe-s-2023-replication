# Workflow notes

## Why the final files use 24 equations

The economic model is copied from the ordering in `reference_original/nk_model.m`.
The auxiliary states are not cosmetic: they make explicit the lagged variables
that appear in the original first-order system. The final core therefore has
the following 24 equations:

1. household marginal utility;
2. labor supply;
3. Euler equation;
4. production;
5. labor demand;
6. Rotemberg Phillips curve;
7. monetary policy rule;
8–10. growth definitions;
11–16. structural shock processes;
17–21. lag-state transitions;
22. real-rate definition;
23–24. transitory-target shock and its lag state.

Dynare estimation additionally requires endogenous variables for the observed
series. The final estimation files therefore add four measurement equations:
`obs_dy`, `obs_r`, `obs_di`, and `obs_dpi`. The last one is constructed for
smoothing but is not declared in `varobs`, because the TP3 estimates only the
three series in the data matrix.

## Initial IRF

`uribe_initial_24.mod` uses the Table 4 calibration for the calibrated
parameters and the Table 5 posterior means for the parameters reported as
estimated in the paper. This is one parameterization. It includes the three
shocks used in the initial replication: `gm`, `zm2` and `zm`. The shocks are
normalized so the monetary innovations have a 0.25 percentage-point quarterly
impact, matching the original `nk_irfs.m` convention.

For the estimated alternatives, Uribe-A uses `gm` and `zm`, whereas Uribe-B
uses `zm2` and `zm`. These are not two alternative estimates of the same
model: they correspond to the restrictions defining A and B in the TP3.

The real-rate IRF is constructed as the nominal-rate response at time `t`
minus the expected inflation response at `t+1`, as in the original
replication code. The contemporaneous auxiliary variable `irate_pai_diff` is
not used for this figure.

## Estimation order

The Uribe-A sequence is deliberately split into three files:

- `uribe_A_24_mode5.mod`: first mode required by the TP3;
- `uribe_A_24_mode6.mod`: mode from `mode_compute=6`, without MH, used for the
  mode comparison;
- `uribe_A_24_mh.mod`: `mode_compute=6`, `mh_replic=1000000`, one block and
  `mh_drop=0.5`.

The MH stage is not a second model. It is a sampling step around the posterior
mode. Its posterior mean is the third parameter vector used for the fixed-
parameter IRFs and the diagnostics.

Uribe-B has its own exact-core file and uses only `mode_compute=5`. The common
state `gm` is fixed to zero so that the 24-equation representation remains
comparable. It has no innovation and no estimated `rho_gm` or `sigma_gm`.
The transitory target shock instead follows `rho_zm2=0.999`, while
`sigma_zm2` is estimated.

## Fixed-parameter post-processing

`run_fixed_24_irfs` reads the saved Dynare objects and writes their parameter
values to `uribe_24_irf_parameters.inc`. It then executes the core once per
parameterization. This is why the IRFs use the estimated modes/posterior mean
without launching another estimation.

The smoother uses the same mechanism, additionally fixing the estimated
measurement-error standard deviations. It calls `calib_smoother` only for
`obs_dpi`, so it does not launch another estimation or an interactive variable
selector. The smoothed change in inflation is `obs_dpi`; the smoothed inflation
level is reconstructed in annualized units as:

```text
smoothed_dpi_annualized(t) = 4 * smoothed_dpi_quarterly(t)
smoothed_pai(t) = observed_pai(1) + cumulative sum of smoothed_dpi_annualized
```

with the first observation used as the level anchor. This factor of four is
necessary because `pai` is annualized while `obs_dpi` is quarterly.
