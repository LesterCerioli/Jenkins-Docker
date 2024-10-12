
FROM jenkins/jenkins:lts


USER root


RUN apt-get update && \
    apt-get install -y sudo && \
    apt-get clean


USER jenkins


EXPOSE 8080


CMD ["jenkins"]
