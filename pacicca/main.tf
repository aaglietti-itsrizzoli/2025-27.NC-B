terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "8.12.0"
    }
  }
}

provider "google" {
  project = "exalted-pattern-424313-j3" #il plugin di google cloud lavorerà su questo resource group
  # region  = "europe-west8"
}

resource "google_compute_instance" "pincopallino" {
  name         = "Pacicca"
  machine_type = "e2-micro"
  zone         = "europe-west8-a"


  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12" #obbligatorio
      # size  = 10
      # type  = "pd-standard"
    }
  }

  network_interface {
    network = "default"

    access_config {
      # Assegna un indirizzo IPv4 pubblico effimero.
    }
  }
}
