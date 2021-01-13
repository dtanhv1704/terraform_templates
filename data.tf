# Get AMI ID for instances
data "aws_ami" "amazon" {
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  
  owners = ["amazon"]
  # owners = ["099720109477"] # Canonical
}