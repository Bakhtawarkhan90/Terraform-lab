# Define the provider
provider "aws" {
  region = "us-east-1" # Change the region as needed
}

# Create a VPC
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main"
  }
}

# Create public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a" # Change the availability zone as needed

  tags = {
    Name = "public_subnet"
  }
}

# Create private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.2.0/24" # Changed the CIDR block for the private subnet
  availability_zone = "us-east-1a"   # Change the availability zone as needed

  tags = {
    Name = "private_subnet"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "main_igw"
  }
}

# Create a main route table
resource "aws_route_table" "main_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "main_rt"
  }
}

# Associate public subnet with the main route table
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.main_rt.id
}

# Associate private subnet with the main route table
resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.main_rt.id
}

# Create a security group
resource "aws_security_group" "sg" {
  name        = "main"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Main_sg"
  }
}

# Create an instance in main vpc without SSH key
resource "aws_instance" "ec2" {
  ami           = "ami-04b70fa74e45c3917" # Change this to your desired AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id # Specify the subnet for the instance
  associate_public_ip_address = true             # Assign a public IP to the instance
  security_groups = [aws_security_group.sg.id]

  tags = {
    Name = "MAIN"
  }
}

# Output Instance ID
output "instance_id" {
  value = aws_instance.ec2.id
}

# Output Public IP
output "instance_public_ip" {
  value = aws_instance.ec2.public_ip
}

# Output VPC ID
output "vpc_id" {
  value = aws_vpc.vpc.id
}

# Output Public Subnet ID
output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

# Output Private Subnet ID
output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}

# Output route table id
output "route_table_id" {
  value = aws_route_table.main_rt.id
}
