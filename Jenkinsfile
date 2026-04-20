pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                // Change 'your-id-goes-here' to your actual Jenkins Credential ID
                withCredentials([usernamePassword(credentialsId: 'aws-keys', 
                                 passwordVariable: 'AWS_SECRET_ACCESS_KEY', 
                                 usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
                    bat 'terraform init -reconfigure'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws-keys', 
                                 passwordVariable: 'AWS_SECRET_ACCESS_KEY', 
                                 usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
                    bat 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws-keys', 
                                 passwordVariable: 'AWS_SECRET_ACCESS_KEY', 
                                 usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
                    bat 'terraform apply -input=false tfplan'
                }
            }
        }
    }

    post {
        always {
            // This ensures the workspace is cleaned even if the build fails
            cleanWs()
        }
    }
}
