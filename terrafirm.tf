provider "aws" {}

resource "aws_key_pair" "auth" {
  key_name   = "${var.key_pair_name}"
  public_key = "${var.public_key}"
}

#resource "template_file" "userdata" {
#  filename = "userdata.ps1"
#}

# Security group to access the instances over WinRM
resource "aws_security_group" "terrafirm" {
  name        = "terrafirm_sg"
  description = "Used in terrafirm"

  # SSH access from anywhere
  ingress {
    from_port   = 5985
    to_port     = 5986
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "windows" {
  ami = "${var.ami}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.auth.id}"
  vpc_security_group_ids = ["${aws_security_group.terrafirm.id}"]
  user_data = "${file("userdata2.ps1")}"
  #user_data = "${template_file.userdata.rendered}"
  
  timeouts {
    create = "40m"
    delete = "40m"
  }
  
  connection {
    #winrm connection to tier-2 instance
    type     = "winrm"
    user     = "${var.term_user}"
    password = "${var.term_passwd}"
    timeout   = "30m"
    #https    = true
  }
  
  provisioner "file" {
    source = "watchmaker_test.ps1"
    destination = "C:\\scripts\\watchmaker_test.ps1"
  }

  provisioner "local-exec" {
    command = "sleep 60"
  }
  
  provisioner "remote-exec" {
    inline = [
      "hostname",
      "powershell.exe -File C:\\scripts\\watchmaker_test.ps1",
    ]
    on_failure = "continue"
  }
  
 provisioner "local-exec" {
    command = "sleep 60"
  }
  
  provisioner "remote-exec" {
    inline = [
      "hostname",
      "powershell.exe -File C:\\scripts\\watchmaker_test.ps1",
    ]
    on_failure = "continue"
  }  

  provisioner "local-exec" {
    command = "sleep 30"
  }
  
  provisioner "remote-exec" {
    inline = [
      "hostname",
      "powershell.exe -File C:\\scripts\\watchmaker_test.ps1",
    ]
  }  
}
