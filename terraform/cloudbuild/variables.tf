variable "region" {
  description = "Region of project or preferable"
  type = string
}

variable "project_number" {
  description = "project number found on overwview of projects"
  type = string
}

variable "app_installation_id" {
  description = "app_id from github repository"
  type = number
}

# GitHub ------
variable "github_user" {
  description = "user from github"
  type = string
}

variable "repository" {
  description = "Repository named exactly as on GitHub"
  type = string
}

variable "github_token" {
  type        = string
  sensitive   = true
  description = "GitHub personal access token used to authenticate Cloud Build connection"
}
