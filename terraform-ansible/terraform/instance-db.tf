resource "aws_key_pair" "pockey" {
  key_name   = "terraform-pockey"
  public_key = file(var.ssh_key)
}

resource "aws_db_instance" "master" {
  allocated_storage       = 10
  availability_zone       = data.aws_availability_zones.azs.names[0]
  backup_retention_period = 1
  db_subnet_group_name    = aws_db_subnet_group.subnet-group.id
  engine                  = "postgres"
  engine_version          = "9.6.9"
  identifier              = "master-database"
  instance_class          = "db.t3.micro"
  name                    = "databasepg"
  username                = "nicole"
  password                = "nicole123"
  port                    = 5432
  publicly_accessible     = false
  storage_encrypted       = true
  storage_type            = "gp2"
  apply_immediately       = true
  skip_final_snapshot     = true
  vpc_security_group_ids  = [aws_security_group.db.id]
}


resource "aws_db_instance" "slave" {
  identifier              = "slave-database"
  availability_zone       = data.aws_availability_zones.azs.names[1]
  count                   = 1
  instance_class          = "db.t3.micro"
  publicly_accessible     = false
  replicate_source_db     = aws_db_instance.master.id
  vpc_security_group_ids  = [aws_security_group.db.id]
  backup_retention_period = 0
  skip_final_snapshot     = true
  storage_encrypted       = true
}
