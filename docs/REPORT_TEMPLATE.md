# Suggested empirical-economics presentation

## 1. Data and model

State the sample, the three estimated observables, the treatment of units and
the fact that the economic core is the 24-equation system from `nk_model.m`.

## 2. Initial IRF replication

Explain that Table 4 supplies the calibrated parameters and Table 5 supplies
the posterior means for the parameters estimated in the paper. Report one
set of IRFs for the three shocks in Figures 11–12: the permanent target-growth
shock `gm`, the transitory target shock `zm2`, and the direct monetary shock
`zm`.

## 3. Uribe-A estimation

Report the posterior mode from `mode_compute=5`, the mode from `mode_compute=6`
and the MH posterior mean. Include the mode-check graphs and the comparison
table. Then show the IRFs for `gm` and `zm`, as well as the requested variance
decompositions and smoothed inflation.

## 4. Uribe-B estimation

Explain the restriction on the permanent target shock and the calibration
`rho_zm2=0.999`. Report the mode, IRFs, variance decomposition and smoothed
inflation for Uribe-B.
Its IRFs use `zm2` and `zm`.

## 5. Interpretation and comparison with Uribe

Discuss the sign, persistence and long-run behavior of the responses. Keep
the comparison with the paper separate from the computational description.
The real-rate response is (i_t-E_t\pi_{t+1}). The code does not calculate
credible bands for the fixed-parameter IRFs, in accordance with the TP3
footnote.
