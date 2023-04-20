# AWS ECS

## Getting started

Example

````
module "example-ecs" {
  #env                 = var.env
  project = local.project_name
  prefix                    = local.prefix
  cluster_name              = var.codecommit_repository_name
  vpc_name = "pipeline-main-vpc"
  public_container          = false
  region                    = var.region
  file_name_task_definition = "mysql.json"
  ecr_repository_url        = "123456789.dkr.ecr.us-east-1.amazonaws.com/mysql-cloud:48fa356"
  default_capacity_provider = "FARGATE_SPOT"
  container_name            = "mysql-cloud-example"
  container_cpu             = 256
  container_memory          = 512
  namespace_name = "wp.local"
  namespace_service_name = "MySql"

  custom_variables = {
    cpu_units      = 256
    memory_units   = 512
    container_port = 3306
    hostPort       = 3306
    protocol       = "tcp"

  }
}
````

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.63.0 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_appautoscaling_policy.down](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_policy.up](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target.ecs_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_cloudwatch_log_group.container_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_metric_alarm.service_cpu_high](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.service_cpu_low](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_ecs_service.service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.task_definition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_policy.ecs_task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.ecs_task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ecs_task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group.container-security-group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_service_discovery_service.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/service_discovery_service) | resource |
| [aws_ecs_task_definition.latest](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecs_task_definition) | data source |
| [aws_iam_policy_document.ecs-task-execution-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_service_discovery_dns_namespace.dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/service_discovery_dns_namespace) | data source |
| [aws_subnet.subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnets.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.targetVpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [template_file.task_definition](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarm_cpu_high_evaluation_periods"></a> [alarm\_cpu\_high\_evaluation\_periods](#input\_alarm\_cpu\_high\_evaluation\_periods) | CPU high evaluation period | `number` | `1` | no |
| <a name="input_alarm_cpu_high_period"></a> [alarm\_cpu\_high\_period](#input\_alarm\_cpu\_high\_period) | CPU high period | `number` | `60` | no |
| <a name="input_alarm_cpu_high_statistic"></a> [alarm\_cpu\_high\_statistic](#input\_alarm\_cpu\_high\_statistic) | CPU high statistic | `string` | `"Maximum"` | no |
| <a name="input_alarm_cpu_high_threshold"></a> [alarm\_cpu\_high\_threshold](#input\_alarm\_cpu\_high\_threshold) | CPU high threshold | `number` | `60` | no |
| <a name="input_alarm_cpu_low_evaluation_periods"></a> [alarm\_cpu\_low\_evaluation\_periods](#input\_alarm\_cpu\_low\_evaluation\_periods) | CPU low evaluation periods | `number` | `1` | no |
| <a name="input_alarm_cpu_low_period"></a> [alarm\_cpu\_low\_period](#input\_alarm\_cpu\_low\_period) | CPU low period | `number` | `60` | no |
| <a name="input_alarm_cpu_low_statistic"></a> [alarm\_cpu\_low\_statistic](#input\_alarm\_cpu\_low\_statistic) | CPU low statistic | `string` | `"Average"` | no |
| <a name="input_alarm_cpu_low_threshold"></a> [alarm\_cpu\_low\_threshold](#input\_alarm\_cpu\_low\_threshold) | Alarm CPU low threshold | `number` | `30` | no |
| <a name="input_alarm_metric_name"></a> [alarm\_metric\_name](#input\_alarm\_metric\_name) | Alarm Metric name | `string` | `"CPUUtilization"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the cluster ECS | `string` | n/a | yes |
| <a name="input_container_cpu"></a> [container\_cpu](#input\_container\_cpu) | CPU units for the container | `number` | `256` | no |
| <a name="input_container_memory"></a> [container\_memory](#input\_container\_memory) | Memory for the container | `number` | `512` | no |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | Name of the container. | `string` | n/a | yes |
| <a name="input_custom_variables"></a> [custom\_variables](#input\_custom\_variables) | Custom variables to set on the template file | `map(string)` | `{}` | no |
| <a name="input_default_capacity_provider"></a> [default\_capacity\_provider](#input\_default\_capacity\_provider) | Default Capacity Provider to use | `string` | `"FARGATE"` | no |
| <a name="input_ecr_repository_url"></a> [ecr\_repository\_url](#input\_ecr\_repository\_url) | URL of ECR repository | `string` | n/a | yes |
| <a name="input_file_name_task_definition"></a> [file\_name\_task\_definition](#input\_file\_name\_task\_definition) | Name of the file with the task definition | `string` | n/a | yes |
| <a name="input_namespace_name"></a> [namespace\_name](#input\_namespace\_name) | Namespace name | `string` | n/a | yes |
| <a name="input_namespace_service_name"></a> [namespace\_service\_name](#input\_namespace\_service\_name) | Namespace service name | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix for resources | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Name of the project | `string` | `"pipeline"` | no |
| <a name="input_public_container"></a> [public\_container](#input\_public\_container) | Container will be public? | `bool` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region where to deploy this infrastructure. | `string` | `"us-east-1"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name of the VPC | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
