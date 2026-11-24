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
  #  region  = "us-central1"

}

variable "vm_count" {
  description = "Numero di VM da creare"
  type        = number
  default     = 5
}

resource "google_compute_instance" "vm" {
  count        = var.vm_count
  name         = "fusi-${count.index + 1}"
  machine_type = "e2-micro" # il taglio più economico (2 vCPU condivise, 1 GB RAM)
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = 10            # GB
      type  = "pd-standard" # disco più economico
    }
  }

  network_interface {
    network = "default"

    # IP pubblico effimero: rimuovi il blocco se non ti serve l'accesso da internet
    access_config {}
  }
}