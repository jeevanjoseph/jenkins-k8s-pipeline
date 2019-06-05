variable "region" {
  default = "us-phoenix-1"
  description = "The region to target with this provider configuration. "
}
provider "oci" {
  auth = "InstancePrincipal"
  region = "${var.region}"
  version = "~> 3.27"

}

# Get a list of Availability Domains
data "oci_identity_availability_domains" "ads" {
  compartment_id = "ocid1.tenancy.oc1..aaaaaaaawpqblfemtluwxipipubxhioptheej2r32gvf7em7iftkr3vd2r3a"
}

# Output the result
output "show-ads" {
  value = "${data.oci_identity_availability_domains.ads.availability_domains}"
}
