#Project
variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "Default region for resources (e.g. southamerica-east1)"
  type        = string
}

variable "project_number" {
  description = "GCP Project number"
  type        = string
}

#Big Query
variable "dataset_prefix" {
  description = "Prefix for dataset"
  type = string
}

variable "bq_roles" {
  description = "List of IAM roles for BigQuery access"
  type        = list(string)
}

#Cloudbuild
variable "ci_cd_roles" {
  description = "Roles to assign to the Cloud Build service account"
  type        = list(string)
}

# Cloud Storage
variable "main_bkt_name" {
  description = "Bucket name"
  type = string
}

#Artifact Registry
variable "artifact_registry_repository" {
  description = "Name of the Artifact Registry repository"
  type        = string
}

#Github variables
variable "github_owner" {
  description = "GitHub repository owner (user or organization)"
  type        = string
}

variable "github_repo" {
  description = "Name of the GitHub repository"
  type        = string
}

variable "github_full_repo" {
  description = "Full GitHub repository URL (e.g. https://github.com/user/repo)"
  type        = string
}

variable "github_personal_access_token" {
  type      = string
  sensitive = true
  description = "Personal GitHub token to authenticate CI/CD"
}


variable "app_installation_id" {
  description = "Instalation Id"
  type = number
}

variable "app_name" {
  description = "Name of the application or service"
  type        = string
}
