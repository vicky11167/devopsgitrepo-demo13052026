

resource "aws_instance" testserver1{
    ami          = var.ami_id
    instance_type = "t3.micro"
    availability_zone = "us-east-1b"
    key_name = "terraformdemo19062026"
      tags = {
    Name = "1st terraform demo server"
  }
  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_instance" testserver2{
    ami          = var.ami_id
    instance_type = "t3.micro"
    key_name = "terraformdemo19062026"
    count = 3
      tags = {
    Name = "web-server-${count.index + 1 }"
  }
}

resource "aws_s3_bucket" mybucket {
  for_each = {
    "dev" = "my-terraform-demo-bucket-dfsdfd29092026"
    "qa" = "my-terraform-demo-bucket-dfsdfd29092026"
    "prod" = "my-terraform-demo-bucket-dfsdfd29092026"
  }
  bucket = "${each.key}-${each.value}"
}   

resource "aws_s3_bucket" mybucket2 {
  for_each = toset(["devcdhsocsduoc", "qacshnduchs", "prodcnsciuncs"])
  bucket = "${each.key}"
}   

/*
resource "aws_instance" testserver3{
    ami          = var.ami_id
    instance_type = "t3.micro"
    availability_zone = "us-east-1b"
    key_name = "terraformdemo19062026"
      tags = {
    Name = "1st terraform demo server"
  }
  lifecycle {
    prevent_destroy = true
  }
}
*/
resource "aws_instance" testserver5{
    ami          = "ami-0b2c9d1f3edcfd709"
    instance_type = "t3.micro"
    availability_zone = "us-east-1b"
    key_name = "terraformdemo19062026"
    user_data              = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl enable httpd
    sudo systemctl start httpd
    echo "<h1>Welcome to Madrasys Technologies ! AWS Infra created using Terraform in ap-south-1 Region</h1>" > /var/www/html/index.html
    EOF
      tags = {
    Name = "ignore_changes"
  }
  lifecycle {
    ignore_changes = [ami]
  }
}


# vpc --->internet gateway ---> route table ---> subnet ---> security group ---> ec2 instance

resource "aws_vpc" myvpc {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my-vpc"
  }
}

resource "aws_internet_gateway" mygateway {
  vpc_id = aws_vpc.myvpc.id
  depends_on = [aws_vpc.myvpc]
}


data "aws_vpc" importtest {
  filter {
    name   = "tag:Name"
    values = ["testdemovpcimport"]
  }
}

resource "aws_subnet" mysubnet {
  vpc_id     = data.aws_vpc.importtest.id
  cidr_block = "172.0.1.0/24"
}
