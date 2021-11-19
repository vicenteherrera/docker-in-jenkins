FROM jenkins/jenkins:2.321

USER root

RUN apt-get update \
      && apt-get install -y sudo \
      && apt-get install -y libc6 libc-bin \
      && apt-get install -y curl gnupg2 apt-transport-https git \
      && rm -rf /var/lib/apt/lists/*

RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

RUN curl -fsSL https://get.docker.com -o get-docker.sh \
      && sudo sh get-docker.sh \
      && rm get-docker.sh \
      && sudo usermod -aG docker jenkins

USER jenkins
