terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "serverq" {
  ami           = "ami-01edba92f9036f76e" 
  instance_type = t2.micro
  count = 2
  tags = {
    Name = "HelloWorld"
  }
}
