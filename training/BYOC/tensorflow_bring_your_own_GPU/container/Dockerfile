FROM 763104351884.dkr.ecr.us-east-1.amazonaws.com/tensorflow-training:1.15.3-gpu-py37-cu100-ubuntu18.04

#FROM tensorflow/tensorflow:1.8.0-py3

RUN apt-get update && apt-get install -y --no-install-recommends nginx curl

# Download TensorFlow Serving
# https://www.tensorflow.org/serving/setup#installing_the_modelserver
RUN echo "deb [arch=amd64] http://storage.googleapis.com/tensorflow-serving-apt stable tensorflow-model-server tensorflow-model-server-universal" | tee /etc/apt/sources.list.d/tensorflow-serving.list
RUN curl https://storage.googleapis.com/tensorflow-serving-apt/tensorflow-serving.release.pub.gpg | apt-key add -
RUN apt-get update && apt-get install tensorflow-model-server

ENV PATH="/opt/ml/code:${PATH}"

# /opt/ml and all subdirectories are utilized by SageMaker, we use the /code subdirectory to store our user code.
COPY /cifar10 /opt/ml/code
WORKDIR /opt/ml/code
ENV SAGEMAKER_PROGRAM train.py