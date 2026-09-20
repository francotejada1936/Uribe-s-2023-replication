# Publicar el proyecto en GitHub

Esta guía deja el punto 1 del TP3 como un repositorio público, reproducible y
compartible. El repositorio debe contener el código, los datos de entrada, la
documentación y los resultados finales seleccionados; no debe contener la
cadena completa del MH ni archivos generados por Dynare que puedan regenerarse.

## 1. Preparar la carpeta local

Usar como carpeta del proyecto la raíz de este paquete, es decir, la carpeta
que contiene `README.md`, `code`, `data`, `docs` y `results`. No usar como raíz
la carpeta `code/dynare`.

Antes de publicar, verificar que estén disponibles los resultados que se
quieren compartir:

```text
results/initial_irf/
results/uribe_A/
results/uribe_B/
results/uribe_24_variance_decomposition.csv
results/uribe_24_variance_decomposition.pdf
results/uribe_24_smoothed_inflation.csv
results/uribe_24_smoothed_inflation.pdf
```

Si todavía no están, correr en MATLAB:

```matlab
cd('.../uribe_tp3_point1_reproducible/code/matlab')
run_point1_postprocessing_24
```

Esto reutiliza las estimaciones guardadas. No vuelve a correr el MH.

## 2. Revisar qué se va a publicar

Desde PowerShell, Git Bash o una terminal ubicada en la raíz del proyecto:

```bash
git status --short
git add -n .
```

El segundo comando es una vista previa: muestra qué archivos agregaría Git,
pero no modifica nada. Confirmar especialmente que no aparezcan archivos de
cadenas `metropolis`, carpetas temporales de Dynare ni archivos personales.

## 3. Crear el repositorio en GitHub

En [github.com](https://github.com), seleccionar **New repository**.

- Elegir la cuenta personal o la organización del grupo.
- Usar un nombre, por ejemplo `uribe-neo-fisher-tp3`.
- Escribir una breve descripción.
- Seleccionar **Public**.
- No marcar la creación automática de README, `.gitignore` ni licencia,
  porque esos archivos ya están en esta carpeta.
- Crear el repositorio vacío.

## 4. Inicializar y subir el proyecto

Reemplazar `USUARIO` por el nombre de usuario de GitHub y ejecutar desde la
raíz local del proyecto:

```bash
git init
git branch -M main
git add .
git status
git commit -m "Add reproducible Uribe TP3 point 1 replication"
git remote add origin https://github.com/USUARIO/uribe-neo-fisher-tp3.git
git push -u origin main
```

Si GitHub solicita autenticación por HTTPS, usar el mecanismo de autenticación
que ofrezca GitHub; una contraseña normal de la cuenta no reemplaza un token.

## 5. Comprobar el repositorio público

Abrir la URL del repositorio en una ventana donde no esté iniciada la sesión y
comprobar que se puedan ver:

- `README.md`;
- los modelos `.mod` y el bloque `uribe_24_model_core.inc`;
- los scripts MATLAB;
- los Excel de `data/raw`;
- las tablas y figuras finales que se hayan decidido compartir.

El README debe permitir que otra persona entienda el orden de la consigna y
reproduzca el flujo con MATLAB y Dynare.

## Qué no subir

- la cadena completa del MH de un millón de iteraciones;
- carpetas `metropolis` o archivos temporales generados por Dynare;
- rutas locales de Windows, logs de trabajo que contengan información
  personal o archivos de MATLAB innecesarios;
- prototipos anteriores de 23 ecuaciones.

Los logs finales de mode 5, mode 6 y MH pueden conservarse si se desea
documentar la corrida, pero no son necesarios para reproducirla.

## Licencia

No agregar una licencia por cuenta propia si el grupo todavía no decidió qué
licencia usar. Un repositorio puede ser público sin incluir una licencia, pero
eso no equivale a otorgar permisos explícitos de reutilización.
