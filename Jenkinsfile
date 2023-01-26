pipeline {
    agent any
    stages {
        stage('Run python') {
            steps {
                sh '
                  docker build -t my-app:latest .
                  docker run my-app:latest
                '
            }
        }
    }
}