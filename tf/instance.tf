# instances
#

# test instance
resource "google_compute_instance" "ginstance" {

  name = "${var.prefix}-demo${count.index + 1}"

  machine_type = "${var.instance_type}"
  zone = "${var.zone}"

  can_ip_forward = true

  boot_disk {
    initialize_params {
      #image = "${data.google_compute_image.centos7.self_link}"
      image = "${var.os_image}"
      size  = "${var.boot_disk_size_gb}"
      type  = "${var.boot_disk_type}"
    }
  }

  count = "${var.instance_count}"

  network_interface {
    subnetwork = google_compute_subnetwork.se-subnet.self_link
    # assign ephemeral public ip
    access_config {}
  }

  metadata_startup_script = file("startup.sh")

  metadata = {
    ssh-keys = "${var.my_ssh_user}:${file(var.my_ssh_pub_key_file)}"
  }

  labels = { owner = "${var.owner}", expires-on = "${var.expires_on}", owner-slack: "${var.slack_owner}", purpose = "${var.purpose}" }
}

