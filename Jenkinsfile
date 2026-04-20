pipeline {
    agent any

    triggers {
        pollSCM('H/5 * * * *') // Check GitHub every 5 mins
    }

    environment {
        // 'aws-keys' must be the ID of your AWS Credentials in Jenkins
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
        always {
            cleanWs()
        }
    }
}
