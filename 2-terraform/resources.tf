resource "local_file" "file" {
 filename= var.name
 content = var.content 
}
 
output "var" {
value = var.show
}
 
output "from_map" {
value =  var.content_map["a"]
}

output "from_list" {
value = var.list[0]
}
 
output "list" {
value = var.list[1]
}
 
output "instances" {
value = var.aws_ec2
} 
