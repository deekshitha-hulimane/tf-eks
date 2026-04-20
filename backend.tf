terraform {
  backend "s3" {
    bucket         = "my-tf-state-bucket-unique-67890"  # Match the name in your screenshot
    key            = "terraform.tfstate"
    region         = "ap-south-1"                       # Match the region in your screenshot
    dynamodb_table = "terraform-lock-table"             # Ensure this exists in Mumbai too
  }
}
