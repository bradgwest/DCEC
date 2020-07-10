#!/usr/bin/env bash

set -ex

# echo "test" > /tmp/test.txt
# gsutil cp /tmp/test.txt gs://paap/nn/dcec/

# Run the model
/build/dcec/bin/python /build/DCEC.py mnist --assert-gpu
# Copy the results to GCS
gsutil -m cp results/temp/** gs://paap/nn/dcec/results/temp
