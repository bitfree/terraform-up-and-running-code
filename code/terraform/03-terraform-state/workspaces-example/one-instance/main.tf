terraform {
  required_version = ">= 0.12, <= 0.13"
}

provider "aws" {
  region = "us-east-1"

  # Allow any 2.x version of the AWS provider
  version = "~> 2.0"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "getfree-tf-test-bucket"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }

  versioning {
    enabled = true
  }

}

terraform {
   backend "s3" {
 
     # This backend configuration is filled in automatically at test time by Terratest. If you wish to run this example
     # manually, uncomment and fill in the config below.
 
 #    bucket         = "terraform-up-and-running-state"
 #    key            = "terraform.tfstate"
 #    region         = "us-east-1"
 #    dynamodb_table = "MY DYNAMODB TABLE"
 #    encrypt        = true
 
   }
 }


  resource "aws_instance" "example" {
   ami           = "ami-40d28157"
 
   instance_type = terraform.workspace == "default" ? "t2.micro" : "t2.medium"
 
 }
