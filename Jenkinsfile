pipeline {
    agent any

    environment {
        // Define your Docker Hub credentials using Jenkins credentials
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials-id')
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/jaskiratbrar/jenkins-ci-web.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using the Dockerfile from the repository
                    def dockerImage = docker.build("my_web_app_image:${env.BUILD_ID}", "-f Dockerfile .")
                    env.IMAGE_NAME = "my_web_app_image:${env.BUILD_ID}"
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    // Tag the Docker image with Docker Hub repository name
                    sh "docker tag ${env.IMAGE_NAME} ${DOCKER_HUB_USERNAME}/${DOCKER_HUB_REPOSITORY}:${env.BUILD_ID}"
                    sh "docker tag ${env.IMAGE_NAME} ${DOCKER_HUB_USERNAME}/${DOCKER_HUB_REPOSITORY}:latest"
                }

                // Log in to Docker Hub using Jenkins credentials
                withCredentials([string(credentialsId: 'docker-hub-credentials-id', variable: 'DOCKER_HUB_PASSWORD')]) {
                    sh "docker login -u ${DOCKER_HUB_USERNAME} -p ${DOCKER_HUB_PASSWORD}"
                }

                // Push the Docker image to Docker Hub
                sh "docker push ${DOCKER_HUB_USERNAME}/${DOCKER_HUB_REPOSITORY}:${env.BUILD_ID}"
                sh "docker push ${DOCKER_HUB_USERNAME}/${DOCKER_HUB_REPOSITORY}:latest"
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    sh "docker run -p 8000:80 -d --name my_web_app_container ${env.IMAGE_NAME}"
                }
            }
        }
    }
}

