variable "repository" {
  type = string

  validation {
    condition     = length(split("/", var.repository)) == 2
    error_message = "repository must be in the form owner/repo"
  }
}
