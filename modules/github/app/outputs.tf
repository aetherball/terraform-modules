output "app_auth" {
  value = {
    id              = var.github_app_id
    installation_id = var.github_app_installation_id
    pem_file        = local.pem_file
  }
}
