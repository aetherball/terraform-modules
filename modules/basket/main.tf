resource "b2_bucket" "instance" {
  bucket_name = var.bucket_name
  bucket_type = var.bucket_type

  default_server_side_encryption {
    mode = "SSE-B2"
  }

  # Enable Object Lock to prevent overwrites of files
  file_lock_configuration {
    is_file_lock_enabled = true
  }

  # Keep only the last version of each file.
  # See: https://www.backblaze.com/docs/cloud-storage-lifecycle-rules
  lifecycle_rules {
    file_name_prefix             = ""
    days_from_hiding_to_deleting = 1
  }

  # These two together means the bucket contents are 'immutable'.
}
