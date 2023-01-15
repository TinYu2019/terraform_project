variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 80
}

variable "sg" {
  description = "List of Security Group IDs"
  type        = list(string)
  default     = [ "sg-08221f64b86654391" ]
}

provider "aws" {
 region = "ap-southeast-1"
}

resource "aws_instance" "techsecops-exercise" {
 ami	= "ami-005835d578c62050d"
 instance_type = "t2.micro"
 vpc_security_group_ids = var.sg

user_data = templatefile("user-data.sh", {
    server_port = var.server_port
  })

 user_data_replace_on_change = true

 tags = {
  Name = "techsecops-exercise"
 }
}