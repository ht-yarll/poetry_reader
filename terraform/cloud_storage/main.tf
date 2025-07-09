locals {
  tiers = [
    "gold/",
    "silver/",
    "bronze/"
  ]
}

resource "google_storage_bucket" "poetry_reader_terraform" {
  name = var.bkt_name
  location      = var.location
  force_destroy = true # conveninete para qunado aplicar o "terraform destroy", deleta o bkt mesmo que tenha conteúdo
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "dataproc_env" {
  name    = "dataproc/projects/"
  bucket  = google_storage_bucket.poetry_reader_terraform.name
  content = ""  # Vazio para substituição
}

resource "google_storage_bucket_object" "medalion_folders" {
  for_each = toset(local.tiers)
  name     = each.value
  bucket   = google_storage_bucket.poetry_reader_terraform.name
  content  = ""
}