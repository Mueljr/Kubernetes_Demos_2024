provider "aws" {
  region = "us-east-1"  # Change to your preferred region
}

# EC2 Instance Setup
resource "aws_instance" "astroOps_instance" {
  ami                         = "ami-084568db4383264d4"  # Ubuntu AMI (18.04 LTS, update if needed)
  instance_type               = "t2.micro"               # Free-tier eligible
  key_name                    = "projects"               # Replace with your actual key name
  security_groups             = [aws_security_group.sg_minikube.name]
  associate_public_ip_address = true

  tags = {
    Name = "AstroOps-Instance"
  }
}

# Security Group with all required ports
resource "aws_security_group" "sg_minikube" {
  name        = "sg_minikube"
  description = "Allow Kubernetes, monitoring, SSH and HTTP access"

  # SSH (22) - Required to connect via terminal
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP (80) - Optional if serving a web app
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Minikube - Kubernetes API
  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Kubelet
  ingress {
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Kube-proxy
  ingress {
    from_port   = 10251
    to_port     = 10251
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Prometheus
  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Grafana
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress - Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}