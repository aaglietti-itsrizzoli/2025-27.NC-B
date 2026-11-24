terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
}

provider "google" {
  project = "exalted-pattern-424313-j3"
  region  = "europe-west1"
  zone    = "europe-west1-b"
}

variable "numero_vm" {
  description = "Numero di macchine virtuali da creare"
  type        = number
  default     = 1
}

resource "google_compute_instance" "vm_musolino" {
  count        = var.numero_vm
  name         = "vm-musolino-${count.index + 1}"
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
      # Assegna un IP pubblico effimero
    }
  }
}