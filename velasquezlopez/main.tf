terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "google" {
  project = "exalted-pattern-424313-j3"
  region  = "europe-west1"
}

variable "numero_vm" {
  description = "Numero di istanze VM da creare"
  type        = number
  default     = 5
}

resource "google_compute_instance" "vm_debian" {
  count        = var.numero_vm
  name         = "vm-velasquez-${count.index + 1}"
  machine_type = "e2-micro"
  zone         = "europe-west1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network = "default"

    access_config {

    }
  }
}