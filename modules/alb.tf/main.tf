module "aws_alb" "app_servers_alb" {
  name               = "${var.app_name}-${var.environment_name}-web-app-lb"
  internal           = false
  load_balancer_type = "application"

  subnets = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id,
  ]

  security_groups = [
    aws_security_group.wpserver_sg1.id,
    aws_security_group.wpserver_sg2.id,
    aws_security_group.alb_security_group.id
  ]

  depends_on = [aws_internet_gateway.igw]
} 

module "aws_lb_target_group" "app_servers_target_group" {
  name        = "app_servers"
  port        =  443
  protocol    = "HTTPS"
  target_type = "instance"
  vpc_id      = aws_vpc.app_vpc.id

  health_check {
    enabled = true
    healthy_threshold = 3 
    unhealthy_threshold = 3
    interval = 10
    path    = "/"
  }
}

module "aws_alb_listener" "app_service_https" {
  load_balancer_arn = aws_alb.app_service_alb.arn
  port              = "443"
  protocol          = "HTTPS"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.app_servers_target_group.arn
  } 
} 

module "aws_lb_listener" "http_to_https" {
  load_balancer_arn = aws_alb.app_servers_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
} 

module "aws_lb_target_group_attachment" "alb_attach_group" {
  target_group_arn = aws_lb_target_group.app_servers_target_group.arn
  target_id        = aws_instance.instance_1.id
  port             = 443
}

module "aws_lb_listener_certificate" "encrypted_listener" {
  listener_arn    = aws_alb_listener.app_service_https.arn
  certificate_arn = aws_acm_certificate.aws_app_cert.arn
}