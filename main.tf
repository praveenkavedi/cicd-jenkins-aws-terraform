provider "aws" {

  region = "us-east-1"
  access_key = "AKIA46S6PAL3IFGP2YLA"
  secret_key = "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"
}

resource "aws_vpc" "CICDvpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "main"
  }
}
resource "aws_subnet" "TerraformCICD_Subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.CICDvpc.id
  availability_zone = "us-east-1a"
  tags = {
    Name = "TerraformCICD_Subnet"
  }
}
resource "aws_instance" "Terraform_CICD_Instance" {
  ami           = "ami-0323c3dd2da7fb37d"
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    aws_vpc.CICDvpc.default_security_group_id]
  subnet_id = aws_subnet.TerraformCICD_Subnet.id
  availability_zone = "us-east-1a"
  key_name = "MyKey"
  tags = {
    Name = "Terraform_CICD"
  }
}

