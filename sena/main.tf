terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "8.12.0"
    }
  }
}

provider "google" {
  project = "exalted-pattern-424313-j3"
  # region  = "europe-west8"
}

resource "google_compute_instance" "vm_debian" {
  name         = "sena"
  machine_type = "e2-micro"
  zone         = "europe-west8-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      # size  = 10
      # type  = "pd-standard"
    }
  }

  network_interface {
    network = "default"
    access_config {
      # Lascia vuoto per assegnare un IP pubblico effimero
    }
  }
}
