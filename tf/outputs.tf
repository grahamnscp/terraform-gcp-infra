# outputs
#

output "instance-public-ip" {
  value = google_compute_instance.ginstance.*.network_interface.0.access_config.0.nat_ip
}

output "instance-name" {
  value = google_compute_instance.ginstance.*.name
}

output "instance-private-ip" {
  value = google_compute_instance.ginstance.*.network_interface.0.network_ip
}

