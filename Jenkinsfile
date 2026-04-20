pipeline {
    agent any

    stages {
        stage('Terraform Init & Import') {
            steps {
                // Checkout is handled automatically by Declarative Pipeline, 
                // so we don't need an extra 'checkout scm' step here.
                
                withCredentials([usernamePassword(credentialsId:'aws-keys', 
                                 passwordVariable: 'AWS_SECRET_ACCESS_KEY', 
                                 usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
                    
                    // Initialize the backend
                    bat 'terraform init -reconfigure'
                    
                    // This import command uses Windows 'bat'. 
                    // The '|| exit 0' ensures if it's already imported, the build continues.
                    bat 'terraform import module.eks.aws_eks_cluster.this[0] my-eks-cluster || exit 0'
                }
            }
        }

        stage('Terraform Plan & Apply') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws-keys', 
                                 passwordVariable: 'AWS_SECRET_ACCESS_KEY', 
                                 usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
                    
                    // Create the plan file
                    bat 'terraform plan -out=tfplan'
                    
                    // Execute the plan
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
