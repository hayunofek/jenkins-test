pipeline {
  agent any

  stages {  // Define the individual processes, or stages, of your CI pipeline
    stage('Checkout') { // Checkout (git clone ...) the projects repository
      steps {
        checkout scm
      }
    }
    stage('Build & Run') { // Install any dependencies you need to perform testing
      steps {
        script {
          sh """
          docker build -t test:latest .
          docker run test:latest
          """
        }
      }
    }
  }  
}