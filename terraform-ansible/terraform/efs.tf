resource "aws_efs_file_system" "efs-poc" {
  creation_token   = "efs-poc"
  performance_mode = "generalPurpose"
  encrypted        = "true"
  tags = {
    Name = "terraform-efs-poc"
  }
}

resource "aws_efs_mount_target" "efs-mt-subnet-a" {
  file_system_id  = aws_efs_file_system.efs-poc.id
  subnet_id       = aws_subnet.data-subnet-a.id
  security_groups = [aws_security_group.efs.id]
}

resource "aws_efs_mount_target" "efs-mt-subnet-b" {
  file_system_id  = aws_efs_file_system.efs-poc.id
  subnet_id       = aws_subnet.data-subnet-b.id
  security_groups = [aws_security_group.efs.id]
}
