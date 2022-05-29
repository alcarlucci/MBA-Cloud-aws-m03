terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 0.14.9"
}

provider "aws" {
  region  = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"
  vpc_security_group_ids = [ "${module.security_group_app_server.app_server_sg_id}" ]
  tags = {
    Name = "InstanciaEC2-ComModulo",
    Change = "True",
    Desliga = "True",
    Projeto = "mod-03"
  }
}

resource "aws_eip" "app_server" {
  instance = aws_instance.app_server.id
  vpc      = true
  tags = {
    Name = "eip-app_server_mod",
    Projeto = "mod-03"
  }
}

module "security_group_app_server" {
  source = "./modules/sg"
}