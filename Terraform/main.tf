resource "google_service_account" "vm_service_account" {
  account_id   = "service_account_id"
  display_name = "Service Account for VM"
}

resource "google_compute_instance" "vm_instance" {
  name         = "vm-test-instance"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  
  tags = ["flag", "find"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  # Disco SSD local para armazenamento temporário
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"

    access_config {
      # Gera um IP público efêmero
    }
  }

  metadata = {
    flag = "find"
  }

  # Configuração da conta de serviço
  service_account {
    email  = google_service_account.vm_service_account.email
    scopes = ["cloud-platform"]
  }
}
