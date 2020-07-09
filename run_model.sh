#!/usr/bin/env bash

set -ex

echo "test" > /tmp/test.txt
gsutil cp /tmp/test.txt gs://paap/nn/dcec/

# # Run the model
# python3 /build/DCEC.py mnist
# # Copy the results to GCS
# gsutil -m cp results/temp/** gs://paap/nn/dcec/results/temp
