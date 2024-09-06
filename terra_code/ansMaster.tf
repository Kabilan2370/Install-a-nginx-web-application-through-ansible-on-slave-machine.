provider "aws" {
  region = "us-east-1"
}

# ec2 master for ansible
resource "aws_instance" "master" {
  ami                         = "ami-0e86e20dae9224db8"
  instance_type               = "t2.micro"
  #vpc_id                     = ["vpc-08ca195199a502e91"]
  subnet_id                   = "subnet-0cd017b940fa1f7e8"
  key_name                    = "beankey"
  associate_public_ip_address = "true"
  security_groups             = ["sg-04247582f52776c81","sg-0e133b35a09b1db4f"]
  tags = {
    name = "Master"
}
  user_data = <<EOF

#!/bin/bash

apt update
apt install python3-pip -y
apt update
apt install ansible-core -y
apt update
wget https://gist.githubusercontent.com/alivx/2a4ca3e577ead4bd38d247c258e6513b/raw/fe2b9b1c7abc2b52cc6998525718c9a40c7e02a5/ansible.cfg
touch slaves.txt
EOF

}

# ec2 master for ansible
resource "aws_instance" "slaves" {

  ami                         = "ami-0e86e20dae9224db8"
  instance_type               = "t2.micro"
  #vpc_id                     = ["vpc-08ca195199a502e91"]
  subnet_id                   = "subnet-0ce01f4f6ce8d0b9f"
  key_name                    = "beankey"
  associate_public_ip_address = "true"
  security_groups             = ["sg-04247582f52776c81","sg-0e133b35a09b1db4f"]

  tags = {
    name = "Slave-1"
}
  user_data = <<EOF
#!/bin/bash

apt update
apt install python3-pip -y
apt update
EOF

}