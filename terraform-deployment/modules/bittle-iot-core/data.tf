data "aws_region" "current" {}

data "aws_caller_identity" "current" {}
# .account_id
# .arn
# .user_id

data "aws_iot_endpoint" "current" {
  endpoint_type = "iot:Data-ATS"
}
