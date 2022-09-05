provider "aws" {
  access_key          = "${var.access_key}"
  secret_key          = "${var.secret_key}"
  allowed_account_ids = ["${var.first_account_id}"]
  region              = "${var.region}"
  #version             = ">= 3.0"
}
variable "access_key" {}
variable "secret_key" {}
variable "first_account_id" {
  type  = string
}
variable "region" {
  type  = string
}
variable "ami" {
  type    = string
  default = "ami-0ec6517f6edbf8044"
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "key_pair" {
  type    = string
  default = "cpgkey"
}
resource "aws_network_interface" "nicByTFE" {
  subnet_id = "subnet-6d439635"
}
resource "aws_instance" "ec2ByTFE" {
  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_pair}"
  tags = {
    Name ="SERVER02"
    Environment = "DEV"
  }
  network_interface {
    network_interface_id = "${aws_network_interface.nicByTFE.id}"
    device_index         = 0
  }
}
