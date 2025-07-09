resource "google_storage_bucket" "poetry-reader-terraform" {
  for_each          = var.buckets
  name = each.key
  location      = lookup(each.value, "location", var.location) # usa location do bucket ou o padrão
  force_destroy = true # conveninete para qunado aplicar o "terraform destroy", deleta o bkt mesmo que tenha conteúdo
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "dataproc_env" {
  name    = "dataproc/projects/"
  bucket  = google_storage_bucket.poetry_reader.name
  content = ""  # Vazio para substituição
}

resource "google_storage_bucket_object" "medalion_structure" {
  for_each = toset(var.medalion_structure)
  name     = each.value
  bucket   = google_storage_bucket.poetry_reader.name
  content  = ""
}