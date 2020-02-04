variable "security-groups" {
  type        = list
  description = "The VPC security groups to attach to the Packer Instance"
}

variable "vpc-id" {
  type        = string
  description = "The VPC ID to where Packer will launch the instance"
}

variable "subnet-id" {
  type        = string
  description = "The subnet to launch the Packer instance"
}

variable "os" {
  type        = string
  default     = "amazon"
  description = "The AMI to source the new AMI from"
}

variable "ami-name" {
  type        = string
  description = "The name for the AMI that will be created"
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "The region where the Packer instance wil be launched"
}

variable "instance-profile" {
  type        = string
  description = "The EC2 Instance Profile to attach to the Packer Instance"
}

variable "instance-type" {
  type        = string
  default     = "t2.micro"
  description = "The EC2 instance type that Packer will launch"
}

variable "profile" {
  type        = string
  description = "The profile to use with the aws cli"
}

variable "ssh-username" {
  type        = string
  default     = "ec2-user"
  description = "The username for the the SSH session packer initiates to the launched instance"
}

variable "role_arn" {
  description = "The role arn for the AWS Role to assume"
}

// AMI Module Variables
variable "ami-owners-list" {
  description = "The list of ownes required for the AMI module"
  type = list
}

variable "ami-regex" {
  description = "The regular expression to pass into the AMI Module"
  type = string
}