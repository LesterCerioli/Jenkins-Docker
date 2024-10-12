### Jenkins Deployment on Kubernetes


###### This repository contains the files and instructions to deploy a Jenkins server on a Kubernetes cluster. The setup uses a custom Jenkins Docker image, tservices/jenkins:1.0.1, and exposes the Jenkins web UI and agent ports through a NodePort service.

#### Prerequisites

Ensure that the following tools and resources are available:

- A Kubernetes cluster (Minikube, Docker Desktop, or any cloud provider)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) installed
- [Docker](https://docs.docker.com/get-docker/) installed (if building a custom Jenkins image)
- Jenkins Docker image (`tservices/jenkins:1.0.1`)
- Ports `8080` (web) and `50000` (agent) should be available

## Setup Instructions

1. Clone the Repository

First, clone the repository where this `README.md` and the Kubernetes YAML files are located.

```bash
git clone https://github.com/your-repo/jenkins-k8s.git
cd jenkins-k8s


2. Deploy Jenkins on Kubernetes

Use the provided YAML file to create the Jenkins deployment and service.

```bash
kubectl apply -f jenkins-deployment.yaml

3. Verify the Jenkins Pod
Ensure that the Jenkins pod is running by executing the following command:

```bash
kubectl get pods

4. Check the Service

```bash
This Markdown code includes the code blocks and descriptions shown in your screenshot. Let me know if you need any more adjustments!


