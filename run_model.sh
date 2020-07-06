#!/usr/bin/env bash

set -ex

echo "test" > /tmp/test.txt
gsutil cp /tmp/test.txt gs://paap/nn/dcec/
