pipeline {
  agent any

  environment {
    DOCKER_IMAGE = "scedric/flask-mongo-devsecops"
  }

  stages {

    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Lint') {
      steps {
        sh '''
          pip3 install flake8
          flake8 app tests
        '''
      }
    }

    stage('Tests') {
      steps {
        sh '''
          pip3 install -r requirements.txt pytest
          pytest -v
        '''
      }
    }

    stage('SonarQube Analysis') {
      steps {
        withSonarQubeEnv('sonar-ovh') {
          sh 'sonar-scanner'
        }
      }
    }

    stage('Docker Build & Push') {
      steps {
        withCredentials([usernamePassword(
          credentialsId: 'dockerhub-creds',
          usernameVariable: 'DOCKER_USER',
          passwordVariable: 'DOCKER_PASS'
        )]) {
          sh '''
            docker login -u $DOCKER_USER -p $DOCKER_PASS
            docker build -t $DOCKER_IMAGE:latest .
            docker push $DOCKER_IMAGE:latest
          '''
        }
      }
    }
  }
}

