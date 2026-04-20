terraform {
  backend "s3" {
    bucket         = "my-unique-eks-state-bucket-2026"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
  }
}
