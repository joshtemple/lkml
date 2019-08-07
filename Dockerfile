ARG PYTHON_VERSION=${PYTHON_VERSION:-3.7.3}
FROM circleci/python:${PYTHON_VERSION}

ENV PATH="/home/circleci/.local/bin:${PATH}"

WORKDIR /workdir

COPY requirements.txt /workdir

RUN pip install -r requirements.txt --user
