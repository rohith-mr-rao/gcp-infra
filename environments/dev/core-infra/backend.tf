terraform {
  backend "gcs" {
    bucket = ""
    prefix = "tf-root/dev/core-infra/"
  }
}
