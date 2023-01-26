FROM jenkins/jenkins:latest

ARG DOCKER_GID=48

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
COPY jenkins.yaml /var/jenkins_home/jenkins.yaml

USER 0

RUN apt-get update -y && apt-get install ca-certificates curl gnupg lsb-release -y

RUN mkdir -p /etc/apt/keyrings && curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
  echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && apt-get update -y && apt-get install docker-ce docker-ce-cli \
  containerd.io docker-compose-plugin -y

RUN usermod -a -G docker jenkins && groupadd -g $DOCKER_GID host-docker && usermod -aG host-docker jenkins

USER 1000

RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

ENV CASC_JENKINS_CONFIG /var/jenkins_home/jenkins.yaml