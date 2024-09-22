resource "aws_instance" "pub_inst" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.public_subnet_id
    vpc_security_group_ids = [var.pub_inst_sg_id]
    

    user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

    tags = {
    Name = "ojmk_pub_inst"
    }
}

resource "aws_instance" "priv_inst" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.private_subnet_id 
    vpc_security_group_ids = [var.priv_inst_sg_id]
    

    user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

    tags = {
    Name = "ojmk_priv_inst"
    }
}