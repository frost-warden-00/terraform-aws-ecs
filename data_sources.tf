data "template_file" "task_definition" {
  template = fileexists("templates/task_definition/${var.file_name_task_definition}") ? file("templates/task_definition/${var.file_name_task_definition}") : file("${path.module}/templates/task_definition/task_definition.json")

  vars = merge(
    var.custom_variables,
    {
      image_url        = var.ecr_repository_url
      container_name   = var.container_name
      execution_role   = aws_iam_role.ecs_task_execution_role.arn
      log_group_name   = aws_cloudwatch_log_group.container_log_group.name
      log_group_region = var.region
      log_group_prefix = "${var.container_name}-log"
    },
  )
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

data "aws_vpc" "targetVpc" {
  filter {
    name   = "tag-value"
    values = ["${var.vpc_name}"]
  }
  filter {
    name   = "tag-key"
    values = ["Name"]
  }
}

data "aws_subnets" "this" {
  filter {
    name   = "tag:Tier"
    values = ["Private"]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.targetVpc.id]
  }
}

data "aws_subnet" "subnet" {
  for_each = toset(data.aws_subnets.this.ids)
  id       = each.value
}

data "aws_ecs_task_definition" "latest" {
  task_definition = "${var.container_name}-td"
}

data "aws_service_discovery_dns_namespace" "dns" {
  name = var.namespace_name
  type = "DNS_PRIVATE"
}