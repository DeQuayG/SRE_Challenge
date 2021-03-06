resource "aws_vpc" "app_vpc" {
  cidr_block = var.cidr_block["vpc"] 
  enable_dns_hostnames             = true
  enable_dns_support               = true 

  tags = {
    "Name" = "${var.app_name}-${var.environment_name}-vpc"
  }
}

### Public Subnets #####
resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = var.cidr_block["public_subnet_1"]
  availability_zone = var.az[0] 

  tags = {
    "Name" = "public subnet 1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = var.cidr_block["public_subnet_2"]
  availability_zone = var.az[1]

  tags = {
    "Name" = "public subnet 2"
  }
}

### Web Application Subnets #####
resource "aws_subnet" "wp_subnet_1" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = var.cidr_block["private_subnet_1"]
  availability_zone = var.az[0] 
  map_public_ip_on_launch         = false

  tags = {
    "Name" = "web app subnet 1"
  }
} 

resource "aws_subnet" "wp_subnet_2" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = var.cidr_block["private_subnet_2"]
  availability_zone = var.az[1] 
  map_public_ip_on_launch         = false

  tags = {
    "Name" = "web app subnet 2"
  }
} 


### Database Subnets #####
resource "aws_subnet" "data_subnet_1" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = var.cidr_block["data_subnet_1"]
  availability_zone = var.az[0] 
  map_public_ip_on_launch         = false

  tags = {
    "Name" = "db subnet 1"
  }
}

resource "aws_subnet" "data_subnet_2" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = var.cidr_block["data_subnet_2"]
  availability_zone = var.az[1] 
  map_public_ip_on_launch         = false

  tags = {
    "Name" = "db subnet 2"
  }
}

##########Just a segmentation Marker, make it easier to read###########
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.app_vpc.id
  tags = {
    "Name" = "igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.app_vpc.id
  tags = {
    "Name" = "public route table"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.app_vpc.id
  tags = {
    "Name" = "private route table"
  }
} 

## The 0.0.0.0/0 iniodcates that the route table will be associated with every
# IP that isn't the subnets' own IP's, and direct that traffic to the IGW, 
# Terraform will handle the rest
resource "aws_route" "public_igw" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_subnet_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_subnet_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "wp_subnet_1" {
  subnet_id      = aws_subnet.wp_subnet_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "wp_subnet_2" {
  subnet_id      = aws_subnet.wp_subnet_2.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "data_subnet_1" {
  subnet_id      = aws_subnet.data_subnet_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "data_subnet_2" {
  subnet_id      = aws_subnet.data_subnet_2.id
  route_table_id = aws_route_table.private.id
}

resource "aws_eip" "bastion_static" {
  instance = var.aws_instance.bastion1.id
  vpc = true
}

