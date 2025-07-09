variable "location" {
  type = string
}
variable "buckets" {
  description = "Buckets and respectives configs"
    type = map(object({
    location: optional(string)
  }))
}
variable "medalion_structure" {
  description = "It creates objects inside the current bucket for project"
  default = ["gold/", "bronze/", "silver/"]
  type = optional(list(string))
}