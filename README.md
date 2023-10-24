# Visualize Night Light Comparison with R
### Carlos Marcos | Octubre 2023

Este proyecto se centra en la visualización de la comparación de luces nocturnas por país utilizando R. El código se basa en un tutorial de Milos Popovic.

Los datos utilizados en este proyecto fueron obtenidos del sitio web del [Earth Observation Group ](https://payneinstitute.mines.edu/eog/). Utilizando la tecnología VIIRS han generado una nueva serie de datos anuales de luces nocturnas globales . Estos datos abarcan desde 2012 hasta 2020.

Actualmente utilizan una metodología basada en la generación de imágenes mensuales de luces nocturnas libres de nubes que luego se combinan para obtener un resumen anual. Ambos métodos incluyen la eliminación de puntos atípicos para eliminar datos de incendios y aislar el fondo. Sin embargo, la nueva metodología utiliza la mediana de doce meses para eliminar los valores extremadamente altos o bajos en lugar de un enfoque basado en gráficos.

Además, prestan especial atención a la definición de un umbral de datos de fondo, que se adapta a los niveles de cobertura de nubes. El objetivo es detectar la iluminación en cada celda de 15 segundos de arco de manera consistente a lo largo de los años en la serie de datos.

En recientes estudios se destaca la posibilidad de estimar la relación (elasticidad) entre las luces nocturnas registradas por satélite y la actividad económica del área observada. La elasticidad estimada es de 1.55 para mercados emergentes y economías en desarrollo, lo que significa que un aumento del 1 por ciento en el producto interno bruto (PIB) se asocia con un aumento del 1.55 por ciento en las luces nocturnas. De esta manera se pueden estimar la variación de la actividad económica cuando otros indicadores no están disponibles o evaluar la coherencia de los valores publicados por un país o región en base a este indicador independiente.

## Requisitos
Asegúrate de tener las siguientes bibliotecas instaladas antes de ejecutar el código:
- tidyverse
- terra
- sf
- giscoR

## DEMO
El código anterior crea mapas de comparación de luces nocturnas por país para los años 2012 y 2022. Puedes encontrar las imágenes resultantes en este repositorio para Argentina y otros países.
Para Argentina, comparando los años 2012 y 2022, solo el desarrollo de Vaca Muerta, un extenso yacimiento de hidrocarburos no convencionales ubicado en la cuenca Neuquina, parece marcar la diferencia.
![Pantalla general](plots/ar_map_cities_2012.png)
![Pantalla general](plots/ar_map_cities_2022.png)

### Países limítrofes
Dentro de la carpeta *plots* podrás encontrar la visualización comparativa entre los mismos años para países limítrofes a Argentina.

### Gifs
Una sencilla forma de visualizar la diferencia es utilizar un archivo gifs mediante la transición de la imagen para el año inicial y el final. Podrás encontrar estos archivos para los mismos países en la carpeta *gifs*.
Para generarlos se utilizó la aplicación Photoshop en su versión 6.

El siguiente ejemplo ilustra el resultado obtenido para Argentina:
![Pantalla general](gifs/AR_map_2012-2022.gif)
