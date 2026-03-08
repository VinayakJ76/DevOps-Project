# Configure Terraform to use an S3 backend for storing the state file
terraform {

  backend "s3" {
    bucket         = "task-tracker-terraform-state"
    key            = "infra/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }

}