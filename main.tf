resource "aws_vpc" "main" {
  cidr_block           = "10.19.0.0/16"
  enable_dns_hostnames = true

  tags {
    Name      = "${var.namespace}_aws_vpc_main"
    Namespace = "${var.namespace}"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name      = "${var.namespace}_aws_internet_gateway_main"
    Namespace = "${var.namespace}"
  }
}

resource "aws_route_table" "main" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

  tags {
    Name      = "${var.namespace}_aws_route_table_main"
    Namespace = "${var.namespace}"
  }
}

resource "aws_route_table_association" "main" {
  subnet_id      = "${aws_subnet.main.id}"
  route_table_id = "${aws_route_table.main.id}"
}

resource "aws_subnet" "main" {
  cidr_block              = "10.19.1.0/24"
  vpc_id                  = "${aws_vpc.main.id}"
  map_public_ip_on_launch = true

  tags {
    Name      = "${var.namespace}_aws_subnet_main"
    Namespace = "${var.namespace}"
    Tier      = "public"
  }
}
