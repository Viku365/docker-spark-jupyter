# Dockerfile
 
# Usa una imagen base de Jupyter con Python 3.9
FROM jupyter/base-notebook:python-3.9
 
# Variables de entorno
ENV SPARK_VERSION=3.5.3
ENV HADOOP_VERSION=3
ENV SPARK_HOME=/opt/spark
ENV PATH="$SPARK_HOME/bin:$PATH"
 
# Instalar dependencias y Java
USER root
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk && \
    apt-get clean
 
# Descargar e instalar Spark
RUN wget https://downloads.apache.org/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz && \
    tar -xzf spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz -C /opt/ && \
    mv /opt/spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION $SPARK_HOME && \
    rm spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz
 
# Instalar JupyterLab, Apache Toree y findspark
RUN pip install jupyterlab findspark && \
    pip install toree && \
    jupyter toree install --spark_home=$SPARK_HOME --interpreters=Scala --user
 
# Crear un kernel de PySpark en Jupyter
RUN python -m ipykernel install --user --name=pyspark --display-name "PySpark"
 
RUN sudo mkdir -p /home/jovyan/.local/share/jupyter && \
    chown -R $NB_UID:$NB_GID /home/jovyan/.local
 
 
 
# Cambiar de nuevo al usuario original
USER $NB_UID
 
# Establece el puerto para JupyterLab
EXPOSE 8888
 
# Inicia JupyterLab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]