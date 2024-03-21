node {
  stage('Checkout') {
    checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: '/var/jenkins_home/workspace/prueba/dockerfile']], userRemoteConfigs: [[url: 'https://github.com/PabloGarciaBenito/ejercicio-sonar-pipeline.git']]])
    checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: '/var/jenkins_home/workspace/prueba/app']], userRemoteConfigs: [[url: 'https://github.com/PabloGarciaBenito/sonar-ejercicio']]])
  }

  stage('Build'){
    sh 'docker build -t prueba-sonar:$BUILD_TAG /var/jenkins_home/workspace/prueba/dockerfile/'
  }

  stage('Compile') {
    sh 'docker run --rm --network jenkins_net -v /home/jenkins/jenkins/jenkins_home/workspace/prueba/app/:/app -v /home/jenkins/jenkins/jenkins_home/.m2/:/root/.m2 -w /app prueba-sonar:$BUILD_TAG mvn clean install'
    sh 'docker run --rm --network jenkins_net -v /home/jenkins/jenkins/jenkins_home/workspace/prueba/app/:/app -v /home/jenkins/jenkins/jenkins_home/.m2/:/root/.m2 -w /app prueba-sonar:$BUILD_TAG chown -R 1000:1000 target/ /root/.m2/'
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
    dependencyCheck additionalArguments: '--scan /var/jenkins_home/workspace/prueba/app/ --out . -n', odcInstallation: 'dependency-check v9.0.8'
    dependencyCheckPublisher pattern: 'dependency-check-report.xml'
  }

  stage('SonarQube Analysis') {
    def mvn = tool 'jenkins-maven';
    withSonarQubeEnv(credentialsId: 'sonar-token') {
      sh "${mvn}/bin/mvn -f /var/jenkins_home/workspace/prueba/app/pom.xml sonar:sonar -Dsonar.token=squ_9b54903cd6ee845ae7e2eb5dce4ef9fe4af23c89 -Dsonar.projectKey=prueba -Dsonar.dependencyCheck.htmlReportPath=target/dependency-check-report.html"
    }
  }
}