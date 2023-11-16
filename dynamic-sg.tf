# resource "aws_security_group" "dynamic_sg" {
#     name = "dynamic-sg"
#     description = "dynamic security group"
  
#   dynamic "ingress" {
#     for_each = [8200, 8201, 8300, 9200, 9500]
#     content {
#     from_port   = ingress.value
#     to_port     = ingress.value
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#     }
#   }
# }


resource "aws_security_group" "demo_sg" {
  name        = "sample-sg-provisioner"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "test" {
  ami = "ami-0230bd60aa48260c6"
  instance_type = "t2.micro"
  tags = {
    Name="remote-exec-ec2"
  }
  key_name = "remote-kp"
  vpc_security_group_ids = [aws_security_group.demo_sg.id]

  connection {
    type ="ssh"
    user = "ec2-user"
    private_key = file("./remote-kp.pem")
    host = self.public_ip
  }

provisioner "remote-exec" {
  inline = [
    "sudo touch /home/ec2-user/movies"    
  ]
}
}
