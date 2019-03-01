#CreateInstances.tf

provider "aws" {
access_key="access keys here"
secret_key="secret keys here"
region = "ap-south-1"
}
variable "count" {
default=3
}
resource "aws_instance" "my_instance"{
count="${var.count}"
instance_type = "t2.micro"
tags { Name="${format("MSR-test-Instance-%01d",count.index+1)}" }
}
resource "aws_security_group""allow all"{
    name: "allow all"
    description: "Allow all inbound traffic"
    ingress{
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        cidr block =["0.0.0.0/0"]
    }
    tags{
        name= "allow_all"
    }
}
resource "aws_ebs_volume" "myvolume"{
    availability_zone = "ap-south-1c"
    size = '1'
    tags{
        Name = "Terraform"
    }
}
output "ip" {
    value = "${aws_instance.my_instance.*.public_ip}"
}
