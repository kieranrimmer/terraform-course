
resource "google_compute_address" "default" {
  name         = "my-external-address"
  address_type = "EXTERNAL"
}

resource "google_compute_instance" "default" {
  name         = "example"
  machine_type = "${var.MACHINE_TYPE}"
  zone         = "${var.GOOGLE_REGION}-b"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-8"
    }
  }

  // Local SSD disk
  scratch_disk {
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata {
    foo = "bar"
    sshKeys = "${var.GCE_INSTANCE_USERNAME}:${file("${var.PATH_TO_PUBLIC_KEY}")}"
    startup-script = "${file("script.sh")}"
  }

  // provisioner "file" {
  //   source = "script.sh"
  //   destination = "/tmp/script.sh"
  // }
  // provisioner "remote-exec" {
  //   inline = [
  //     "chmod +x /tmp/script.sh",
  //     "sudo /tmp/script.sh"
  //   ]
  // }
  connection {
    user = "${var.GCE_INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }
}
