variable "project_name" { type = string }
variable "environment" { type = string }
variable "aws_region" { type = string }
variable "vpc_cidr" { type = string }
variable "public_subnet_cidr" { type = string }
variable "private_subnet_cidr" { type = string }
variable "availability_zone" { type = string }
variable "instance_type" { type = string }
variable "public_key_path" { type = string }
variable "allowed_ssh_ips" { type = list(string) }
variable "root_volume_size" {
  type    = number
  default = 20
}