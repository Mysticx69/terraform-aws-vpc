# AWS VPC Terraform module
Terraform module which creates VPC resources on AWS.

## Usage

```hcl
locals {
  region                       = "us-east-1"
  mockinfra_availability_zones = ["${local.region}a", "${local.region}b", "${local.region}c"]
}

module "vpc" {
  source  = "git::https://github.com/Mysticx69/terraform-aws-vpc.git?ref=commit_hash_you_chose"

  # insert required variables here
  environment          = "MockInfra"
  vpc_cidr             = "10.150.0.0/16"
  public_subnets_cidr  = ["10.150.1.0/24", "10.150.2.0/24"]
  private_subnets_cidr = ["10.150.10.0/24", "10.150.20.0/24"]
  availability_zones   = local.mockinfra_availability_zones

  tags = {
    DeployedBy = "Terraform"
    Date = "xxxx"
    Author = "xxxx"
    ...
  }
}
 ```
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.9.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~>5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.71.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_default_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group) | resource |
| [aws_eip.nat_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.private_nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.public_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.private_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | AZ in which all the resources will be deployed | `list(string)` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Deployment Environment | `string` | n/a | yes |
| <a name="input_igw_tags"></a> [igw\_tags](#input\_igw\_tags) | Additional tags for Internet Gateway resource | `map(string)` | `{}` | no |
| <a name="input_nat_tags"></a> [nat\_tags](#input\_nat\_tags) | Additional tags for NAT Gateway resource | `map(string)` | `{}` | no |
| <a name="input_private_subnets_cidr"></a> [private\_subnets\_cidr](#input\_private\_subnets\_cidr) | CIDR block for Private Subnet(s) | `list(string)` | n/a | yes |
| <a name="input_privrt_tags"></a> [privrt\_tags](#input\_privrt\_tags) | Additional tags for private route table resource | `map(string)` | `{}` | no |
| <a name="input_privsubs_tags"></a> [privsubs\_tags](#input\_privsubs\_tags) | Additional tags for private subnets resources | `map(string)` | `{}` | no |
| <a name="input_public_subnets_cidr"></a> [public\_subnets\_cidr](#input\_public\_subnets\_cidr) | CIDR block for Public Subnet(s) | `list(string)` | n/a | yes |
| <a name="input_pubrt_tags"></a> [pubrt\_tags](#input\_pubrt\_tags) | Additional tags for public route table resource | `map(string)` | `{}` | no |
| <a name="input_pubsubs_tags"></a> [pubsubs\_tags](#input\_pubsubs\_tags) | Additional tags for public subnets resources | `map(string)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block for the vpc | `string` | n/a | yes |
| <a name="input_vpc_tags"></a> [vpc\_tags](#input\_vpc\_tags) | Additional tags for VPC resource | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_sg_id"></a> [default\_sg\_id](#output\_default\_sg\_id) | Output the default security group id |
| <a name="output_private_subnets_cidr"></a> [private\_subnets\_cidr](#output\_private\_subnets\_cidr) | Output all CIDR block of private subnets in a list |
| <a name="output_private_subnets_id"></a> [private\_subnets\_id](#output\_private\_subnets\_id) | Output all private subnets ids in a list |
| <a name="output_public_subnets_cidr"></a> [public\_subnets\_cidr](#output\_public\_subnets\_cidr) | Output all CIDR block of public subnets in a list |
| <a name="output_public_subnets_id"></a> [public\_subnets\_id](#output\_public\_subnets\_id) | Output all public subnets ids in a list |
| <a name="output_vpc_cidr"></a> [vpc\_cidr](#output\_vpc\_cidr) | Output the CIDR block of VPC |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | Output the VPC id |
<!-- END_TF_DOCS -->
