data "aws_ami" "ami-attrs" {
  most_recent = true
  owners      = var.owners

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "image-type"
    values = ["machine"]
  }

  filter {
    name   = "is-public"
    values = ["true"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }

  name_regex = var.regex
}
