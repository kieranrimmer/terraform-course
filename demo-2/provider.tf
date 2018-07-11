provider "google" {
  credentials = "${file("../credentials/tf_cred.json")}"
  project     = "${var.GOOGLE_PROJECT}"
  region      = "${var.GOOGLE_REGION}"
}

