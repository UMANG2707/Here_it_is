variable "profile" {
  type = string
}

variable "aws_region" {
  description = "The AWS region where resources will be deployed"
  type        = string
  default     = "us-east-1"
}

variable "vpc_name" {
  default = "simpletimeservice-vpc"
}

variable "ecs_cluster_name" {
  default = "simpletimeservice-cluster"
}
