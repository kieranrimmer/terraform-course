
resource "google_compute_address" "nat-ip-b" {
  name         = "my-external-address"
  address_type = "EXTERNAL"
}

resource "google_compute_instance" "default" {
  name         = "${length(google_compute_address.nat-ip-b.address) == 0 ? 
                    "example" : 
                    format("gce-instance-example-%s", random_string.project.result)}"
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
      nat_ip = "${google_compute_address.nat-ip-b.address}"
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
output "public_ip" {
  value = "${google_compute_address.nat-ip-b.address}"
} 
