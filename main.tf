
#_____________HOSTED_ZONE_____________________________#

resource "aws_route53_zone" "zone" {
    name            = var.domain_name
    #private_zone    = false
}

#____________SERVER_CERTIFICATE_______________________#

resource "aws_acm_certificate" "cert" {
    domain_name                 = var.domain_name
    subject_alternative_names   = ["*.${var.domain_name}"]
    validation_method           = "DNS"

    lifecycle {
        create_before_destroy = true
    }

    tags = local.tags
}

#___________VALIDATION_RECORDS_____________________________#

resource "aws_route53_record" "cert_validation_record" {
    for_each = {
        for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
            name   = dvo.resource_record_name
            record = dvo.resource_record_value
            type   = dvo.resource_record_type
        }
    }

    allow_overwrite = true
    name            = each.value.name
    records         = [each.value.record]
    ttl             = 60
    type            = each.value.type
    zone_id         = aws_route53_zone.zone.zone_id

}

#______________CERTIFICATE_VALIDATION__________________________#

resource "aws_acm_certificate_validation" "validation" {
    timeouts {
        create = "${var.cert_validation_timeout}m"
    }
    certificate_arn         = aws_acm_certificate.cert.arn
    validation_record_fqdns = [for record in aws_route53_record.cert_validation_record : record.fqdn]
}