pipeline {
    agent {
        dockerfile {
          filename 'Dockerfile'
        }
    }
    stages {
        stage('Build') {
            steps {
              sh 'node --version'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
              sh 'docker run -p 80:80 greenroute-frontend:v1'
            }
        }
    }
}
