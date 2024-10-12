# Use the Jenkins base image with JDK 17
FROM jenkins/jenkins:2.452.2-jdk17

# Switch to the root user to install packages
USER root

# Update the package list and install required packages
RUN apt-get update && \
    apt-get install -y lsb-release python3-pip python3-venv

# Add the GPG key for the Docker repository
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc https://download.docker.com/linux/debian/gpg

# Add the Docker repository to the apt sources list
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.asc] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

# Update the package list and install Docker CLI
RUN apt-get update && apt-get install -y docker-ce-cli

# Create a virtual environment for Python
RUN python3 -m venv /opt/venv

# Upgrade pip and install Redis Python client in the virtual environment
RUN /opt/venv/bin/pip install --upgrade pip && \
    /opt/venv/bin/pip install redis

# Copy the Groovy script to configure the administrator
COPY init.groovy.d /var/jenkins_home/init.groovy.d

# Set permissions for the Jenkins directory
RUN chown -R jenkins:jenkins /var/jenkins_home && \
    chmod -R 755 /var/jenkins_home

# Switch back to the Jenkins user
USER jenkins

# Install necessary Jenkins plugins
RUN jenkins-plugin-cli --plugins "blueocean docker-workflow azure-credentials azure-vm-agents azure-app-service azure-artifact-manager"

# Expose port 8080
EXPOSE 8080

# Create a volume for the home directory
VOLUME /var/jenkins_home
