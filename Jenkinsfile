pipeline {
    agent { dockerfile true }
    stages {
        stage('Run python') {
            steps {
                sh 'python3 main.py'
            }
        }
    }
}