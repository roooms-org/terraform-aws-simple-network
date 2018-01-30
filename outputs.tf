output "vpc_id" {
  description = "VPC ID"
  value       = "${aws_vpc.main.id}"
}

output "subnet_id" {
  description = "Subnet ID"
  value       = "${aws_subnet.main.id}"
}

output "availability_zone" {
  description = "Availability Zone"
  value       = "${aws_subnet.main.availability_zone}"
}
