# File for route 53 network confirguration 
# To prevent the main files from becoming too bloated

resource "aws_acm_certificate" "aws_app_cert" {
  domain_name       = "${var.hosted_domain}"
  validation_method = "DNS"

  tags = {
    Environment = "${var.environment_name}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_zone" "hosted_zone" {
  name = var.hosted_domain
}

resource "aws_route53_record" "myRecord" {
  zone_id = aws_route53_zone.hosted_zone.id
  name    = var.hosted_domain
  type    = "A" 

  alias {
      name                   = var.lb_dns_name
      zone_id                = aws_route53_zone.hosted_zone.id
      evaluate_target_health = true
  }
}

