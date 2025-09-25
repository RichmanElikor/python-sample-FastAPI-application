pipeline {
  agent any

  environment {
    DOCKER_HUB_REPO = 'RichmanElikor/fastapi'
  }

  stage{
    stage('Checkout'){
      steps{
        git branch: 'main', url: 'https://github.com/RichmanElikor/python-sample-FastAPI-application/actions'
      }
    }
    stage('Build Docker Image'){
      steps{
        sh 'docker build -t ${DOCKER_HUB_REPO}:latest .'
      }
    }
    stage('Push Docker image'){
      steps{
        withDockerRegistry([ credentialsId: 'dockerhub', url: '' ]) {
          sh 'docker push ${DOCKER_HUB_REPO}:latest'
      }
    }
    }
    }
  }
