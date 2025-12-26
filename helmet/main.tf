locals {
  chart_rel_path = "${var.repo_root}/charts/${var.name}"

  # Only hash YAML files so Helm's dependency_update doesn't change the result of fileset.
  chart_files = fileset(local.chart_rel_path, "**/*.yaml")

  chart_hash = sha256(join("", [
    for f in local.chart_files :
    filesha256("${local.chart_rel_path}/${f}")
  ]))
}

resource "helm_release" "this" {
  name      = var.name
  namespace = var.namespace

  # State stores the stable, relative string
  chart = local.chart_rel_path

  atomic            = true
  dependency_update = true
  create_namespace  = false
  wait_for_jobs     = true
  lint              = true
  max_history       = 10

  # The magic knob: changes when any YAML file in the chart changes
  set = [{
    name  = "chartHash"
    value = local.chart_hash
  }]
}
