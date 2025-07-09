variable "project_id" {
  default = "poetry-reader-465416"
  type = string
}
variable "region" {
  default = "latin"
  type = string
}

# Bucket variables
variable "bucket_name_suzano" {
  default = "tf-suzano-challenge"
  type = string
}
variable "bucket_location" {
  default = "US"
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
  default = "poetry_reader"
  type = string
}

variable "github_full_repo" {
  default = "https://github.com/ht-yarll/poetry_reader"
  type = string
}