output "public_instance_id" {
  value = aws_instance.pub_inst.id 
}

output "private_instance_id" {
  value = aws_instance.priv_inst.id 
}