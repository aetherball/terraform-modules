locals {
  docker_dir          = "${var.repo_root}/docker/${var.name}"
  dockerfile_rel_path = "${local.docker_dir}/Dockerfile"

  dockerfile_hash = filesha256("${local.dockerfile_rel_path}")

  image_name = var.name
  image_repo = "${var.container_registry}/${var.image_org}/${local.image_name}"

  # keep cache per-image to avoid cross-image contamination
  cache_ref = "${local.image_repo}:buildcache"
}

resource "null_resource" "docket_build" {
  triggers = {
    dockerfile_hash    = local.dockerfile_hash
    container_registry = var.container_registry
    image_org          = var.image_org
    image_tags         = join(",", var.image_tags)
    image_platforms    = join(",", var.image_platforms)
  }

  provisioner "local-exec" {
    interpreter = ["/usr/bin/env", "bash", "-lc"]

    environment = {
      REGISTRY = var.container_registry

      IMAGE_REPO = local.image_repo
      CACHE_REF  = local.cache_ref
      DOCKER_DIR = local.docker_dir
      DOCKERFILE = local.dockerfile_rel_path

      PLATFORMS = join(",", var.image_platforms)
      TAGS      = join(",", var.image_tags)
    }

    command = <<-EOT
      set -euo pipefail

      # Turn comma-separated TAGS env var into tag args
      TAG_ARGS=()
      IFS=',' read -r -a TAG_LIST <<< "$${TAGS}"
      for t in "$${TAG_LIST[@]}"; do
        TAG_ARGS+=(--tag "$${IMAGE_REPO}:$${t}")
      done

      # Login to registry (avoid printing secrets)
      echo "$${CR_PASSWORD}" | docker login "$${REGISTRY}" -u "$${CR_USERNAME}" --password-stdin >/dev/null

      # Ensure buildx builder exists and is selected
      docker buildx inspect --bootstrap >/dev/null

      # Build + push with registry-backed cache
      docker buildx build \
        --file "$${DOCKERFILE}" \
        --platform "$${PLATFORMS}" \
        --push \
        --cache-from "type=registry,ref=$${CACHE_REF}" \
        --cache-to   "type=registry,ref=$${CACHE_REF},mode=max" \
        "$${TAG_ARGS[@]}" \
        "$${DOCKER_DIR}"
    EOT
  }
}
