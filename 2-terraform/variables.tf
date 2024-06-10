variable "name" {
   default = "/home/pro-ubuntu/Terraform-lab/2-terraform/demo.txt"
}

variable "content" {
   default = "The content of this file is comming from variable"
}
 
variable "show" {
  default = "LEARNING TERRAFOM FOR DEVOPS"
}
 
variable "content_map" {
 type = map
 default = {
 a = "This content is from variable a in map"
 b = "This is content is from variable  b im map"
 }

}

variable "list" {
type = list
 default = ["Hi i am from list at index no.0", "Hello i am also from list at index no.1"]
}
 
variable "aws_ec2" {
type = object({
  name = string
  instances = number
  keys = list(string)
  ami = string
  })
default = {
 name = "aws"
 instances = 5 
 keys = ["key1.pem","key2.pem"]
 ami  = "ami9874563123"
 }
}
