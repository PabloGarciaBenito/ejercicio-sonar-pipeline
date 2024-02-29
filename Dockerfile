FROM centos:7

RUN yum -y install maven https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm postgresql unzip
RUN curl -O https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-5.0.1.3006-linux.zip
RUN unzip sonar-scanner-cli-5.0.1.3006-linux.zip 
