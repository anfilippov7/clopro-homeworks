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

variable "lamp-instance-image-id" {
  default = "fd827b91d99psvq5fjit"
}
