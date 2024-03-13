node {
  stage('Checkout') {
    checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: '/var/jenkins_home/workspace/prueba/dockerfile']], userRemoteConfigs: [[url: 'https://github.com/PabloGarciaBenito/ejercicio-sonar-pipeline.git']]])
    checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: '/var/jenkins_home/workspace/prueba/app']], userRemoteConfigs: [[url: 'https://github.com/PabloGarciaBenito/sonar-ejercicio']]])
  }

  stage('Build'){
    sh 'docker build -t prueba-sonar:$BUILD_TAG /var/jenkins_home/workspace/prueba/dockerfile/'
  }

  stage('Compile') {
    sh 'docker run --rm --network jenkins_net -v /home/jenkins/jenkins/jenkins_home/workspace/prueba/app/:/app -v /home/jenkins/jenkins/jenkins_home/.m2/:/root/.m2 -w /app prueba-sonar:$BUILD_TAG mvn clean compile package'
  }
  stage('SonarQube Analysis') {
    sh 'docker run --rm --network jenkins_net -v /home/jenkins/jenkins/jenkins_home/workspace/prueba/app/:/app -w /app prueba-sonar:$BUILD_TAG /sonar/sonar-scanner-5.0.1.3006-linux/bin/sonar-scanner -Dsonar.token=squ_9b54903cd6ee845ae7e2eb5dce4ef9fe4af23c89 -Dsonar.projectKey=prueba -Dsonar.java.binaries=target/ -Dsonar.host.url=http://172.18.0.6:9000'
  }
  stage('Nexus'){
    sh 'docker run --rm --network jenkins_net -v /home/jenkins/jenkins/jenkins_home/workspace/prueba/app/:/app -v /home/jenkins/jenkins/jenkins_home/.m2/:/root/.m2 -w /app prueba-sonar:$BUILD_TAG mvn deploy -DgeneratePom=false'
  }
  stage('Copiar artefacto'){
    checkout([$class: 'GitSCM', branches: [[name: '*/prueba']], extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: '/var/jenkins_home/workspace/prueba/copiar-artefacto']], userRemoteConfigs: [[url: 'https://github.com/PabloGarciaBenito/ejercicio-sonar-pipeline.git']]])
    sh 'cp /var/jenkins_home/workspace/prueba/app/target/*.jar /var/jenkins_home/workspace/prueba/copiar-artefacto/'
    sh 'docker build -t copiar-artefacto:$BUILD_TAG /var/jenkins_home/workspace/prueba/copiar-artefacto/'
  }
  stage('Dependency-check') {
    dependencyCheck additionalArguments: '--scan /var/jenkins_home/workspace/prueba/app/ --connectionString jdbc:postgresql://172.18.0.3:5432/dependencycheck -l logs.txt --dbUser=postgres --dbPassword=postgres --out . --dbDriverName=org.postgresql.Driver', odcInstallation: 'dependency-check v9.0.8'
    dependencyCheckPublisher pattern: 'dependency-check-report.xml'
  }
}