
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
  region  = "europe-west1"
  zone    = "europe-west1-b"
}

variable "numero_vm" {
  description = "Numero di macchine virtuali da creare"
  type        = number
  default     = 5

  validation {
    condition     = var.numero_vm >= 1 && floor(var.numero_vm) == var.numero_vm
    error_message = "Il numero di VM deve essere un intero positivo."
  }
}

resource "google_compute_instance" "vm" {
  count = var.numero_vm

  name         = "somaini-vm-${count.index + 1}"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = 10
      type  = "pd-standard"
    }
  }

  network_interface {
    network = "default"
  }
}

output "nomi_vm" {
  description = "Nomi delle VM create"
  value       = google_compute_instance.vm[*].name
}