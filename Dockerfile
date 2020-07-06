FROM python:3.7-slim

RUN apt-get update && \
    apt-get --assume-yes install graphviz

WORKDIR build
RUN mkdir results
ADD requirements.txt /build/requirements.txt

# create venv and install reqs
RUN python -m venv dcec
RUN dcec/bin/pip install -r requirements.txt

# Add files
ADD *.py /build/

CMD ["dcec/bin/python", "DCEC.py", "mnist"]
