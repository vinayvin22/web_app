pipeline {
  agent any

  environment {
    DOCKER_IMAGE = 'vinay2222dev/mini-webapp'  // Replace with your Docker Hub username/image
    KUBE_DEPLOYMENT = 'mini-webapp-deployment'          // Must match your Kubernetes deployment name
    KUBE_NAMESPACE = 'default'                           // Kubernetes namespace used
  }

  stages {
    stage('Checkout') {
      steps {
        git url: 'https://github.com/vinayvin22/mini-webapp-project.git'  // Replace with your GitHub repo URL
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          docker.build("${env.DOCKER_IMAGE}:latest")
        }
      }
    }

    stage('Push Docker Image') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          script {
            docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-credentials') {
              docker.image("${env.DOCKER_IMAGE}:latest").push()
            }
          }
        }
      }
    }

    stage('Deploy to Kubernetes') {
      steps {
        script {
          // This updates the deployment image to the new image and waits for rollout
          sh """
            kubectl set image deployment/${env.KUBE_DEPLOYMENT} mini-webapp=${env.DOCKER_IMAGE}:latest -n ${env.KUBE_NAMESPACE}
            kubectl rollout status deployment/${env.KUBE_DEPLOYMENT} -n ${env.KUBE_NAMESPACE}
          """
        }
      }
    }
  }
}