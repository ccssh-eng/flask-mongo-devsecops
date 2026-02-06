pipeline {
  agent none

  environment {
    DOCKER_IMAGE = "scedric/flask-mongo-devsecops"
  }

  stages {

    stage('Checkout') {
      agent any
      steps {
        checkout scm
      }
    }

    stage('Lint') {
      agent {
        docker {
          image 'python:3.11-slim'
        }
      }
      steps {
        sh '''
          python -m pip install flake8
          python -m flake8 app tests
        '''
      }
    }

    stage('Tests') {
      agent {
        docker {
          image 'python:3.11-slim'
        }
      }
      steps {
        sh '''
          python -m pip install -r requirements.txt pytest
          python -m pytest -v
        '''
      }
    }

    stage('SonarQube Analysis') {
      agent {
        docker {
          image 'sonarsource/sonar-scanner-cli'
        }
      }
      steps {
        withSonarQubeEnv('sonar-ovh') {
          sh 'sonar-scanner'
        }
      }
    }

    stage('Docker Build & Push') {
      agent {
        docker {
          image 'docker:27-cli'
          args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
      }
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
