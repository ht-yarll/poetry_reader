locals {
  dataset_tiers = {
    bronze = {
      friendly_name = "poems_bronze"
    },
    silver = {
      friendly_name = "poems_silver"
    },
    gold = {
      friendly_name = "poemas_ouro"
    }
  }
}

resource "google_bigquery_dataset" "datasets" {
    for_each = local.dataset_tiers
    dataset_id                  = "${var.dataset_prefix}-${var.each.key}"
    friendly_name               = "poemas_ouro"
    description                 = "Dataset for poetry-reader data"
    location                    = var.region
    default_table_expiration_ms = 3600000
    delete_contents_on_destroy  = true

    labels = {
      environment = "dev"
    }
    access {
      role          = "READER"
      user_by_email = google_service_account.ci_cd_runner_sa.email
    }
    access {
      role          = "WRITER"
      user_by_email = google_service_account.ci_cd_runner_sa.email
    }
    access {
      role          = "OWNER"
      user_by_email = google_service_account.ci_cd_runner_sa.email
    }
}   