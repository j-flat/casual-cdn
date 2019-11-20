variable "PROJECT" {}
variable "TARGET_SERVICE_ACCOUNT" {}

provider "google" {
    version = "~> 2.5"
    region = "europe-north1"
    zone = "europe-north1-a"
    project = "${var.PROJECT}"
}

data "google_service_account_access_token" "default" {
    provider = "google"
    target_service_account = "${var.TARGET_SERVICE_ACCOUNT}"
    scopes = ["userinfo-email", "cloud-platform"]
    lifetime = "300s"
}

provider "google" {
    alias = "impersonated"
    access_token = "${data.google_service_account_access_token.default.access_token}"
    project = "${var.PROJECT}"
    region = "europe-north1"
    zone = "europe-north1-a"
}