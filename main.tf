##########################################
# Retrieve the latest AMI id
##########################################
module "latest-ami" {
  source = "./modules/ami-latest"
  os     = "${var.os}"
}

##########################################
# Initiate the temp files
##########################################
data "template_file" "organization_list" {
  template = "${path.module}/organization-list-accts.log"
}

data "local_file" "getorganizationAccts" {
  filename = "${data.template_file.organization_list.rendered}"
  depends_on = ["null_resource.getorganizationAccts"]
}

resource "null_resource" "getorganizationAccts" {
    provisioner "local-exec" {
      command = "./aws-cli.sh"
      interpreter = ["bash"]
      environment {
        FILE = "${data.template_file.organization_list.rendered}"
        PROFILE = "${var.profile}"
      }
    }

    triggers {
      lastrun = "${data.template_file.organization_list.rendered}"
    }
}

############################
# Packer File
############################

data "template_file" "ami-file" {
  template = "${file("${path.module}/ami-template.json")}"

  vars {
    ami-name         = "${var.ami-name}"
    vpc_id           = "${var.vpc-id}"
    subnet_id        = "${var.subnet-id}"
    security_groups  = "${substr(local.security-groups,1,length(local.security-groups)-2)}"
    accounts         = "${substr(data.local_file.getorganizationAccts.content,1,length(data.local_file.getorganizationAccts.content)-2)}"
    # If you only have one account use -3
    # accounts         = "${substr(data.local_file.getorganizationAccts.content,1,length(data.local_file.getorganizationAccts.content)-3)}"
    source_ami       = "${module.latest-ami.ami-id}"
    region           = "${var.region}"
    profile          = "${var.profile}"
    instance_profile = "${var.instance-profile}"
    instance_type    = "${var.instance-type}"
    ssh_username     = "${var.ssh-username}"
    script           = "${"./amazon.sh"}"
    os               = "${var.os}"
  }
}

resource "local_file" "ami-json" {
    content = "${data.template_file.ami-file.rendered}"
    filename = "ami.json"
}


############################
# String manipulation
############################
data "template_file" "security-groups" {
  count    = "${length(var.security-groups)}"
  template = "\"${element(var.security-groups,count.index)}\""
}

locals {
  security-groups = "${join(",",data.template_file.security-groups.*.rendered)}"
}
