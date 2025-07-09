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
  type = int
}

# GitHub ------
variable "github-user" {
  description = "user from github"
  type = string
}

variable "repositories" {
  description = "List of repositories named exactly as on GitHub"
  type = list(string)
}