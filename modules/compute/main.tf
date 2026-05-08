# AMI Amazon Linux 2023
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_key_pair" "main" {
  key_name   = "${var.project_name}-${var.environment}-keypair"
  public_key = file(var.public_key_path)

  tags = {
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

resource "aws_instance" "main" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  key_name               = aws_key_pair.main.key_name

  # warning: Not uses instance store — EBS
  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.root_volume_size
    encrypted             = true
    delete_on_termination = true

    tags = {
      Name        = "${var.project_name}-${var.environment}-root-volume"
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }

  # IMDSv2 Enforcement (SSRF Protection)
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"   # IMDSv2
    http_put_response_hop_limit = 1
  }

  monitoring = true   # CloudWatch detailed monitoring

  # user_data = var.user_data_path != "" ? file(var.user_data_path) : null

  lifecycle {
    ignore_changes        = [ami] 
    create_before_destroy = true
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-ec2"
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

# Static Elastic IP
resource "aws_eip" "main" {
  instance = aws_instance.main.id
  domain   = "vpc"

  tags = {
    Name        = "${var.project_name}-${var.environment}-eip"
    Environment = var.environment
    ManagedBy   = "terraform"
  }

  depends_on = [aws_instance.main]
}