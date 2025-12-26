output "app_auth" {
  value = {
    id              = var.id
    installation_id = var.installation_id
    pem_file        = local.pem_file
  }
}
