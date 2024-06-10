resource "aws_s3_bucket" "s3" {
 
 bucket = "terra6"

}
 
resource "aws_dynamodb_table" "db" {
 name = "terra6"
 billing_mode = "PAY_PER_REQUEST"
 hash_key = "LockID"
 attribute  {
 name = "LockID"
 type = "S"
 }

}
