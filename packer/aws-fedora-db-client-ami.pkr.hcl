packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.6"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "ami_prefix" {
  type    = string
  default = "fedora-cloud-db-client"
}

variable "ami_src_name" {
  type    = string
  default = "Fedora-Cloud-Base-38-1.6.x86_64"
}

variable "ami_src_owner_id" {
  type    = number
  default = 125523088429
}

variable "ami_src_ssh_username" {
  type    = string
  default = "fedora"
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}


source "amazon-ebs" "fedora-db-client" {

  ami_name      = "${var.ami_prefix}-${local.timestamp}"
  instance_type = "t2.micro"
  region        = "eu-central-1"
  source_ami_filter {
    filters = {
      name                = "*${var.ami_src_name}*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["${var.ami_src_owner_id}"]
  }
  ssh_username = "${var.ami_src_ssh_username}"
}

build {
  name = "fedora-db-client-ami"
  sources = [
    "source.amazon-ebs.fedora-db-client"
  ]

  provisioner "shell" {
    start_retry_timeout = "20m"
    environment_vars = [
      "FOO=hello world",
    ]
    inline = [
      "echo Installing updates and Oracle DB drivers...",
      "sudo dnf -y update",
      "sudo dnf -y --nodocs install wget2",
      "wget2 https://download.oracle.com/otn_software/linux/instantclient/219000/oracle-instantclient-basic-21.9.0.0.0-1.el8.x86_64.rpm",
      "wget2 https://download.oracle.com/otn_software/linux/instantclient/219000/oracle-instantclient-sqlplus-21.9.0.0.0-1.el8.x86_64.rpm",
      "sudo dnf -y --nodocs install oracle-instantclient*.rpm",
      "sudo dnf clean all",
      "echo RPM packages installed."
    ]
  }
}
