output "lb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.external-elb.dns_name
} 

output "alb_arn" {
  value = aws_alb.app_servers_alb.id
} 

output "alb_listener" {
  value = aws_alb_listener.app_service_https.arn
}