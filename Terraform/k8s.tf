resource "aws_instance" "k8s-instance" {
  count         = var.k8s_count
  ami           = lookup(var.ami_k8s,var.aws_k8s_region)
  instance_type = var.k8s_type
  key_name      = var.keyname
#user_data     = file("install_docker.sh")
#vpc_security_group_ids = [aws_security_group.sg_allow_ssh_jenkins.id]
#subnet_id          = aws_subnet.public-subnet-1.id
  associate_public_ip_address = true

  tags = {
    Name  = element(var.instance_tags, count.index)
    Batch = "kubernetes"
  }
}

variable "ami_k8s" {
  type = map

  default = {
    "ap-south-1" = "ami-011c99152163a87ae"
  }
}

variable "k8s_count" {
  default = "3"
}

variable "instance_tags" {
  type = list
  default = ["kmaster", "kworker1","kworker2"]
}

variable "k8s_type" {
  default = "t3a.medium"
}

variable "aws_k8s_region" {
  default = "ap-south-1"
}
