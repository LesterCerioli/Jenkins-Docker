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

5. Access Jenkins

- For Minikube:
Obtain the Minikube IP address:


```bash
minikube ip

Open http://<Minikube_IP>:32000 in your browser to access the Jenkins web UI.
- For Docker Desktop or other Kubernetes setups:
Open http://localhost:32000 in your browser to access Jenkins.

6. Retrieve Jenkins Admin Password

To retrieve the initial admin password needed to unlock Jenkins, you can run the following command:

```bash
kubectl logs <jenkins-pod-name>


Alternatively, you can extract the password directly from the Jenkins pod:

```bash
kubectl exec --namespace default -it <jenkins-pod-name> -- cat /var/jenkins_home/secrets/initialAdminPassword
Use the password to complete the initial Jenkins setup in the web UI.

7. Configure Jenkins
After unlocking Jenkins, follow the setup wizard to:


- Install the suggested plugins.
- Create the first admin user.
- Configure the instance.

Jenkins Kubernetes YAML Files

1. jenkins-deployment.yaml
This file defines the Jenkins deployment and service configuration.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: jenkins-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: jenkins
  template:
    metadata:
      labels:
        app: jenkins
    spec:
      containers:
        - name: jenkins
          image: tservices/jenkins:1.0.1  # Custom Jenkins image
          ports:
            - containerPort: 8080         # Jenkins Web UI
            - containerPort: 50000        # Jenkins agent port
---
apiVersion: v1
kind: Service
metadata:
  name: jenkins-service
spec:
  type: NodePort
  selector:
    app: jenkins
  ports:
    - protocol: TCP
      port: 8080         # Service port for web UI
      targetPort: 8080   # Container port for web UI
      nodePort: 32000    # NodePort for web UI (adjust if needed)
    - protocol: TCP
      port: 50000        # Service port for Jenkins agents
      targetPort: 50000  # Container port for agents
      nodePort: 32001    # NodePort for agents (adjust if needed)
