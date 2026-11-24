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

variable "vm_count" {
  description = "Number of Debian VMs to create"
  type        = number

  validation {
    condition     = var.vm_count >= 0 && floor(var.vm_count) == var.vm_count
    error_message = "vm_count must be a non-negative whole number."
  }
}

variable "vm_machine_type" {
  description = "Machine type shared by all VMs"
  type        = string
  default     = "e2-micro"
}

variable "vm_zone" {
  description = "Google Cloud zone shared by all VMs"
  type        = string
  default     = "europe-west8-b"
}

variable "vm_image" {
  description = "Boot disk image shared by all VMs"
  type        = string
  default     = "projects/debian-cloud/global/images/family/debian-12"
}

variable "vm_network" {
  description = "Network shared by all VMs"
  type        = string
  default     = "default"
}

variable "vm_disk_size_gb" {
  description = "Optional boot disk size in GB; null uses the image's size"
  type        = number
  default     = null
}

variable "vm_public_ip" {
  description = "Whether to assign an ephemeral public IP to each VM"
  type        = bool
  default     = false
}

resource "google_compute_instance" "debian12" {
  count        = var.vm_count
  name         = "marannino-vm-${count.index + 1}"
  machine_type = var.vm_machine_type
  zone         = var.vm_zone

  boot_disk {
    initialize_params {
      image = var.vm_image
      size  = var.vm_disk_size_gb
    }
  }

  network_interface {
    network = var.vm_network

    dynamic "access_config" {
      for_each = var.vm_public_ip ? [true] : []

      content {}
    }
  }
}
