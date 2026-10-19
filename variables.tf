data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["cmtr-otuokx4e-vpc"]
  }
}

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
}

data "aws_subnets" "subnets_public" {
  filter {
    name   = "tag:Name"
    values = ["*public*"]
  }
}

variable "project_id" {
  type        = string
  description = "project id"
  default     = "cmtr-otuokx4e"
}

data "aws_security_group" "sg_ssh" {
  filter {
    name   = "tag:Name"
    values = ["cmtr-otuokx4e-ec2_sg"]
  }
}

data "aws_security_group" "sg_http" {
  filter {
    name   = "tag:Name"
    values = ["cmtr-otuokx4e-http_sg"]
  }
}

data "aws_security_group" "sg_lb_http" {
  filter {
    name   = "tag:Name"
    values = ["cmtr-otuokx4e-sglb"]
  }
}

variable "key_pair" {
  type        = string
  description = "key pair"
  default     = "cmtr-otuokx4e-keypair"
}
variable "template" {
  type        = string
  description = "template name"
  default     = "cmtr-otuokx4e-template"
}

variable "asg" {
  type        = string
  description = "autoscaling group name"
  default     = "cmtr-otuokx4e-asg"
}

variable "loadbalancer" {
  type        = string
  description = "loadbalancer name"
  default     = "cmtr-otuokx4e-loadbalancer"
}

variable "iam_profile" {
  type        = string
  description = "loadbalancer name"
  default     = "cmtr-otuokx4e-instance_profile"
}

variable "tg" {
  type        = string
  description = "target group"
  default     = "targetgroup"
}