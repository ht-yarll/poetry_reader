variable "project_id" {
  default = "poetry-reader-465416"
  type = string
}
variable "region" {
  default = "southamerica-east1"
  type = string
}
variable "project_number" {
  default = "60598995795"
  type = string
}

# Bucket variables
variable "bucket_name" {
  default = "terraform"
  type = string
}
variable "bucket_location" {
  default = "southamerica-east1"
  type = string
}

# Artifact Registry variables
variable "artifact_registry_repository" {
  default = "gcr-repository"
  type = string
}

# Cloud Build variables
variable "github_owner" {
  default = "ht-yarll"
  type = string
}
variable "github_repo" {
  default = "poetry_reader"
  type = string
}

variable "app_name" {
  default = "poetryreader"
  type = string
}

variable "github_full_repo" {
  default = "https://github.com/ht-yarll/poetry_reader"
  type = string
}