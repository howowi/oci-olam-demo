variable "compartment_ocid" {
  description = "OCID of the compartment where VCN, Compute and Opensearch will be created"
}

variable "vm_instance_name" {
  description = "Name of the compute instance to configure PostgreSQL and/or create Application resources."
}

variable "node_shape" {
  description = "Instance shape to use for master instance."
}

variable "node_flex_shape_memory" {
  description = "Flex Instance shape Memory (GB)"
}

variable "node_flex_shape_ocpus" {
  description = "Flex Instance shape OCPUs"
}