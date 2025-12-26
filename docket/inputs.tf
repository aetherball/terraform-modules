variable "name" {
  type = string
}

variable "repo_root" {
  type = string
}

variable "container_registry" {
  type    = string
  default = "ghcr.io"
}

variable "image_org" {
  description = "Organization to push the image to"
  type        = string
  default     = "aetherball"
}

variable "image_tags" {
  description = "Tags to apply to the image"
  type        = list(string)
  default     = ["latest"]
}

variable "image_platforms" {
  description = "Platforms to build the image for"
  type        = list(string)
  default     = ["linux/amd64"]
}
