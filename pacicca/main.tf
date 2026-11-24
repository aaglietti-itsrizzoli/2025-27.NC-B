terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "8.12.0"
    }
  }
}

provider "google" {
  # Configuration options
  project = "exalted-pattern-424313-j3" #il plugin di google cloud lavorerà su questo resource group
}