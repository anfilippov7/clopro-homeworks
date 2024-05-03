###cloud vars
variable "token" {
  type        = string
  description = ""
}

variable "cloud_id" {
  type        = string
  description = "b1gfboajr02kesda5lgl"
}

variable "folder_id" {
  type        = string
  description = "b1g7kr9i41eoi2fqj52o"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}


variable "nat-instance-image-id" {
  default = "fd80mrhj8fl2oe87o4e1"
}

variable "nat-instance-ip" {
  default = "192.168.10.254"
}

variable "centos-7-base" {
  default = "fd8jd3bc8292546d4m8f"
}

variable "domain" {
  default = "netology.cloud"
}

variable "nat-instance-name" {
  default = "nat-instance-vm1"
}

variable "public-vm-name" {
  default = "public-vm1"
}

variable "private-vm-name" {
  default = "private-vm1"
}
