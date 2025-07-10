variable "region" {
  description = "Default region for resources (e.g. southamerica-east1)"
  type = string
}

variable "dataset_prefix" {
    description = "Prefix for named datasets, usually project name on GCP or related tables"
    type = string
}

variable "bq_sa_email" {
  type        = string
  description = "Email of BQ service account"
}