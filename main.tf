data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
  cidr_block           = "10.19.0.0/16"
  enable_dns_hostnames = true

  tags {
    Name        = "${var.config_name}_aws_vpc_main"
    Config_Name = "${var.config_name}"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name        = "${var.config_name}_aws_internet_gateway_main"
    Config_Name = "${var.config_name}"
  }
}

resource "aws_route_table" "main" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

  tags {
    Name        = "${var.config_name}_aws_route_table_main"
    Config_Name = "${var.config_name}"
  }
}

resource "aws_route_table_association" "main" {
  subnet_id      = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.main.id}"
}

resource "aws_subnet" "public" {
  cidr_block              = "10.19.1.0/24"
  vpc_id                  = "${aws_vpc.main.id}"
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"
  map_public_ip_on_launch = true

  tags {
    Name        = "${var.config_name}_aws_subnet_public"
    Config_Name = "${var.config_name}"
    Tier        = "public"
  }
}
