variable "bucket_name" {
  description = "The name of the S3 bucket to store the Terraform state."
  type        = string
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instances."
  type        = string
  default     = "ami-0fef201115eefe936"
}