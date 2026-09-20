# IRF, descomposición de varianza y suavización

## Parametrizaciones

El flujo respeta las tres etapas de la consigna:

1. `uribe_initial_24.mod` combina los parámetros calibrados de la Tabla 4
   con las medias posteriores de la Tabla 5. Esta réplica inicial incluye los
   tres shocks de las Figuras 11–12: `gm`, `zm2` y `zm`.
2. Uribe-A usa tres vectores estimados: mode 5, mode 6 y media posterior del
   MH. Como `zm2` está excluido, sus IRF utilizan `gm` y `zm`.
3. Uribe-B usa el modo de mode 5. Como `gm` está excluido y `zm2` tiene
   persistencia calibrada en 0.999, sus IRF utilizan `zm2` y `zm`.

Las IRF posteriores no vuelven a estimar el modelo. Los scripts cargan los
resultados de las estimaciones y fijan cada vector de parámetros en el mismo
sistema económico de 24 ecuaciones.

## Variables graficadas

Las cuatro respuestas son:

- producto;
- inflación;
- tasa de interés nominal;
- tasa de interés real ex ante.

Producto, inflación y tasa nominal se construyen acumulando las respuestas de
`gy`, `gpai` y `girate`, respectivamente. La tasa real se calcula como:

```text
i_t - E_t(pi_{t+1})
```

Esto reproduce la transformación utilizada por `nk_irfs.m` en el replication
package original. La variable contemporánea `irate_pai_diff` se conserva para
el modelo y los observables, pero no se utiliza directamente para la figura de
la tasa real.

## Ejecución

Desde `code/matlab`:

```matlab
run_initial_irf_24
run_fixed_24_irfs
plot_point1_irfs_24
```

El flujo completo de postprocesamiento —incluyendo tablas, descomposición y
suavización— es:

```matlab
run_point1_postprocessing_24
```

No se calculan bandas creíbles para estas IRF puntuales, de acuerdo con la
nota al pie de la consigna.

## Descomposición de varianza

Se descompone la varianza teórica de `gy`, `gpai` y `girate`, que corresponden
al cambio en producto, cambio en inflación y cambio en la tasa nominal. La
tasa real no forma parte de esta descomposición porque la consigna no la
solicita.

## Inflación suavizada

`obs_dpi` está expresado en puntos porcentuales trimestrales, mientras que la
inflación observada `pai` está anualizada. Por eso el procesamiento guarda
ambas unidades:

```text
smoothed_dpi_annualized = 4 * smoothed_dpi_quarterly
smoothed_pai(t) = pai(1) + cumulative_sum(smoothed_dpi_annualized)
```

El valor inicial observado de `pai` funciona como ancla para reconstruir el
nivel suavizado.

## Archivos principales

```text
results/initial_irf/uribe_initial_24_irfs.pdf
results/uribe_A/uribe_A_24_irfs.pdf
results/uribe_B/uribe_B_24_irfs.pdf
results/uribe_24_variance_decomposition.csv
results/uribe_24_variance_decomposition.pdf
results/uribe_24_smoothed_inflation.csv
results/uribe_24_smoothed_inflation.pdf
```
