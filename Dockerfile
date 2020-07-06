FROM python:3.7-slim

ENV GOOGLE_APPLICATION_CREDENTIALS=/build/paap-key.json
ENV SERVICE_EMAIL=paap-crawl@art-auction-prices.iam.gserviceaccount.com

RUN apt-get update && \
    apt-get --assume-yes install graphviz apt-transport-https ca-certificates gnupg curl

# Add gcloud sdk distribution URI
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
# Import Google Cloud Public Key
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

# Install gcloud
RUN apt-get update && apt-get --assume-yes install google-cloud-sdk

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

RUN gcloud auth activate-service-account $SERVICE_EMAIL --key-file=$GOOGLE_APPLICATION_CREDENTIALS

# CMD ["dcec/bin/python", "DCEC.py", "mnist"]
CMD ["bash", "run_model.sh"]
