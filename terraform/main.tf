locals {
  module_dependencies = [module.iam]
}

# Providers --------------------------------------------------------------------
provider "google" {
  project     = var.project_id
  region      = var.region
}

provider "google-beta" {
  project     = var.project_id
  region      = var.region
}

# Resources --------------------------------------------------------------------
resource "google_project_service" "enable_apis" {
  for_each = toset([
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "artifactregistry.googleapis.com",
    "run.googleapis.com",
    "cloudbuild.googleapis.com",
    "servicemanagement.googleapis.com",
    "compute.googleapis.com",
    "bigquery.googleapis.com"
  ])
  project             = var.project_id
  service             = each.key
  disable_on_destroy  = false
}

# Modules ----------------------------------------------------------------------
module "iam" {
  source = "./iam"
  project_id = var.project_id
  ci_cd_roles = var.ci_cd_roles
  bq_roles = var.bq_roles
}

module "gcs" {
  source = "./cloud_storage"
  bkt_name = var.bkt_name
  location = var.region

  depends_on = locals.module_dependencies
}

module "cloudbuild" {
  source = "./cloudbuild"
  github_user = var.github_owner
  github_token = var.github_token
  repository = var.github_repo
  project_number = var.project_number
  app_installation_id = var.app_installation_id
  region = var.region

  depends_on = locals.module_dependencies
}

module "bigquery" {
  source = "./bigquery"
  bq_sa_email = module.iam.bq_infra_sa_email
  dataset_prefix = var.dataset_prefix
  region = var.region
  
  depends_on = locals.module_dependencies
}