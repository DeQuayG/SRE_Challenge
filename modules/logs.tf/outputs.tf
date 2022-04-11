output "canary_id" {
  value = aws_synthetics_canary.synthetic_canary.id
} 

output "cloudwatch_id" {
  value = aws_cloudwatch_log_group.cw_log_group.id
} 

output "aws_flow_log_id" {
  value = aws_flow_log.vpc_flow_log.id
} 

output "log_iam_role_id" {
  value = aws_iam_role.log_watcher.id
} 

output "canary_iam_role" {
  value = aws_iam_role.canary_role.id
}