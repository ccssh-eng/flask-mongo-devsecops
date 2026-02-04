pipeline {
  agent any
  stages {
    stage('Lint') {
      steps { sh 'flake8 .' }
    }
    stage('Tests') {
      steps { sh 'pytest' }
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
