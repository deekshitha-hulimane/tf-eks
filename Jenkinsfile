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
                    // Changed 'sh' to 'bat' and used backslashes for Windows paths
                    bat "\"${TF_HOME}\\terraform.exe\" init"
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withEnv(["AWS_ACCESS_KEY_ID=${AWS_CRED_USR}", "AWS_SECRET_ACCESS_KEY=${AWS_CRED_PSW}"]) {
                    bat "\"${TF_HOME}\\terraform.exe\" plan -out=tfplan"
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withEnv(["AWS_ACCESS_KEY_ID=${AWS_CRED_USR}", "AWS_SECRET_ACCESS_KEY=${AWS_CRED_PSW}"]) {
                    bat "\"${TF_HOME}\\terraform.exe\" apply -auto-approve tfplan"
                }
            }
        }
    }

    post {
        success {
            echo 'Infrastructure provisioned successfully!'
        }
        failure {
            echo 'Infrastructure provisioning failed. Check the logs above.'
        }
    }
}
