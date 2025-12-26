locals {
  pem_file = var.pem_file != "" ? var.pem_file : file("~/.ssh/aetherball/terraform-github-app.pem")
}
