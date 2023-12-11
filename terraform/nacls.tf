locals {
  protocols = ["tcp", "udp"]
}

resource "aws_network_acl" "public" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = aws_subnet.public[*].id

  tags = {
    Name = "public-nacl"
  }
}

resource "aws_network_acl" "private" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = aws_subnet.private[*].id

  tags = {
    Name = "private-nacl"
  }
}

# Public NACL inbound rules
resource "aws_network_acl_rule" "public_inbound" {
  for_each       = toset(local.protocols)
  network_acl_id = aws_network_acl.public.id
  rule_number    = each.key == "tcp" ? 100 : 200
  egress         = false
  protocol       = each.value
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 65535
}

# Public NACL outbound rules
resource "aws_network_acl_rule" "public_outbound" {
  for_each       = toset(local.protocols)
  network_acl_id = aws_network_acl.public.id
  rule_number    = each.key == "tcp" ? 100 : 200
  egress         = true
  protocol       = each.value
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 65535
}

# Private NACL inbound rules
resource "aws_network_acl_rule" "private_inbound" {
  for_each       = toset(local.protocols)
  network_acl_id = aws_network_acl.private.id
  rule_number    = each.key == "tcp" ? 100 : 200
  egress         = false
  protocol       = each.value
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 65535
}

# Private NACL outbound rules
resource "aws_network_acl_rule" "private_outbound" {
  for_each       = toset(local.protocols)
  network_acl_id = aws_network_acl.private.id
  rule_number    = each.key == "tcp" ? 100 : 200
  egress         = true
  protocol       = each.value
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 65535
}
