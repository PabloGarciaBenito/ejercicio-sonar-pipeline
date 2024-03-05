node {
  stage('Checkout') {
    checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: '/var/jenkins_home/workspace/prueba/dockerfile']], userRemoteConfigs: [[url: 'https://github.com/PabloGarciaBenito/ejercicio-sonar-pipeline.git']]])
    checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: '/var/jenkins_home/workspace/prueba/app']], userRemoteConfigs: [[url: 'https://github.com/PabloGarciaBenito/sonar-ejercicio']]])
  }

  stage('Build'){
    sh 'docker build -t prueba-sonar:$BUILD_TAG /var/jenkins_home/workspace/prueba/dockerfile/ --no-cache'
  }

  stage('Compile') {
    sh 'docker run --rm -v /home/jenkins/jenkins/jenkins_home/workspace/prueba/app/:/app -w /app prueba-sonar:$BUILD_TAG mvn clean compile package'
  }
  stage('SonarQube Analysis') {
    sh 'docker run --rm --network jenkins_net -v /home/jenkins/jenkins/jenkins_home/workspace/prueba/app/:/app -w /app prueba-sonar:$BUILD_TAG /sonar/sonar-scanner-5.0.1.3006-linux/bin/sonar-scanner -Dsonar.token=sqa_c461a16bde6691b763d6f9d981e983e430a63fd3 -Dsonar.projectKey=prueba -Dsonar.java.binaries=target/ -Dsonar.host.url=http://172.18.0.5:9000'
  }
  stage('Nexus'){
    sh 'docker run --rm --network jenkins_net -v /home/jenkins/jenkins/jenkins_home/workspace/prueba/app/:/app -v /home/jenkins/jenkins/jenkins_home/.m2/:/root/.m2 -w /app prueba-sonar:$BUILD_TAG mvn deploy -DgeneratePom=false'
  }
}