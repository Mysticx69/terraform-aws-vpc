variable "availability_zones" {
  type        = list(string)
  description = "AZ in which all the resources will be deployed"
}

variable "environment" {
  type        = string
  description = "Deployment Environment"
}

variable "igw_tags" {
  description = "Additional tags for Internet Gateway resource"
  type        = map(string)
  default     = {}
}

variable "nat_tags" {
  description = "Additional tags for NAT Gateway resource"
  type        = map(string)
  default     = {}
}

variable "private_subnets_cidr" {
  type        = list(string)
  description = "CIDR block for Private Subnet(s)"
}

variable "privrt_tags" {
  description = "Additional tags for private route table resource"
  type        = map(string)
  default     = {}
}

variable "privsubs_tags" {
  description = "Additional tags for private subnets resources"
  type        = map(string)
  default     = {}
}

variable "public_subnets_cidr" {
  type        = list(string)
  description = "CIDR block for Public Subnet(s)"
}

variable "pubrt_tags" {
  description = "Additional tags for public route table resource"
  type        = map(string)
  default     = {}
}

variable "pubsubs_tags" {
  description = "Additional tags for public subnets resources"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the vpc"
}

variable "vpc_tags" {
  description = "Additional tags for VPC resource"
  type        = map(string)
  default     = {}
}
