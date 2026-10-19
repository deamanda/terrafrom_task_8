variable "vpc_name" {
  type        = string
  description = "vpc name"
  default     = "cmtr-otuokx4e-vpc"
}

data "aws_subnets" "subnets" {
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

variable "sg_ssh" {
  type        = string
  description = "allows SSH access to EC2 instances"
  default     = "cmtr-otuokx4e-ec2_sg"
}

variable "sg_http" {
  type        = string
  description = "allows HTTP access to EC2 instances"
  default     = "cmtr-otuokx4e-http_sg"
}

variable "sg_lb_http" {
  type        = string
  description = "allows HTTP access to the load balancer from the internet"
  default     = "cmtr-otuokx4e-sglb"
}

variable "key_pair" {
  type        = string
  description = "key pair"
  default     = "cmtr-otuokx4e-keypair"
}