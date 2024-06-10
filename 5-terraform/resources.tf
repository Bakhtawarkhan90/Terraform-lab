provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "key" {
  key_name   = "terra-key"
  public_key = file("terra-key.pub")
}

resource "aws_default_vpc" "vpc" {

}

resource "aws_security_group" "sg" {
  name        = "pro"
  description = "from local"
  vpc_id      = aws_default_vpc.vpc.id

  ingress {
    description  = "ALLOW SSH"
    from_port    = 22
    to_port      = 22
    protocol     = "tcp"
    cidr_blocks  = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh"
  }
}

resource "aws_instance" "instance" {
  ami           = var.ec2["ami"]
  instance_type = var.ec2["type"]
  tags          = var.ec2["tags"]
  key_name      = aws_key_pair.key.key_name
  security_groups = [aws_security_group.sg.name]

  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/web.sh",
      "sudo /tmp/web.sh > /tmp/web.log 2>&1",
      "cat /tmp/web.log"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("terra-key")
    host        = self.public_ip
  }
}
