pipeline {
    agent any

    // This tells Jenkins to automatically put terraform in the command path
    tools {
        terraform 'terraform' 
    }

    environment {
        AWS_CRED = credentials('aws-keys')
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
    steps {
        withEnv(["AWS_ACCESS_KEY_ID=${AWS_CRED_USR}", "AWS_SECRET_ACCESS_KEY=${AWS_CRED_PSW}"]) {
            bat "terraform init -reconfigure"
        }
    }
}

        stage('Terraform Plan') {
            steps {
                withEnv(["AWS_ACCESS_KEY_ID=${AWS_CRED_USR}", "AWS_SECRET_ACCESS_KEY=${AWS_CRED_PSW}"]) {
                    bat "terraform plan -out=tfplan"
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withEnv(["AWS_ACCESS_KEY_ID=${AWS_CRED_USR}", "AWS_SECRET_ACCESS_KEY=${AWS_CRED_PSW}"]) {
                    bat "terraform apply -auto-approve tfplan"
                }
            }
        }
    }

    post {
        failure {
            echo 'Infrastructure provisioning failed.'
        }
    }
}
