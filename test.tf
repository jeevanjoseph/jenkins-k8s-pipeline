variable "region" {
  default = "us-phoenix-1"
  description = "The region to target with this provider configuration. "
}
provider "oci" {
  auth = "InstancePrincipal"
  region = var.region
  version = "~> 3.27"

}

# Get a list of Availability Domains
data "oci_identity_availability_domains" "ads" {
  compartment_id = "ocid1.tenancy.oc1..aaaaaaaaa3qmjxr43tjexx75r6gwk6vjw22ermohbw2vbxyhczksgjir7xdq"
}

# Output the result
output "show-ads" {
  value = data.oci_identity_availability_domains.ads.availability_domains
}
