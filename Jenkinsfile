pipeline {
  agent {
    docker {
      image 'python:3.11-slim'
      args '-u root'
    }
  }

  environment {
    DOCKER_IMAGE = "scedric/flask-mongo-devsecops"
  }

  stages {
    stage('Lint') {
      steps {  sh '''
                python3 -m pip install --user flake8
                python3 -m flake8 app tests
               ''' 
      }
    }

    stage('Tests') {
      steps { sh '''
               python3 -m pip install --user -r requirements.txt pytest
               python3 -m pytest -v
              ''' 
      }
    }

    stage('Sonar') {
      steps { sh 'sonar-scanner' }
    }

    stage('Docker') {
      steps {
        sh 'docker build -t user/flask-api .'
        sh 'docker push user/flask-api'
      }
    }
  }
}
