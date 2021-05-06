# Get available zone of region
data "aws_availability_zones" "available" {
  state = "available"
}