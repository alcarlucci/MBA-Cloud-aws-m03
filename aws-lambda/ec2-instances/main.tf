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

resource "aws_security_group" "teste_lambda_instances" {
  name    = "nsg-teste_lambda_instances"
  tags = {
    Name = "nsg-teste_lambda_instances",
    Projeto = "mod-03"
  }
}

############ Inbound Rules ############
resource "aws_security_group_rule" "app_server_sg_inbound_80" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.teste_lambda_instances.id
}

############ Outbound Rules ############
resource "aws_security_group_rule" "app_server_sg_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.teste_lambda_instances.id
}

resource "aws_instance" "teste_lambda_01" {
  ami           = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"
  vpc_security_group_ids = [ "${aws_security_group.teste_lambda_instances.id}" ]
  tags = {
    Name = "vm-Lambda-01",
    Projeto = "mod-03",
    Desliga = "True"
  }
}

resource "aws_instance" "teste_lambda_02" {
  ami           = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"
  vpc_security_group_ids = [ "${aws_security_group.teste_lambda_instances.id}" ]
  tags = {
    Name = "vm-Lambda-02",
    Projeto = "mod-03",
    Desliga = "True"
  }
}

resource "aws_instance" "teste_lambda_03" {
  ami           = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"
  vpc_security_group_ids = [ "${aws_security_group.teste_lambda_instances.id}" ]
  tags = {
    Name = "vm-Lambda-03",
    Projeto = "mod-03"
  }
}

resource "aws_instance" "teste_lambda_04" {
  ami           = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"
  vpc_security_group_ids = [ "${aws_security_group.teste_lambda_instances.id}" ]
  tags = {
    Name = "vm-Lambda-04",
    Projeto = "mod-03"
  }
}