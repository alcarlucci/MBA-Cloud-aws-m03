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

resource "aws_security_group" "app_server_sg" {
  name    = "app_server_sg"
  tags = {
    Name = "app_server_sg",
    Projeto = "mod-03"
  }
}

############ Inbound Rules ############
resource "aws_security_group_rule" "app_server_sg_inbound_80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_server_sg.id
}

resource "aws_security_group_rule" "app_server_sg_inbound_3306" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_server_sg.id
}
resource "aws_security_group_rule" "app_server_sg_inbound_443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_server_sg.id
}

resource "aws_security_group_rule" "app_server_sg_inbound_22" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_server_sg.id
}

resource "aws_security_group_rule" "app_server_sg_inbound_25" {
  type              = "ingress"
  from_port         = 25
  to_port           = 25
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_server_sg.id
}

############ Outbound Rules ############
resource "aws_security_group_rule" "app_server_sg_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_server_sg.id
}

resource "aws_instance" "app_server" {
  ami           = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"
  vpc_security_group_ids = [ "${aws_security_group.app_server_sg.id}" ]
  tags = {
    Name = "Minha Instancia EC2",
    Change = "True",
    Desliga = "True"
    Projeto = "mod-03"
  }
}

resource "aws_eip" "app_server" {
  instance = aws_instance.app_server.id
  vpc      = true
  tags = {
    Name = "eip-app_server"
    Projeto = "mod-03"
  }
}