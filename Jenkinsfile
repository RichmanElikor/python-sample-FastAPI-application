pipeline {
agent any

```
environment {
    DOCKER_HUB_REPO = 'richman100/fastapi'
}

stages {
    stage('Checkout') {
        steps {
            git branch: 'master', url: 'https://github.com/RichmanElikor/python-sample-FastAPI-application.git'
        }
    }

    stage('Build Docker Image') {
        steps {
            script {
                sh """
                    docker build -t ${DOCKER_HUB_REPO}:latest .
                    docker tag ${DOCKER_HUB_REPO}:latest ${DOCKER_HUB_REPO}:build-${BUILD_NUMBER}
                """
            }
        }
    }

    stage('Push Docker Image') {
        steps {
            withDockerRegistry([ credentialsId: 'dockerhub', url: 'https://index.docker.io/v1/' ]) {
                retry(3) {
                    sh """
                        docker push ${DOCKER_HUB_REPO}:latest
                        docker push ${DOCKER_HUB_REPO}:build-${BUILD_NUMBER}
                    """
                }
            }
        }
    }
}
```

}
