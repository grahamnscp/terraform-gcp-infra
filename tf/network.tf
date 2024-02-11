# network
#

# vpc network
resource "google_compute_network" "se-network" {
  name = "${var.prefix}-network"
  project = "${var.project}"
}

# subnet
resource "google_compute_subnetwork" "se-subnet" {
  name   = "${var.prefix}-subnet"
  region = "${var.region}"

  ip_cidr_range = "${var.subnetCIDRblock}"

  network = google_compute_network.se-network.id
}

# gateway

# route

# associate route to subnet
