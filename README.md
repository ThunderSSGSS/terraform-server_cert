# AWS Server Cert Terraform module

Terraform module which creates a hosted zone, certificate and validate it using DNS method.<br>
**Important**: This module is not finished.

This modules will:
* Creates a route53 hosted zone;
* Creates a acm certificate;
* Create route53 records to validate the certificate.
* Wait a minutes to check the validation state of the certificate.

**NB**: Validate a certificate using DNS method can take 10 minutes or more, depends of your DNS providers.


## Requirements
The module was tested using:
| Name | Versions |
|------|----------|
| terraform | >= 1.0 |
| aws provider | >= 3.0 |

## Usage

### Creating and validating a certificate for the domain: example.com
```hcl
module "example" {
    source                  = "github.com/ThunderSSGSS/terraform-server_cert"
    domain_name             = "example.com"
    cert_validation_timeout = 10
}
```

## Resources

| Name | Type |
|------|------|
| [aws_route53_zone.zone](https://registry.terraform.io/providers/hashicorp/aws/3.6.0/docs/data-sources/route53_zone) | resource |
| [aws_acm_certificate.cert](https://registry.terraform.io/providers/hashicorp/aws/3.11.0/docs/resources/acm_certificate) |  resource |
| [aws_route53_record.cert_validation_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | map of resources |
| [aws_acm_certificate_validation.validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| domain_name | The name of the hosted zone | string | null | yes |
| environment | Tag 'Environment' of the certificate on ACM | string | " " | no |
| managed_by | Tag 'Managed_by' of the certificate on ACM | string | " " | no |
| cert_validation_timeout | Time in minutes to wait for the validation | number | 10 | no |

## Outputs

| Name | Description |
|------|-------------|
| cert_arn | ACM certificate arn |
| hosted_zone_id | Route53 hosted zone id |


## DevInfos:
- Name: James Artur (Thunder);
- A DevOps and infrastructure enthusiastics.