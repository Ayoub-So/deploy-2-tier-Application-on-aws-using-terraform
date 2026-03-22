variable "project_name" {
    type = string
    description = "This is an AWS Two Tier Arch using terraform project name"
}
variable "domain_name" {
  
}
variable "region" {
  type =  string
}

variable vpc_cidr {}
variable pub_sub_1a_cidr {}
variable pub_sub_2a_cidr {}
variable pri_sub_3a_cidr {}
variable pri_sub_4b_cidr {}
variable pri_sub_5a_cidr {}
variable pri_sub_6b_cidr {}
variable db_username {}
variable db_password {}
variable certificate_domain_name {}
variable additional_domain_name {}