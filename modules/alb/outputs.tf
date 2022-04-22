output "lb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_alb.app_servers_alb.dns_name
} 

output "alb_arn" {
  value = aws_alb.app_servers_alb.id
} 

output "alb_listener" {
  value = aws_alb_listener.app_service_https.arn 
} 

output "alb_target_group" {
  value = aws_lb_target_group.app_servers_target_group.arn
}