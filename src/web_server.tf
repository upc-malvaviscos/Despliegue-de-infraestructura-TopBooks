data "aws_ami" "amazon_linux_2" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "web_server" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t3.micro"

  subnet_id = aws_subnet.public_subnet.id

  vpc_security_group_ids = [
    aws_security_group.web_sg.id
  ]

  user_data = <<-EOF
    #!/bin/bash
    if command -v dnf >/dev/null 2>&1; then
      dnf install -y nginx
    else
      amazon-linux-extras install nginx1 -y
    fi
    systemctl enable --now nginx
    mkdir -p /var/www/html
    echo "TopBooks - $(hostname)" > /usr/share/nginx/html/index.html
    EOF

  tags = merge(local.common_tags, {
    Name = "topbooks-web-server"
  })
}
