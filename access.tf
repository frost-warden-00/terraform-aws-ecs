###############################################################################
####                           Data Policy                                  ###
###############################################################################

data "aws_iam_policy_document" "ecs-task-execution-role" {
  statement {
    sid = "taskrole"

    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = [
      "*",
    ]
  }

  statement {
    sid = "Secrets"

    actions = [
      "ssm:GetParameters",
      "secretsmanager:GetSecretValue",
      "kms:Decrypt"
    ]

    resources = [
      "*",
    ]
  }
}

###############################################################################
####              IAM Policy                                   ###
###############################################################################

resource "aws_iam_policy" "ecs_task_execution_role" {
  name   = "${var.project}ecs-task-execution"
  path   = "/"
  policy = data.aws_iam_policy_document.ecs-task-execution-role.json
}

###############################################################################
####              IAM policy attachment                                   ###
###############################################################################

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecs_task_execution_role.arn
}

###############################################################################
####              IAM roles                                    ###
###############################################################################

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${aws_iam_policy.ecs_task_execution_role.name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
  tags = merge(tomap({ "Name" = "${aws_iam_policy.ecs_task_execution_role.name}-role" }))
}
