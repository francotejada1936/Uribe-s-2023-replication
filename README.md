# TP3 — Uribe's Neo-Fisherian New Keynesian Model

This repository contains a reproducible implementation of Point 1 of the
Macrometrics TP3. The project estimates Uribe's model and computes impulse
responses, variance decompositions, and a smoothed inflation series following
the order of the assignment.

## Assignment workflow

1. **Initial IRFs:** one parameter vector combines the calibrated parameters
   from Table 4 with the posterior means from Table 5. This is one set of IRFs,
   not two separate exercises. The three monetary shocks used in Figures 11–12
   are `gm`, `zm2`, and `zm`.
2. **Uribe-A:** the permanent monetary-target shock is active. The posterior
   mode is computed with `mode_compute=5`, then with `mode_compute=6`, followed
   by the Metropolis–Hastings estimation. The IRFs use `gm` and `zm`.
3. **Uribe-B:** the permanent monetary-target shock is removed and the
   persistence of the transitory target shock is fixed at `rho_zm2=0.999`.
   Only the posterior mode with `mode_compute=5` is estimated, as required by
   the assignment. The IRFs use `zm2` and `zm`.
4. For each requested parameterization, the project computes responses of
   output, inflation, the nominal interest rate, and the real interest rate;
   variance decompositions for output growth, inflation changes, and the
   nominal interest rate; and smoothed inflation based on the smoothed change
   in inflation.

## Repository structure

```text
code/
  dynare/              Dynare models and equation blocks
  matlab/              Data preparation, estimation, and post-processing
  reference_original/  Original Uribe replication files
data/
  raw/                 Original Excel files
  processed/           Data generated for Dynare
results/               Tables, figures, and selected estimation outputs
docs/                  Technical notes and workflow documentation
```

## Requirements

- MATLAB
- Dynare 7.0, or a compatible version

The original replication files and the three input Excel files are preserved
for reference. The TP3 scripts are separated under `code/dynare` and
`code/matlab`.

## Reproducing the results

From MATLAB, move to `code/matlab` and run:

```matlab
build_data
run_initial_irf_24
run_uribe_A_estimation_24(true)
run_uribe_B_estimation_24
run_point1_postprocessing_24
```

The Uribe-A MH stage uses one million replications and may take a substantial
amount of time. It is kept separate from the mode estimation so that the
workflow remains transparent and reproducible.

The complete workflow can also be run with:

```matlab
run_all_point1(true)
```

Use `run_all_point1(false)` to skip the long MH stage. In that case, the
post-processing that requires the MH posterior mean cannot be completed until
the MH estimation results are available.

## The economic model

The model is based on the exact 24-equation system in Uribe's `nk_model.m`.
The auxiliary variables `yback`, `zm2back`, `paitildeback`, `paiback`, and
`irateback` represent lagged states from the original system. The variables
`gy`, `gpai`, `girate`, and `irate_pai_diff` are endogenous transformations
used for observables and impulse responses.

For estimation, four measurement equations are added for `obs_dy`, `obs_r`,
`obs_di`, and `obs_dpi`. Thus, the estimation files contain 24 economic
equations plus four measurement equations; the economic system itself is not
changed.

Variable names are kept consistent throughout the project:

| Name | Interpretation |
|---|---|
| `pai` | Gross stationary inflation |
| `irate` | Gross stationary nominal interest rate |
| `irate_pai_diff` | Contemporary nominal-rate minus inflation differential |
| `gpai` | Gross price growth |
| `girate` | Gross nominal-rate growth |
| `gy` | Gross output growth |

The real interest-rate IRF is constructed as the nominal interest rate minus
expected inflation in the following period, following the transformation used
by the original `nk_irfs.m` file. It is not taken directly from
`irate_pai_diff`.

The quarterly smoothed change in inflation is multiplied by four before being
accumulated onto the annualized inflation series.

## Uribe-A and Uribe-B

In **Uribe-A**, `gm` and its innovation are active and its parameters are
estimated. The `zm2` shock is fixed at zero.

In **Uribe-B**, `gm` is fixed at zero to preserve the same 24-equation
representation, but it has no innovation and no estimated parameters. The
`zm2` process is active with:

```text
rho_zm2 = 0.999
```

and `sigma_zm2` is estimated.

## Data and parameter scaling

Growth and inflation observables are expressed in quarterly percentage-point
units where appropriate. The transformations and divisions by 100 are
documented in the Dynare files and in `data/README.md`.

## Status

The final reproducible version is based on Uribe's 24-equation system. The
earlier 23-equation prototypes are not part of the final workflow.

For instructions on publishing this project as a public GitHub repository,
see [`docs/GITHUB_PUBLISHING.md`](docs/GITHUB_PUBLISHING.md).
