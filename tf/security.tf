# security
#

# ingress
resource "google_compute_firewall" "se-ingress-fw" {
  name    = "${var.prefix}-fw-ingress"
  project = "${var.project}"
  network = google_compute_network.se-network.self_link

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443", "6443", "6783", "8800", "8888", "8080-8095", "9047"]
  }

  direction = "INGRESS"

  # Allowed source cidr ranges
  source_ranges = ["${var.myCIDR}","${var.myTravelCIDR}"]
}

# Local Network Access
resource "google_compute_firewall" "se-int-ingress-fw" {
  name    = "${var.prefix}-int-ingress-fw"
  project = "${var.project}"
  network = google_compute_network.se-network.self_link

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
  }

  direction = "INGRESS"

  # Allowed source cidr ranges
  source_ranges = ["${var.subnetCIDRblock}"]
}

# GCP IAP Access
resource "google_compute_firewall" "se-iap-ingress-fw" {
  name    = "${var.prefix}-iap-ingress-fw"
  project = "${var.project}"
  network = google_compute_network.se-network.self_link

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  direction = "INGRESS"

  # Allowed source cidr ranges
  source_ranges = ["${var.gcpIAPCIDR}"]
}


# egress
resource "google_compute_firewall" "se-egress-fw" {
  name    = "${var.prefix}-fw-egress"
  project = "${var.project}"
  network = google_compute_network.se-network.self_link

  allow {
    protocol = "all"
  }

  direction = "EGRESS"

  destination_ranges = ["0.0.0.0/0"]
}

