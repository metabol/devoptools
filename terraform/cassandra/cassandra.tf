#Grab from varible and secret files
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}


#MAIN
resource "aws_instance" "cassandra" {
  ami           = "ami-b374d5a5"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]



   user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  tags {
    Name = "terraform-example"
  }


#  provisioner "remote-exec" { 
#    inline = [
#             "curl http://www.apache.org/dyn/closer.lua/cassandra/3.11.3/apache-cassandra-3.11.3-bin.tar.gz",
#             "tar -xvf apache-cassandra-3.11.3-bin.tar.g",
#               "apache-cassandra-3.11.3/bin/cassandra",
#     ]
#  }
 

}


#Elastic Ip
resource "aws_eip"  "ip" {
  instance = "${aws_instance.cassandra.id}"
}
 



#Security group
resource "aws_security_group" "instance" {
  name = "terraform-cassandra-instance"

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Output
output "ip" {
 value = "${aws_eip.ip.public_ip}"
}


