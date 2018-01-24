variable "tfi_region" {}
variable "tfi_private_key" {}
variable "tfi_public_key" {}
variable "tfi_term_user" {}
variable "tfi_term_passwd" {}
variable "tfi_key_pair_name" {}
variable "tfi_ssh_user" {}
variable "tfi_cb_ip" {}
variable "tfi_associate_public_ip_address" {}
variable "tfi_win_security_group" {}
variable "tfi_lx_security_group" {}
variable "tfi_instance_profile" {}
variable "tfi_lx_instance_type" {}
variable "tfi_win_instance_type" {}
variable "tfi_subnet_id" {}
variable "tfi_vpc_id" {}
variable "tfi_lx_all_one_none" {}
variable "tfi_win_all_one_none" {}

output "amicentos6" {
  value = "${data.aws_ami.centos6.id}"
}

output "amicentos7" {
  value = "${data.aws_ami.centos7.id}"
}

output "amirhel6" {
  value = "${data.aws_ami.rhel6.id}"
}

output "amirhel7" {
  value = "${data.aws_ami.rhel7.id}"
}

output "ami2016" {
  value = "${data.aws_ami.windows2016.id}"
}

output "ami2012" {
  value = "${data.aws_ami.windows2012.id}"
}

output "ami2008" {
  value = "${data.aws_ami.windows2008.id}"
}
