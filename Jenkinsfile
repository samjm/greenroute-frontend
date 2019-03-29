pipeline {
    agent {
        dockerfile {
          filename 'Dockerfile'
        }
    stages {
        stage('Build') {
            steps {
              sh 'docker build -t greenroute-frontend:v1 .'
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
