output "cert_arn" {
    value = aws_acm_certificate.cert.arn
}

output "hosted_zone_id" {
    value = aws_route53_zone.zone.zone_id
}