output "bastion_eip" {
    description = "The DNS name of the load balancer"
    value       = aws_eip.bastion_static
} 

output "vpc" {
    value = {
        vpc_id = aws_vpc.app_vpc.id
        vpc_cidr = aws_vpc.app_vpc.address
        }
    description = "the id of the app vpc to be exported to root"
}   

output "vpc_security_group_ids" {
  value = {
     rds_sg = aws_security_group.rds_security_group.id 
     alb_sg = aws_security_group.alb_sg.id
     wp1_sg = aws_security_group.wpserver_sg1.id 
     wp2_sg = aws_security_group.wpserver_sg2.id 
     b_sg   = aws_security_group.bastion1_instance_sg.id
}
} 

output "subnet_ids" {
  value = {
      wp1_sub = aws_subnet.wp_subnet_1.id
      wp2_sub = aws_subnet.wp_subnet_2.id
      pub_sub1 = aws_subnet.public_subnet_1.id
      pub_sub2 = aws_subnet.public_subnet_2.id
      data1_sub = aws_subnet.data_subnet_1.id
      data2_sub = aws_subnet.data_subnet_2.id
  }
} 

output "certificate" {
  value = aws_acm_certificate.aws_app_cert.id
} 
