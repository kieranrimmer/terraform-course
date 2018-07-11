variable "GOOGLE_PROJECT" {
  default = "kr-teraform-01"
}
variable "GOOGLE_REGION" {
  default = "australia-southeast1"
}
variable "MACHINE_TYPE" {
  default = "n1-standard-1"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "../credentials/google_compute_engine"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "../credentials/google_compute_engine.pub"
}
variable "GCE_INSTANCE_USERNAME" {
  default = "ubuntu"
}
