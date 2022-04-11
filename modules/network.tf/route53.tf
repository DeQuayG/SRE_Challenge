# File for route 53 network confirguration 
# To prevent the main files from becoming too bloated

module "aws_acm_certificate" "aws_app_cert" {
  domain_name       = "${var.hosted_domain}"
  validation_method = "DNS"

  tags = {
    Environment = "${var.environment_name}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

module "aws_route53_zone" "hosted_zone" {
  name = var.hosted_domain
}

module "aws_route53_record" "myRecord" {
  zone_id = aws_route53_zone.hosted_zone.id
  name    = var.hosted_domain
  type    = "A" 

  alias {
      name                   = aws_lb.app_servers_alb.dns_name
      zone_id                = aws_route53_zone.hosted_zone.id
      evaluate_target_health = true
  }
}

