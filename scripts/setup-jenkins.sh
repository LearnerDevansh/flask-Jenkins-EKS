pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
    }

    stages {
        stage('Setup AWS Credentials') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials']]) {
                    sh 'aws sts get-caller-identity'
                    // Optionally validate cluster access
                    sh 'kubectl get nodes'
                }
            }
        }

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/LearnerDevansh/flask-Jenkins-EKS'
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("devanshpandey21/flask-app:latest")
                }

                withCredentials([usernamePassword(credentialsId: 'docker_hub_credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push devanshpandey21/flask-app:latest
                    '''
                }
            }
        }

        stage('Deploy to EKS') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials']]) {
                    sh 'kubectl apply -f k8s-manifests/deployment.yaml'
                    sh 'kubectl apply -f k8s-manifests/service.yaml'
                }
            }
        }
    }
}
