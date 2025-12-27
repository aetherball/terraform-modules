variable "name" {
  type = string
}

variable "namespace" {
  type    = string
  default = "default"
}

variable "repo_root" {
  type = string
}

variable "set" {
  description = "List of value blocks to set individual values"
  type = list(object({
    name  = string
    value = string
    type  = optional(string)
  }))
  default = []
}
