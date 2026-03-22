
#create vpc
resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"
    
    tags = {
        Name = "${var.project_name}-vpc"
    }
  
}

resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_vpc.vpc.id

    tags = {
      Name = "${var.project_name}-igw"
    }
  
}

# use data source to get all availability zones in region
data "aws_availability_zones" "available_zones" {
  
}

# create public subnet pub_sub_1a
resource "aws_subnet" "pub_sub_1a" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.pub_sub_1a_cidr
    availability_zone = data.aws_availability_zones.available_zones.names[0]
    map_public_ip_on_launch = true

    tags = {
        Name = "pub_sub_1a"
    }

}

# create public subnet pub_sub_2a
resource "aws_subnet" "pub_sub_2a" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.pub_sub_2a_cidr
    availability_zone = data.aws_availability_zones.available_zones.names[1]
    map_public_ip_on_launch = true

    tags = {
        Name = "pub_sub_2a"
    }

}


# create private subnet pri_sub_3a
resource "aws_subnet" "pri_sub_3a" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.pri_sub_3a_cidr
    availability_zone = data.aws_availability_zones.available_zones.names[0]
    map_public_ip_on_launch = false

    tags = {
        Name = "pri_sub_3a"
    }

}
# create private subnet pri_sub_4a
resource "aws_subnet" "pri_sub_4a" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.pri_sub_4b_cidr
    availability_zone = data.aws_availability_zones.available_zones.names[1]
    map_public_ip_on_launch = false

    tags = {
        Name = "pri_sub_4a"
    }

}

# create private db subnet pri_sub_5a
resource "aws_subnet" "pri_sub_5a" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.pri_sub_5a_cidr
    availability_zone = data.aws_availability_zones.available_zones.names[0]
    map_public_ip_on_launch = false

    tags = {
        Name = "pri_sub_5a"
    }

}

# create private subnet pri_sub_6a
resource "aws_subnet" "pri_sub_6a" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.pri_sub_6b_cidr
    availability_zone = data.aws_availability_zones.available_zones.names[1]
    map_public_ip_on_launch = false

    tags = {
        Name = "pri_sub_6a"
    }

}

#create route table and add public route
resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.vpc.id

    tags = {
      Name = "Public-rt"
    }
}

resource "aws_route" "public-route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}

#associate public subnet pub-sub-1a to public route table
resource "aws_route_table_association" "pub-sub-1a_route_table_association" {
    subnet_id = aws_subnet.pub_sub_1a.id
    route_table_id = aws_route_table.public_route_table.id
  
}

#associate public subnet pub-sub-2a to public route table
resource "aws_route_table_association" "pub-sub-2a_route_table_association" {
    subnet_id = aws_subnet.pub_sub_2a.id
    route_table_id = aws_route_table.public_route_table.id
  
}