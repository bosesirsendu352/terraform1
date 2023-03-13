provider "aws" {
  region = "us-east-1" # Change to the appropriate region for your needs
}

resource "aws_db_instance" "example" {
  identifier             = "example-db"
  engine                 = "mysql"
  instance_class         = "db.t2.micro"
  allocated_storage      = 20
  storage_type           = "gp2"
  username               = "sysadmin"
  password               = "Password"
  db_name                = "example_db"
  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.example.id]

  tags = {
    Name = "Example RDS"
  }
}

resource "aws_security_group" "example" {
  name_prefix = "example-db-"
}

resource "aws_security_group_rule" "example_ingress" {
  type        = "ingress"
  from_port   = 3306
  to_port     = 3306
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.example.id
}
