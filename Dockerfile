FROM centos:7

RUN yum -y install maven https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm postgresql unzip
RUN yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm postgresql 
 curl -O https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-10.4.1.88267.zip
 unzip sonarqube-10.4.1.88267.zip
