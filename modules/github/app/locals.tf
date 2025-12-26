locals {
  pem_file = var.github_app_pem_file != "" ? var.github_app_pem_file : file("~/.ssh/aetherball/terraform-github-app.pem")
}
