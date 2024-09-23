module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "workstation-eksctl"

  instance_type          = "t2.micro"
 # key_name               = "user1"
 # monitoring             = true
  vpc_security_group_ids = [aws_security_group.allow_eksctl.id]
  subnet_id              = "subnet-03a802e83ae80f0f3"
   ami = data.aws_ami.centos8.id
   user_data = file("workstation.sh")
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_security_group" "allow_eksctl" {
 name        = "allow_eksctl"
 description = "Allow for eksctl"
 vpc_id      = data.aws_vpc.default.id

ingress {
   description = "HTTPS ingress"
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }

egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}