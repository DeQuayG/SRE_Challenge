resource "aws_placement_group" "ec2_placement_asg_group" {
  name     = "ec2_placement_asg_group"
  strategy = "${var.placement_strategy}"
  availability_zones = count.var.az[0]
}

resource "aws_launch_template" "asg_ec2_launch" {
  name_prefix   = var.name_prefix
  image_id      = var.ami
  instance_type = var.instance_type
}

resource "aws_autoscaling_group" "ec2_asg" {
  name                      = "foobar3-terraform-test"
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = "ELB"
  desired_capacity          = var.desired_capacity
  force_delete              = true
  placement_group           = aws_placement_group.ec2_placement_asg_group.id
  launch_configuration      = aws_launch_template.asg_ec2_launch.name
  vpc_zone_identifier       = aws_vpc.app_vpc.id 
  target_group_arns         = aws_lb_target_group.app_servers_target_group.arn
}