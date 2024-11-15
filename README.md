# Guía de Inicio: Dockerfile para Apache Spark con Ejemplos en PySpark y Scala

## Descripción

Esta guía proporciona una introducción completa para configurar un entorno de Apache Spark utilizando Docker. Incluye instrucciones detalladas para construir y ejecutar un contenedor Docker con Apache Spark, además de ejemplos prácticos en PySpark y Scala que se pueden ejecutar en Jupyter Notebook. Esta guía es ideal para quienes desean experimentar con Apache Spark de una manera rápida y sencilla, utilizando Docker para crear un entorno aislado y reproducible.

## Requisitos Previos

- Docker instalado en tu sistema. Puedes descargar Docker desde [docker.com](https://www.docker.com/products/docker-desktop).
- Conexión a internet para descargar las dependencias necesarias.

## Instrucciones para Construir y Ejecutar el Entorno

### Paso 1: Preparar el Dockerfile

Asegúrate de tener un archivo `Dockerfile` en tu directorio de trabajo. Este archivo debe contener todas las instrucciones necesarias para crear una imagen de Docker que incluya Apache Spark, PySpark y el entorno para Scala.

### Paso 2: Construir la Imagen de Docker

Ejecuta el siguiente comando para construir la imagen Docker:

```bash
docker build -t spark-env .
```

Esto construirá la imagen Docker utilizando el `Dockerfile` y le asignará el nombre `spark-env`.

### Paso 3: Ejecutar el Contenedor

Para ejecutar el contenedor Docker:

```bash
docker run -it --name spark-container spark-env
```

Esto iniciará el contenedor interactivo.

## Instalación de Dependencias Adicionales

Para usar PySpark correctamente, necesitas importar y inicializar `findspark`:

```python
import findspark
findspark.init()
```

## Ejemplos Prácticos en PySpark y Scala

### Ejemplo en PySpark

1. Ejecuta el siguiente código para iniciar PySpark:

```python
import findspark
findspark.init()

from pyspark.sql import SparkSession

# Crear una sesión de Spark
spark = SparkSession.builder.appName("Ejemplo PySpark").getOrCreate()

# Crear un DataFrame simple
datos = [("Alice", 29), ("Bob", 35), ("Cathy", 23)]
df = spark.createDataFrame(datos, ["Nombre", "Edad"])

# Mostrar el DataFrame
df.show()
```

2. Aplica una transformación para filtrar los datos:

```python
# Filtrar personas mayores de 25 años
df_filtrado = df.filter(df["Edad"] > 25)
df_filtrado.show()
```

### Ejemplo en Scala

1. Ejecuta el siguiente código:

```scala
import org.apache.spark.sql.SparkSession

// Crear una sesión de Spark
val spark = SparkSession.builder.appName("Ejemplo Scala").getOrCreate()
import spark.implicits._

// Crear un RDD con datos de ejemplo
val datos = Seq(("Alice", 29), ("Bob", 35), ("Cathy", 23))
val rdd = spark.sparkContext.parallelize(datos)

// Convertir el RDD a un DataFrame
val df = rdd.toDF("Nombre", "Edad")

// Mostrar el DataFrame
df.show()
```

2. Filtra los datos para mostrar solo las personas mayores de 25 años:

```scala
df.filter($"Edad" > 25).show()
```

## Finalizar el Contenedor

Cuando termines de trabajar, puedes detener el contenedor ejecutando:

```bash
docker stop spark-container
```

Y si ya no lo necesitas, puedes eliminarlo con:

```bash
docker rm spark-container
```

## Resumen

Esta guía te permitirá construir un entorno de Apache Spark usando Docker y ejecutar ejemplos prácticos en PySpark y Scala. Puedes expandir estos ejemplos a proyectos más complejos según tus necesidades.

## Recursos Adicionales

- [Documentación oficial de Apache Spark](https://spark.apache.org/docs/latest/)
- [Docker: Guía de inicio](https://docs.docker.com/get-started/)

Si tienes alguna duda o necesitas más información, no dudes en consultar los enlaces proporcionados o buscar ayuda en la comunidad de Apache Spark.

