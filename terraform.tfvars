# AWS Configuration
region        = "us-east-1" # Example AWS region
access_key    = "your_aws_access_key_here"
secret_key    = "your_aws_secret_key_here"

# VPC and Subnet Configuration
name_prefix           = "example-ocp-sno"
resource_group_name   = "example-resource-group"

# OpenShift Cluster Configuration
base_domain_name      = "example.com" # Your base domain for the OpenShift cluster
cluster_name          = "ocp-sno-cluster"
pull_secret           = "{\"auths\":...}" # Your OpenShift pull secret in JSON format

# Note: 
# The pull_secret value should be the entire JSON pull secret provided by Red Hat for OpenShift.
# Make sure to escape double quotes inside the JSON string or use a tool to minify and escape the JSON for Terraform.
