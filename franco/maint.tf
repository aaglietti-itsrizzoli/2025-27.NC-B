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
  # Configuration options
}

# VM economica con Debian 12
# e2-micro + disco standard da 10 GB. In us-west1, us-central1 e us-east1
# rientra nel free tier di GCP (una e2-micro al mese, con limiti).
resource "google_compute_instance" "debian12_vm" {
  name         = "franco"
  machine_type = "e2-micro"
  zone         = "us-central1-b" # per l'Italia: "europe-west8-b" (Milano), costa un po' di piu'

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      #size  = 10
      #type  = "pd-standard" # il tipo di disco piu' economico
    }
  }

  network_interface {
    network = "default"

    # IP pubblico effimero, serve per raggiungere la VM via SSH.
    # Rimuovi il blocco se accedi solo da rete interna / IAP (risparmi il costo dell'IPv4).
    access_config {}
  }

  tags = ["ssh"]
}

output "debian12_vm_external_ip" {
  value = google_compute_instance.debian12_vm.network_interface[0].access_config[0].nat_ip
}