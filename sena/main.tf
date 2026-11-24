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

variable "vm_count" {
  description = "Numero di VM da creare"
  type        = number
  default     = 3
}

resource "google_compute_instance" "vm_debian" {
  count        = var.vm_count
  name         = "vm-sena-${count.index + 1}"
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
      # Assegna un IP pubblico effimero
    }
  }
}
