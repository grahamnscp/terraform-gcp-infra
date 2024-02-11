# instances
#

# gcloud compute images list
#
data "google_compute_image" "centos7" {
  family  = "centos-7"
  project = "centos-cloud"
}
data "google_compute_image" "ubuntu2204" {
  family  = "ubuntu-pro-2204-lts"
  project = "ubuntu-os-pro-cloud"
}
data "google_compute_image" "debian11" {
  family  = "debian-11"
  project = "debian-cloud"
}
