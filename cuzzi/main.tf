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
  region  = "europe-west8"
  zone    = "europe-west8-a"
}

# Quante VM creare
variable "numero_vm" {
  type        = number
  description = "Numero di VM da creare"
  default     = 1
}

# Il blocco viene ripetuto numero_vm volte grazie a count
resource "google_compute_instance" "vm" {
  count        = var.numero_vm
  name         = "cuzzi-${count.index + 1}"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network = "default"
  }
}

# Alla fine stampa i nomi delle VM create
output "nomi_vm" {
  value = google_compute_instance.vm[*].name
}