provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_instance" "devops" {
  ami           = "ami-b374d5a5"
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = "echo ${aws_instance.devops.public_ip} > ip_address.txt" 
  }


}

resource "aws_eip"  "ip" {
instance = "${aws_instance.devops.id}"
}
 
output "ip" {

 value = "${aws_eip.ip.public_ip}"

}


