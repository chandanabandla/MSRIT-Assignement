#CreateInstances.tf

provider "aws" {
access_key="access keys here"
secret_key="secret keys here"
region = "ap-south-1"
}
variable "count" {
default=3
}
resource "aws_instance"{
count="${var.count}"
instance_type = "t2.micro"
tags { Name="${format("MSR-test-Instance-%01d",count.index+1)}" }
}
output "ip" {
    value = "${aws_instance.*.public_ip}"
}
