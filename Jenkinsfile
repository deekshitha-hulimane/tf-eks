pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-keys-id') // Ensure these match your Jenkins Credential IDs
        AWS_SECRET_ACCESS_KEY = credentials('aws-keys-secret')
        AWS_DEFAULT_REGION    = 'ap-south-1' // Must match Mumbai
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                // The -reconfigure flag is key since we changed regions
                bat 'terraform init -reconfigure'
            }
        }

        stage('Terraform Plan') {
            steps {
                bat 'terraform plan -out=tfplan'
            }
        }

        stage('Terraform Apply') {
            steps {
                // This will run the actual creation on AWS
                bat 'terraform apply -input=false tfplan'
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
