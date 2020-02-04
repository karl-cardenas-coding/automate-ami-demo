variable "owners" {
  type = list
  description = "The owner of the AMI"
}

variable "regex" {
    description = "The regular expresion to filter the AMI for"
    type = string
}