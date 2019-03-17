output "ami-id" {
  value = "${data.aws_ami.ami-attrs.image_id}"
}
