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

