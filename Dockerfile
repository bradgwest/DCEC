FROM gcr.io/deeplearning-platform-release/tf2-cpu.2-2:latest

ENV SERVICE_EMAIL=paap-crawl@art-auction-prices.iam.gserviceaccount.com
ENV GCLOUD_PROJECT=art-auction-prices

RUN gcloud config set project $GCLOUD_PROJECT

# Install graphviz for plotting models
RUN apt-get update && apt-get -y install graphviz

WORKDIR build
RUN mkdir results
ADD requirements.txt /build/requirements.txt
ADD paap-key.json /build/paap-key.json
ADD run_model.sh /build/run_model.sh

# create venv and install reqs
RUN python -m venv dcec
RUN dcec/bin/pip install -r requirements.txt

# Add files
ADD *.py /build/

RUN gcloud auth activate-service-account $SERVICE_EMAIL --key-file=/build/paap-key.json

CMD ["dcec/bin/python", "DCEC.py", "mnist"]
# CMD ["bash", "run_model.sh"]
