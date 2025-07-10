output "bq_infra_sa_email" {
  value = google_service_account.bq_infra_sa.email
}

output "ci_cd_runner_sa" {
  value = google_service_account.ci_cd_runner_sa.email
}
