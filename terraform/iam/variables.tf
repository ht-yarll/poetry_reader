variable "ci_cd_roles" {
  description = "Roles to assign to the Cloud Build service account"
  type        = list(string)
}

variable "project_id" {
  description = "The GCP project ID"
  type        = string
}