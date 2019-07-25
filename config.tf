terraform {
  backend "s3" {
    bucket = "terraform2-state-poc"
    key = "./dev/terraform.tf.state"
    region = "us-west-1"
    profile = "okta"
  }
}
