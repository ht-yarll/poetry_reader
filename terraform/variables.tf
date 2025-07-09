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

#Cloudbuild
variable "cloudbuild_roles" {
  description = "Roles to assign to the Cloud Build service account"
  type        = list(string)
}

# Cloud Storage
variable "buckets" {
  description = "Map of bucket names to their configurations"
  type = map(object({
    location = string
  }))
}

#Artifact Registry
variable "artifact_registry_repository" {
  description = "Name of the Artifact Registry repository"
  type        = string
}

#Github variable
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

variable "app_name" {
  description = "Name of the application or service"
  type        = string
}
