resource "aws_placement_group" "ec2_placement_asg_group" {
  name     = "ec2_placement_asg_group"
  strategy = "${var.placement_strategy}"
}

resource "aws_launch_template" "asg_ec2_launch" {
  name_prefix   = var.name_prefix
  image_id      = var.ami
  instance_type = var.instance_type
}

resource "aws_autoscaling_group" "ec2_asg" {
  name                      = var.asg_name
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = "ELB"
  desired_capacity          = var.desired_capacity
  force_delete              = true
  placement_group           = aws_placement_group.ec2_placement_asg_group.id
  launch_configuration      = aws_launch_template.asg_ec2_launch.name
  vpc_zone_identifier       = var.vpc_id
  target_group_arns         = var.target_group_arn
}