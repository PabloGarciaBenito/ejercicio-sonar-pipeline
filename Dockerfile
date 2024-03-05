FROM ubuntu

RUN apt-get update && \
    apt-get -y install maven \
     unzip \
     curl
RUN curl -O https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-5.0.1.3006-linux.zip && \
    mkdir sonar
RUN unzip sonar-scanner-cli-5.0.1.3006-linux.zip -d sonar
