

variable "ec2" {
  type = object({
    ami  = string
    type = string
    tags = map(string)
  })
  default = {
    ami  = "ami-04b70fa74e45c3917"
    type = "t2.micro"
    tags = {
      Name = "TERRA"
    }
  }
}
