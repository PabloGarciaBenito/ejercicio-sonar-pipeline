node {
  stage('Checkout') {
    checkout([$class: 'GitSCM', branches: [[name: '*/desarrollo']], extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: '/var/jenkins_home/workspace/prueba2/dockerfile']], userRemoteConfigs: [[url: 'https://github.com/PabloGarciaBenito/ejercicio-sonar-pipeline.git']]])
    checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: '/var/jenkins_home/workspace/prueba2/app']], userRemoteConfigs: [[url: 'https://github.com/PabloGarciaBenito/ejercicio-sonar-pipeline.git']]])
  }

  stage('Build'){
    sh 'docker build -t prueba-sonar:$BUILD_TAG /home/jenkins/jenkins/jenkins_home/workspace/prueba2/dockerfile/'
  }
  stage('SonarQube Analysis') {
    def mvn = tool 'jenkins-maven';
    def scannerHome = tool 'SonarQube Scanner'
    withSonarQubeEnv(credentialsId: 'sonar') {
      sh "${mvn}/bin/mvn clean compile verify sonar:sonar -Dsonar.token=sqa_c461a16bde6691b763d6f9d981e983e430a63fd3"
      sh "${scannerHome}/bin/sonar-scanner -Dsonar.token=sqa_c461a16bde6691b763d6f9d981e983e430a63fd3 -Dsonar.projectKey=1a -Dsonar.exclusions=/home/jenkins/jenkins/jenkins_home/workspace/prueba/src/ -Dsonar.java.binaries=target/"
    }
  }
}