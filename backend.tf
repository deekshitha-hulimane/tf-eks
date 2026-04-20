terraform {
  backend "s3" {
    bucket         = "my-unique-eks-state-bucket-2026"  # Use the exact name from your bootstrap
    key            = "eks/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
