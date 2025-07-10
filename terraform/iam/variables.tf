variable "ci_cd_roles" {
  description = "Roles to assign to the Cloud Build service account"
  type        = list(string)
}

variable "bq_roles" {
  description = "List of IAM roles for BigQuery access"
  type = list(string)
}

variable "project_id" {
  description = "The GCP project ID"
  type        = string
}