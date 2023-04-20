###############################################################################
####              AWS Security Group                                   ###
###############################################################################
resource "aws_security_group" "container-security-group" {

  name   = "${var.container_name}-sg"
  vpc_id = data.aws_vpc.targetVpc.id

  ##################  ingress section  ##################

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ##################  egress section  ##################

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(tomap({ "Name" = "${var.container_name}-sg", "Type" = "ECS" }))
}