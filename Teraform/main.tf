terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.13.1"
    }
  }
}

provider "aws" {
    region = "us-west-2"
    }

resource "aws_instance" "fromtf" {
    ami = "ami-03f65b8614a860c29"
    tags = {
    Name ="from terraform"
    }
    key_name = "my_id_rsa"
    vpc_security_group_ids = ["sg-05adaf452b268c335"]
    instance_type = "t2.micro"</li>
    </ul>
}