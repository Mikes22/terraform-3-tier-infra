terraform {
  backend "s3" {
    bucket = "jjtech-netflix-tf-project-09834"
    key    = "state/terraform.tfstate"
    region = "us-east-1"
    workspace_key_prefix = "env"
  }
}