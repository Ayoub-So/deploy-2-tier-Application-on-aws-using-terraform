# allocate elastic ip. this eip will be used for the nat-gateway in the public subnet pub-sub-1-a
resource "aws_eip" "eip-nat-a" {

  tags   = {
    Name = "eip-nat-a"
  }
}

# allocate elastic ip. this eip will be used for the nat-gateway in the public subnet pub-sub-2-b
resource "aws_eip" "eip-nat-b" {

  tags   = {
    Name = "eip-nat-b"
  }
}

#create NAT gatway
resource "aws_nat_gateway" "nat-a" {
  allocation_id = aws_eip.eip-nat-a.id
  subnet_id     = var.pub_sub_1a_id

  tags = {
    Name = "nat-a"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [var.igw_id]
}

#create NAT gatway
resource "aws_nat_gateway" "nat-b" {
  allocation_id = aws_eip.eip-nat-b.id
  subnet_id     = var.pub_sub_2a_id

  tags = {
    Name = "nat-b"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [var.igw_id]
}

# create private route table Pri-RT-A and add route through NAT-GW-A
resource "aws_route_table" "pri-rt-a" {
    vpc_id = var.vpc_id

  tags = {
    Name= "pri-rt-a"
  }
}

resource "aws_route" "pri-rt-a-route" {
  route_table_id         = aws_route_table.pri-rt-a.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat-a.id
}

## associate private subnet pri-sub-3-a with private route table Pri-RT-A
resource "aws_route_table_association" "pri-sub-3a-with-pri-rt-a" {
    subnet_id = var.pri_sub_3a_id
    route_table_id = aws_route_table.pri-rt-a.id
  
}
## associate private subnet pri-sub-4-a with private route table Pri-RT-B
resource "aws_route_table_association" "pri-sub-4b-with-pri-rt-b" {
    subnet_id = var.pri_sub_4b_id
    route_table_id = aws_route_table.pri-rt-a.id
  
}

# create private route table Pri-rt-b and add route through nat-b
resource "aws_route_table" "pri-rt-b" {
  vpc_id            = var.vpc_id

  tags   = {
    Name = "pri-rt-b"
  }
}

resource "aws_route" "pri-rt-b-route" {
  route_table_id         = aws_route_table.pri-rt-b.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat-b.id
}

# associate private subnet pri-sub-5a with private route Pri-rt-b
resource "aws_route_table_association" "pri-sub-5a-with-pri-rt-b" {
  subnet_id         = var.pri_sub_5a_id
  route_table_id    = aws_route_table.pri-rt-b.id
}

# associate private subnet pri-sub-6b with private route table Pri-rt-b
resource "aws_route_table_association" "pri-sub-6b-with-pri-rt-b" {
  subnet_id         = var.pri_sub_6b_id
  route_table_id    = aws_route_table.pri-rt-b.id
}