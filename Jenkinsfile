node {
  stage('Checkout') {
    git 'https://github.com/PabloGarciaBenito/sonar-ejercicio.git'
  }

  stage('Build'){
    
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