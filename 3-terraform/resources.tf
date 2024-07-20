provider aws {
 region = "us-east-1" 
}
  
resource "aws_default_vpc" "vpc" {

}
  
resource "aws_key_pair" "key" {
 key_name = "terra-key"
 public_key = file("terra-key.pub")
}

resource "aws_security_group" "sg" {
   name = "Terraform"
   description = "Allow ssh inbound traffic"

 # using default VPC
 vpc_id = aws_default_vpc.vpc.id

 ingress {
  description = "Allowing SSH from terraform"
 

   # we should allow incoming and outoging
   # TCP packets

  from_port = 22
  to_port = 22
  protocol = "tcp"

    # allow all traffic

  cidr_blocks = ["0.0.0.0/0"]

 }
 
  tags = {
    Name = "Terraform"
  }

}

resource "aws_instance" "ec2" {
 
  ami = "ami-04b70fa74e45c3917"
  instance_type = "t2.micro" 
  key_name = aws_key_pair.key.key_name
  security_groups = [aws_security_group.sg.name]
  tags = {
  Name = "Terraform"
  volumes = "Terraform" 
  }
 
}











