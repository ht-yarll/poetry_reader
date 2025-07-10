resource "google_service_account" "ci_cd_runner_sa" {
  account_id   = "cloudbuild-sa"
  display_name = "cloudbuild-sa"
  description  = "Cloud Build service account infra, dealing with CI/CD components"
}

resource "google_project_iam_member" "cloudbuild_roles" {
  for_each = toset(var.ci_cd_roles)
  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.ci_cd_runner_sa.email}"
}

resource "google_service_account" "bq_infra_sa" {
  account_id   = "bq-infra-sa"
  display_name = "Service Account for BigQuery infrastructure management"
  description  = "Handles BQ datasets, tables, and permissions"
}

resource "google_project_iam_member" "big_query_roles" {
  for_each = toset(var.bq_roles)
  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.bq_infra_sa.email}"
}