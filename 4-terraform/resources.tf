provider "aws" {
  region = "us-east-1"
}

locals {
  ec2_names = toset(["A", "B"])
}

resource "aws_instance" "ec2" {
  for_each = local.ec2_names
  ami = "ami-04b70fa74e45c3917"
  instance_type = "t2.micro"
  tags = {
    Name = each.key
  }
}


