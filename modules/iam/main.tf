resource "aws_cloudwatch_log_group" "cw_log_group" {
  name = "${var.environment_name}_logs"

  tags = {
    Environment = var.environment_name
    Application = var.app_name
  }
}

resource "aws_flow_log" "vpc_flow_log" {
  iam_role_arn    = aws_iam_role.log_watcher.arn
  log_destination = aws_cloudwatch_log_group.cw_log_group.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.app_vpc.id
}

resource "aws_iam_role" "log_watcher" {
  name = var.log_role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "log_watcher_policy" {
  name = var.log_watcher_policy_name
  role = aws_iam_role.log_watcher.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:GetLogEvents", 
        "logs:FilterLogEvents"
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams", 
        "cloudwatch:PutMetricData"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
} 

resource "aws_iam_role" "canary_role" {
  name = var.canary_role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}


resource "aws_iam_role_policy" "canary_role_policy" {
  name = var.canary_role_policy_name
  role = aws_iam_role.canary_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:GetLogEvents", 
        "logs:FilterLogEvents"
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams", 
        "cloudwatch:PutMetricData"
        "Condition": {
                "StringEquals": {
                    "cloudwatch:namespace": "CloudWatchSynthetics"
                }
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}


resource "aws_synthetics_canary" "some" {
  name                 = "some-canary"
  artifact_s3_location = "s3://some-bucket/"
  execution_role_arn   = "some-role"
  handler              =  var.canary_handler
  zip_file             = "test-fixtures/lambdatest.zip"
  runtime_version      =  var.canary_runtime

  schedule {
    expression = "rate(${var.rate})"
  }
}