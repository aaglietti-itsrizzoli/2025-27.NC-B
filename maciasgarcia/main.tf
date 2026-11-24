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
}

resource "google_compute_instance" "debian_minimal" {
  name         = "debian-12-maciasgarcia"
  machine_type = "e2-micro" # Tier minimo (2 vCPU condivise, 1 GB RAM)
  zone         = "us-central1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      #size  = 10            # Minimo consentito per Debian 12 (GB)
      #type  = "pd-standard" # Tipo di disco più economico
    }
  }

  network_interface {
    network = "default"

    # Assegna un IP pubblico effimero per poterti connettere via SSH.
    # Rimuovi questo blocco se non ti serve accesso diretto da Internet.
    access_config {}
  }

  # Permette a Terraform di fermare la VM se in futuro cambi machine_type
  allow_stopping_for_update = true
}