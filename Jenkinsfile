pipeline {
    agent any

    environment {
        DOCKER_HUB_REPO = 'richmanelikor/fastapi'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/RichmanElikor/python-sample-FastAPI-application.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${DOCKER_HUB_REPO}:latest .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withDockerRegistry([ credentialsId: 'dockerhub', url: 'https://index.docker.io/v1/' ]) {
                    sh 'docker push ${DOCKER_HUB_REPO}:latest'
                }
            }
        }
    }
}
