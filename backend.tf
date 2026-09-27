terraform {
  backend "s3" {
    bucket         =  "dev-my-terraform-demo-bucket-dfsdfd29092026"
    key            = "terraform.tfstate"
    region         = "us-east-1"
  }
}
