pipeline {
  agent none
  stages {
    stage('Build') {
      agent {
        dockerfile {
          filename 'Dockerfile'
        }

      }
      steps {
        sh 'docker build -t greenroute-frontend:v1 .'
      }
    }
    stage('Deploy') {
      steps {
        sh 'docker run -p 8081:8080 greenroute-frontend:v1'
      }
    }
  }
}