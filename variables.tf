variable "region" {
  description = "The AWS region where resources will be created."
  type        = string
  default     = "us-east-1"
}

variable "access_key" {
  description = "AWS access key."
  type        = string
  # No default for sensitive values
}

variable "secret_key" {
  description = "AWS secret key."
  type        = string
  # No default for sensitive values
}

variable "name_prefix" {
  description = "A prefix for resource names to ensure uniqueness and avoid clashes."
  type        = string
  default     = "my-openshift"
}

variable "resource_group_name" {
  description = "The name of the resource group for grouping resources."
  type        = string
  default     = "openshift-resources"
}

variable "base_domain_name" {
  description = "The base domain name for the OpenShift cluster."
  type        = string
  default     = "example.com"
}

variable "cluster_name" {
  description = "The name of the OpenShift cluster."
  type        = string
  default     = "openshift-cluster"
}

variable "pull_secret" {
  description = "The pull secret for the OpenShift cluster as a JSON string."
  type        = string
  # No default for sensitive values
}

variable "openshift_version" {
  description = "The version of OpenShift to install."
  type        = string
  default     = "4.10"
}
