provider "google" {
  credentials = file("./credentials/suzano-challenge.json")
  project     = var.project_id
  region      = var.region
}

provider "google-beta" {
  credentials = file("./credentials/suzano-challenge.json")
  project     = var.project_id
  region      = var.region
}

# Modules ------------------------------------------------

module "project-services" {
  source                      = "terraform-google-modules/project-factory/google//modules/project_services"
  version                     = "17.0.0"
  disable_services_on_destroy = false

  project_id  = var.project_id
  enable_apis = true

  activate_apis = [
    "cloudresourcemanager.googleapis.com",
    "serviceusage.googleapis.com",
    "iam.googleapis.com",
    "artifactregistry.googleapis.com",
    "run.googleapis.com",
    "cloudbuild.googleapis.com",
    "servicemanagement.googleapis.com",
    "compute.googleapis.com",
    "bigquery.googleapis.com"
  ]
}

module "iam" {
  source = "./iam"
  project_id = var.project_id
  ci_cd_roles = var.ci_cd_roles
}

module "gcs" {
  source = "./cloud_storage"
  buckets = var.buckets
  location = var.region
}