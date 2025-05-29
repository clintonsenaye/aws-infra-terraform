output "web_sg_id" {
  value = aws_security_group.web_sg.id
}

output "s3_bucket_name" {
  value = aws_s3_bucket.app_bucket.bucket
}

output "key_name" {
  value = aws_key_pair.generated_key.key_name
}

output "web_server_public_ip" {
  value = aws_instance.web_server.public_ip
}
