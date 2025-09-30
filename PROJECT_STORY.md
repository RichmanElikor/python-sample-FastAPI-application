# 🚀 FastAPI CI/CD and Kubernetes Project Journey

This project was a hands-on experience in building a **CI/CD pipeline** for a simple FastAPI application, containerizing it with Docker, automating builds and pushes using Jenkins, and finally deploying it to Kubernetes for scalability.

---

## 📌 Project Workflow

1. **Cloned a sample FastAPI application**.
2. **Tested the app locally** using `uvicorn`.
3. **Wrote a Dockerfile** to containerize the app.
4. **Ran the container locally** and tested accessibility from the browser.
5. **Created a Jenkins pipeline** to:

   * Build the Docker image
   * Push the image to Docker Hub
6. **Deployed the containerized app on Kubernetes** (Minikube).
7. Verified app scalability using **Kubernetes services and deployment replicas**.

---

## ⚠️ Problems Faced & How I Solved Them

### 1. Missing `requirements.txt`

* **Problem:** The project used a `Pipfile` instead of `requirements.txt`.
* **Fix:** Installed dependencies via `pipenv install` inside the container and updated the Dockerfile to:

  ```dockerfile
  RUN pipenv install --system --deploy --ignore-pipfile
  ```

---

### 2. FastAPI default route returning 404

* **Problem:** Running tests with `pytest` failed because `/` route wasn’t defined.
* **Fix:** Realized the application didn’t have a root endpoint. Adjusted tests and confirmed it was not a bug in the pipeline.

---

### 3. Dockerfile port mismatch

* **Problem:** Unsure of which port the app was listening on (`127.0.0.1:8000`).
* **Fix:** Specified `EXPOSE 8000` in the Dockerfile and ran the container with:

  ```bash
  docker run -d -p 8000:8000 --name fastapi richman100/fastapi:latest
  ```

---

### 4. Jenkins Pipeline Syntax Errors

* **Problem:** Initial Jenkinsfile failed with errors like:

  * *“Missing required section 'stages’”*
  * *“Undefined section 'stage’”*
* **Fix:** Corrected syntax to include proper `pipeline { stages { stage { ... } } }` structure.

---

### 5. DockerHub Credentials in Jenkins

* **Problem:** Jenkins could not push to Docker Hub because credentials were only saved in GitHub.
* **Fix:** Added **Docker Hub credentials** directly in Jenkins (Manage Jenkins → Credentials). Used them in pipeline via:

  ```groovy
  withDockerRegistry([credentialsId: 'dockerhub', url: 'https://index.docker.io/v1/'])
  ```

---

### 6. Duplicate Images on Docker Hub

* **Problem:** Each commit overwrote the `latest` tag, leading to confusion.
* **Fix:** Implemented commit-specific tags using Jenkins environment variables:

  ```groovy
  docker build -t ${DOCKER_HUB_REPO}:${GIT_COMMIT} .
  docker push ${DOCKER_HUB_REPO}:${GIT_COMMIT}
  ```

---

### 7. Kubernetes Pod Stuck in “ContainerCreating”

* **Problem:** Pods remained in `ContainerCreating` because Minikube couldn’t pull image from Docker Hub.
* **Fix:** There was an image  name mismatch in the deployment file, which I checked and corrected-- richman100/fastapi


  This allowed Kubernetes to pull the right image from my dockerhub .

---


## ✅ Final Outcome

* A FastAPI application **containerized with Docker**.
* **Automated CI/CD pipeline in Jenkins** that builds and pushes images.
* **Deployment on Kubernetes** (Minikube) with service exposure and scaling.
* Successfully debugged and solved multiple real-world DevOps issues (credentials, ports, probes, ContainerCreating errors, pipeline syntax).

---

## 📚 Key Learnings

* Handling `Pipfile` vs `requirements.txt` in Docker builds.
* Debugging `pytest` failures.
* Jenkins pipeline syntax and credential management.
* DockerHub tagging strategies to avoid duplicates.
* Kubernetes pod troubleshooting (`kubectl describe`, imagePull issues).
* Importance of readiness & liveness probes.

---

This project taught me **end-to-end DevOps workflow** from development to deployment, reinforcing skills in **CI/CD, Docker, Jenkins, and Kubernetes**.
