output "network_name_output" {
    value = "${google_compute_network.network.name}"
}

output "network_id_output" {
    value = "${google_compute_network.network.id}"
}

output "network" {
  value       = google_compute_network.network
  description = "The VPC resource being created"
}

output "network_name" {
  value       = google_compute_network.network.name
  description = "The name of the VPC being created"
}

output "network_id" {
  value       = google_compute_network.network.id
  description = "The name of the VPC being created"
}

output "network_self_link" {
  value       = google_compute_network.network.self_link
  description = "The URI of the VPC being created"
}

output "subnets" {
  value       = [for network in google_compute_subnetwork.subnetwork : network.name]
  description = "The created subnet resources"
}

output "subnets_name" {
  value       = google_compute_subnetwork.subnetwork
  description = "The created subnet resources"
}