output "instance_ips" {
    description = "Windoes Active Directory publiuc IP"
  value = ["${aws_instance.win16-srv.*.public_ip}"]
}
output "public_dns" {
  value = "${locat.public_dns}"
}
output "ip" {
    description = "EIP"
  value = "${aws_eip.ip.public_ip}"
}

output "id" {
  value = "${join("",aws_instance.default.*.id)}"
}


