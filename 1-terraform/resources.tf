resource "local_file" "file" {

 filename = "/home/pro-ubuntu/Terraform-lab/1-terraform/demo.txt"
 content = "This file is creted by terraform"

}
 
provider "docker" {}

resource "docker_image" "image" {
 name = "nginx:latest"
 keep_locally = false
}

resource "docker_container" "cntr" {
 image = docker_image.image.name
 name  = "nginx-container" 
 ports {
  internal = 80
  external = 8000
 }

}
