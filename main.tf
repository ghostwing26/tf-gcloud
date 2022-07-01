provider "google" {
    project = "trial-bangkit"
    region = "asia-southeast2"
}

resource "google_compute_network" "devnet" { # devnet adalah nama variabel dari resourcenya, jadi bukan nama untuk di gcloudnya nanti.
  name = "devnet-vpc"
  auto_create_subnetworks = false
}


resource "google_compute_subnetwork" "devsubnet" {
  name = "devsubnet-sub"
  ip_cidr_range = "10.10.10.0/24"
  network = google_compute_network.devnet.id
  region = "asia-southeast2"
}


# data source
# nambahin vpc baru ke dalam vpc yang udah ada
# di case ini kita nambahin IP baru (devsubnet-ext-2) ke dalem vpc-nya "default"
# data "google_compute_network" "existing_net" {
#   name = "default" # nama vpc
# }

# resource "google_compute_subnetwork" "devsubnet-ext" {
#     name = "devsubnet-ext-2"
#     ip_cidr_range = "20.20.20.0/24"
#     network = data.google_compute_network.existing_net.id
#     region = "asia-southeast2"
# }

# google_compute_network dipake untuk bikin nama vpc-nya
# google_compute_subnetwork dipake untuk add IP ke dalem vpc yg dibuat

data "google_compute_network" "existing-net-2" {
    name = "devnet-vpc"
}

resource "google_compute_subnetwork" "devsubnet-ext-2" {
    name = "devsubnet-sub-2"
    ip_cidr_range = "30.30.30.0/24"
    network = data.google_compute_network.existing-net-2.id
    region = "asia-southeast2"
}