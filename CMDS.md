# Commands (For interacting with Google Cloud)

```sh
# Configure Docker to be able to push to GCR
gcloud auth configure-docker
# tag an image
docker tag dcec:local gcr.io/art-auction-prices/dcec
docker push gcr.io/art-auction-prices/dcec

# List images
gcloud container images list

# Deploy a vm that does something
export MODEL=dcec
gcloud compute instances create-with-container $MODEL-1 \
    # --accelerator count=1,type=nividia-tesla-k80 \
    # --container-env-file \
    --container-image=gcr.io/art-auction-prices/dcec \
    --container-restart-policy=never \
    --description="VM for model: ${MODEL}" \
    --preemptible \
    --machine-type=n1-standard-1 \
    --scopes=storage-rw

gcloud compute instances list
```

# Running a container locally

https://cloud.google.com/ai-platform/deep-learning-containers/docs/getting-started-local

```sh
docker run -d -p 8080:8080 -v /Users/dubs/dev/dcec:/home \
    gcr.io/deeplearning-platform-release/tf2-cpu.2-2
```

```sh
# Tagging
export PROJECT_ID=$(gcloud config list project --format "value(core.project)")
export IMAGE=dcec-k8s
export IMAGE_TAG=$(date +%Y%m%d_%H%M%S)
export IMAGE_URI=gcr.io/$PROJECT_ID/$IMAGE:$IMAGE_TAG

docker build -f Dockerfile -t $IMAGE_URI ./

docker push $IMAGE_URI
```

```sh
# Create a cluster
gcloud container clusters create paap-training-cluster \
    --num-nodes=1 \
    --zone=us-west1-b \
    # --accelerator="type=nvidia-tesla-t4,count=1" \
    --machine-type="n1-highmem-2" \
    --scopes="gke-default,storage-rw"
    --preemptible

# installing GPU nodes
# https://cloud.google.com/kubernetes-engine/docs/how-to/gpus#ubuntu
```



https://cloud.google.com/ai-platform/training/docs/using-containers
https://cloud.google.com/ai-platform/deep-learning-vm/docs/cli
https://cloud.google.com/ai-platform/deep-learning-vm/docs/introduction?hl=sk


