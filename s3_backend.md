In order to circumvent Terraform attempting to plan and apply this code, it is both commented out and placed within this README. This below code will be the first step in your Terraform configuration. When you run your Terraform code, Terraform creates a "state file". This file operates as a cache and metadata bank for all the infrastrure you have created and deleted within your configuration. It is best practice to store this file in the cloud, the reasoning for this includes: 
    - When stored locally it is plaintext, including sensitive data
    - It is difficult to collaborate on code that is stored locally 

Unfortunately version control systems such as Git are also discouraged from being used to store state due to: 
    - Version control systems such as Git, do not support "state locking" 

Why is "state locking" necesary?     
    - When multiple users attempt to modify infrastructure simultaneously, this may        corrupt the state file, which is why remote backend sources that support "state locking" are necesarry 
 
 For more information on state please refer to the Hashicorp documenetation here:  
 https://www.terraform.io/language/state
 https://www.terraform.io/cdktf/concepts/remote-backends


 This is just one method of storing state, just copy this into your "main.tf" file and run:

# After running this code with a "terraform apply, uncomment the code below and run it again, you will then initialize the backend for the code in a remote S3 Bucket"

 terraform {
 # backend "s3" {
 #  bucket         = "backend-dev-tfstate-bucket" # REPLACE WITH YOUR BUCKET NAME
 #  key            = "gov_cloud/dev/terraform.tfstate"
 #  region         = "us-west-1"
 #  dynamodb_table = "terraform-state-lock"
 #  encrypt        = true
 # }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.9.0"
    }
  }
}

provider "aws" {
  region = "us-west-1"
}

resource "aws_s3_bucket" "backend-dev-tfstate-bucket" {
  bucket = "backend-dev-tfstate-bucket"
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "aws_encryption" {
  bucket = aws_s3_bucket.backend-dev-tfstate-bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_acl" "tf_state_bucket_acl" {
  bucket = aws_s3_bucket.backend-dev-tfstate-bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.backend-dev-tfstate-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
