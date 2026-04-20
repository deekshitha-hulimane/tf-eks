pipeline {
    agent any

    environment {
        AWS_CRED = credentials('aws-keys')
        TF_HOME  = tool 'terraform'
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
                    sh "${TF_HOME}/terraform init"
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withEnv(["AWS_ACCESS_KEY_ID=${AWS_CRED_USR}", "AWS_SECRET_ACCESS_KEY=${AWS_CRED_PSW}"]) {
                    sh "${TF_HOME}/terraform plan -out=tfplan"
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withEnv(["AWS_ACCESS_KEY_ID=${AWS_CRED_USR}", "AWS_SECRET_ACCESS_KEY=${AWS_CRED_PSW}"]) {
                    sh "${TF_HOME}/terraform apply -auto-approve tfplan"
                }
            }
        }
    }

    post {
        success {
            echo 'Infrastructure provisioned successfully!'
        }
        failure {
            echo 'Infrastructure provisioning failed. Check logs.'
        }
    }
}
