// ec2 instance code

resource "aws_instance" "web_server" {

  ami                    = "ami-045269a1f5c90a6a0"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public1.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = aws_key_pair.key1.key_name
  user_data              = file("setup.sh")
  tags = {
    Name = "Terraform-project-server"
    env  = "dev"
  }
}

# EBS volume

resource "aws_ebs_volume" "ebs" {
 size = 20
 availability_zone = aws_instance.web_server.availability_zone

 tags = {
   Name = "extra volume"
 }
}

resource "aws_volume_attachment" "volume_attach" {

instance_id = aws_instance.web_server.id
volume_id = aws_ebs_volume.ebs.id
device_name = "/dev/sdb"

}