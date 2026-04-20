pipeline {
    agent any

    stages {
        stage('Initialize') {
            steps {
                // We only need one checkout
                checkout scm
                
                withCredentials([usernamePassword(credentialsId: 'aws-keys', 
                                 passwordVariable: 'AWS_SECRET_ACCESS_KEY', 
                                 usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
                    
                    // 1. Re-sync with S3
                    bat 'terraform init -reconfigure'
                    
                    // 2. Import the existing cluster so Terraform stops trying to 'Create' it
                    // NOTE: If this stage fails saying "already imported", that's actually fine!
                    sh "terraform import module.eks.aws_eks_cluster.this[0] my-eks-cluster || exit 0"
                }
            }
        }

        stage('Terraform Plan & Apply') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws-keys', 
                                 passwordVariable: 'AWS_SECRET_ACCESS_KEY', 
                                 usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
                    bat 'terraform plan -out=tfplan'
                    bat 'terraform apply -input=false tfplan'
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
