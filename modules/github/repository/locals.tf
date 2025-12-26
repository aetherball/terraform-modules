locals {
  repo_parts = split("/", var.repository)

  repo_owner = length(local.repo_parts) == 2 ? local.repo_parts[0] : null
  repo_name  = length(local.repo_parts) == 2 ? local.repo_parts[1] : null
}
