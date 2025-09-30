pipeline {
    agent any

    environment {
        DOCKER_HUB_REPO = 'richman100/fastapi'
    }
// Define the stages of the pipeline
    stages {
        // Checkout the code from the Git repository
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/RichmanElikor/python-sample-FastAPI-application.git'
            }
        }
// Build the Docker image
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${DOCKER_HUB_REPO}:latest .'
            }
        }
// Push the Docker image to Docker Hub
        stage('Push Docker Image') {
            steps {
                withDockerRegistry([ credentialsId: 'dockerhub', url: 'https://index.docker.io/v1/' ]) {
                    sh 'docker push ${DOCKER_HUB_REPO}:latest'
                }
            }
        }
    }
}
