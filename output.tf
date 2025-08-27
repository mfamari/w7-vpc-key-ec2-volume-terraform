output "public-ip" {
 value = aws_instance.web_server.public_ip
  
}

output "vpc-id" {
    value = aws_vpc.my-vpc.id
  
}