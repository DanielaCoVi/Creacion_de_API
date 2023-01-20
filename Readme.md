
# <h1 align=center> **PROYECTO INDIVIDUAL Nº1** </h1>

# <h1 align=center>*`Data Engineering`*</h1>

<p align="center">
<img src="https://www.hamk.fi/wp-content/uploads/2020/12/DataAnalytiikka-scaled.jpeg"  height=300>
</p>

### ¡Bienvenidos a este proyecto individual de la etapa de labs!
#### Rol: ***Data Engineer***.  

<hr>  

## <center>***Consigna***</center>

### <center> Se nos solicita elaborar las *transformaciones* requeridas y disponibilizar los datos mediante la *elaboración y ejecución de una API*.</center>

<hr>

<p align=center>
<img src = 'https://i0.wp.com/www.prodigio.tech/wp-content/uploads/2017/10/iStock-1227056524-scaled.jpg?fit=2880%2C1687&ssl=1' height=250><p>

<h1 align=center>
¿Qué es una API?</h1>


# <center> **Application Programming Interface _ó_ Interfaz de programación de aplicaciones** </center>

### Es una especie de puente que conecta diversos tipos de software o aplicaciones y puede crearse en varios lenguajes de programación.

<hr>


## <center> ***Nuestro rol a desarrollar*** </center>

### Como parte del equipo de data engineering se me asigna realizar la extracción, limpieza y carga de la data para la óptimización del desarrollo de sus actividades y disponibilizar los datos mediante la *implementación de una API*.


<hr>


## **Requerimientos para el tratamiento de los datos >>>**


+ Generar campo **`id`**: Cada id se compondrá de la primera letra del nombre de la plataforma, seguido del show_id ya presente en los datasets (ejemplo para títulos de Amazon = **`as123`**)

+ Los valores nulos del campo rating deberán reemplazarse por el string “**`G`**” (corresponde al maturity rating: “general for all audiences”

+ De haber fechas, deberán tener el formato **`AAAA-mm-dd`**

+ Los campos de texto deberán estar en **minúsculas**, sin excepciones

+ El campo ***duration*** debe convertirse en dos campos: **`duration_int`** y **`duration_type`**. El primero será un integer y el segundo un string indicando la unidad de medición de duración: min (minutos) o season (temporadas)

<br/>


## **Como se desarrollo >>>**

+ Se implimento el ETL y EDA con la librería pandas en visual studio code.

+ Se construyo la base de datos en MySQL Workbench, donde se implemento l creación de Procedure ó procedimientos para dearrollar las 5 consultas asignadas.

+ Se genero el enlace entre python y nuestra base de datos para realizar desde python la llamada de los procedimientos creadas.

+ Se genero las funciones y creación de la API con la librería FastAPI.

+ Se deployo con la herramienta Deta.

## **Nuestras consultas >>>**

+ Cantidad de veces que aparece una keyword en el título de peliculas/series, por plataforma (get_word_count).

+ Cantidad de películas por plataforma con un puntaje mayor a XX en determinado año (get_score_count).

+ La segunda película con mayor score para una plataforma determinada, según el orden alfabético de los títulos (get_second_score).

+ Película que más duró según año, plataforma y tipo de duración (get_longest)

+ Cantidad de series y películas por rating (get_rating_count).
<br/>





## **Herramientas utilizadas**

+ Visual Studio Code

+ Python

+ MySQL Workbench

+ FastAPI

+ Deta

<hr>

### Consigna realizada en: 


<p align=center><img src=https://d31uz8lwfmyn8g.cloudfront.net/Assets/logo-henry-white-lg.png><p>