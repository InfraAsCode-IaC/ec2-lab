output "instance_id" { value = module.compute.instance_id }
output "public_ip" { value = module.compute.public_ip }
output "private_ip" { value = module.compute.private_ip }
output "ssh_command" {
  value = "ssh -i ~/.ssh/terraform-ec2-dev ec2-user@${module.compute.public_ip}"
}
output "web_url" {
  value = "http://${module.compute.public_ip}"
}