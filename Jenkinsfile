node {
  stage('SCM') {
    checkout scm
  }
  stage('SonarQube Analysis') {
    def mvn = tool 'jenkins-maven';
    withSonarQubeEnv(credentialsId: 'sonar') {
      sh "${mvn}/bin/mvn clean verify sonar:sonar -Dsonar.token=sqa_c461a16bde6691b763d6f9d981e983e430a63fd3"
    }
  }
}