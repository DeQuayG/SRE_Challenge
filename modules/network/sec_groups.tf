## Web App Security Groups ##
resource "aws_security_group" "wpserver_sg1" {
  name        = "wpserver_sg1"
  description = "traffic allowed in/out of the wpserver"
  vpc_id      = aws_vpc.app_vpc.id

  ingress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    security_groups = [wpserver_sg2.id, alb_security_group.id, rds_security_group.id]
  }

  egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      security_groups = [wpserver_sg2.id, alb_security_group.id, rds_security_group.id]
    }
  }

resource "aws_security_group" "wpserver_sg2" {
  name        = "wpserver_sg2"
  description = "traffic allowed in/out of the wpserver"
  vpc_id      = aws_vpc.app_vpc.id

  ingress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    security_groups = [wpserver_sg2.id, alb_security_group.id, rds_security_group.id]
  }

  egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      security_groups = [wpserver_sg2.id, alb_security_group.id, rds_security_group.id]
    }
  }

## Bastion Host Security Group ## 
resource "aws_security_group" "bastion1_instance_sg" {
  name        = "bastion1_instance_sg"
  description = "traffic allowed in/out of the bastion host"
  vpc_id      = aws_vpc.app_vpc.id
}


resource "aws_security_group_rule" "bastion_ingress_1" {
  type              = "ingress"
  from_port         = 3389
  to_port           = 3389
  protocol          = "RDP"
  cidr_blocks       = var.cidr_block
  security_group_id = aws_security_group.bastion1_instance_sg.id
}

resource "aws_security_group_rule" "bastion_ingress_2" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "SSH"
  cidr_blocks       = var.cidr_block
  security_group_id = aws_security_group.bastion1_instance_sg.id
} 

resource "aws_security_group_rule" "bastion_egress_1" {
  type              = "egress"
  from_port         = 22
  to_port           = 22
  protocol          = "SSH"
  cidr_blocks       = var.cidr_block
  security_groups   = [wpserver_sg2, alb_security_group, rds_security_group]
  security_group_id = aws_security_group.bastion1_instance_sg.id
} 

resource "aws_security_group_rule" "bastion_egress_2" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "SSH"
  cidr_blocks       = var.cidr_block
  security_groups   = [wpserver_sg2, alb_security_group, rds_security_group]
  security_group_id = aws_security_group.bastion1_instance_sg.id
} 

## ALB Security Group ##
resource "aws_security_group" "alb_sg" {
  name        = "alb_security_group"
  description = "application load balancer security group"
  vpc_id      = "${aws_vpc.app_vpc.id}"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "${var.allowed_cidr_blocks}"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = "${var.allowed_cidr_blocks}"
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  } 
}