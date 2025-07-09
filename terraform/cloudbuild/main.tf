# Connection -------------------------
resource "google_secret_manager_secret" "github-token-secret" {
  secret_id = "github-token-secret"

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "github-token-secret-version" {
  secret = google_secret_manager_secret.github-token-secret.id
  secret_data = file("my-github-token.txt")
}

data "google_iam_policy" "p4sa-secretAccessor" {
  binding {
    role = "roles/secretmanager.secretAccessor"
    members = ["serviceAccount:service-${var.project_number}@gcp-sa-cloudbuild.iam.gserviceaccount.com"]
  }
}

resource "google_secret_manager_secret_iam_policy" "policy" {
  secret_id = google_secret_manager_secret.github-token-secret.secret_id
  policy_data = data.google_iam_policy.p4sa-secretAccessor.policy_data
}

resource "google_cloudbuildv2_connection" "connection_with_poetry_reader_repo" {
  location = var.region
  name = "connection_with_poetry_reader_repo"

  github_config {
    app_installation_id = var.app_installation_id
    authorizer_credential {
      oauth_token_secret_version = google_secret_manager_secret_version.github-token-secret-version.id
    }
  }
}

# Repositories Connect ----------------
resource "google_cloudbuildv2_repository" "repos" {
  location = var.region
  for_each = toset(var.repositories)
  name = each.value
  parent_connection = google_cloudbuildv2_connection.connection_with_poetry_reader_repo
  remote_uri = "https://github.com/${var.github-user}/${each.value}"
}

# Triggers ---------
resource "google_cloudbuild_trigger" "trigger_test" {
  for_each = google_cloudbuildv2_repository.repos
  
  name = "testing-before-merge-${each.key}"
  location = "global"

  trigger_template {
    branch_name = "master"
    repo_name   = each.value.name
  }

  filename = "test-code.cloudbuild.yaml"
}