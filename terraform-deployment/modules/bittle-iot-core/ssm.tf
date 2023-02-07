# # Data source
# data "aws_ssm_parameter" "ssm_github_access_token" {
#   count = var.lookup_ssm_github_access_token ? 1 : 0
#   name  = var.ssm_github_access_token_name
# }


# # S3 Transcribe Input Bucket SSM Value to be used by Lambda as Environment Variable
# resource "aws_ssm_parameter" "bc_input_bucket_name" {
#   name  = "bc_input_bucket_name" // This is the 'unique key'
#   type  = "String"
#   value = aws_s3_bucket.bc_input_bucket.id // App storage S3 bucket

#   tags = merge(
#     {
#       "AppName" = var.bc_app_name
#     },
#     var.tags,
#   )
# }

# # S3 Transcribe Output Bucket SSM Value to be used by Lambda as Environment Variable
# resource "aws_ssm_parameter" "bc_output_bucket_name" {
#   name  = "bc_output_bucket_name" // This is the 'unique key'
#   type  = "String"
#   value = aws_s3_bucket.bc_output_bucket.id // App storage S3 bucket

#   tags = merge(
#     {
#       "AppName" = var.bc_app_name
#     },
#     var.tags,
#   )
# }

# # S3 App Storage Bucket SSM Value to be used by Lambda as Environment Variable
# resource "aws_ssm_parameter" "bc_app_storage_bucket_name" {
#   name  = "bc_app_storage_bucket_name" // This is the 'unique key'
#   type  = "String"
#   value = aws_s3_bucket.bc_app_storage_bucket.id // App storage S3 bucket

#   tags = merge(
#     {
#       "AppName" = var.bc_app_name
#     },
#     var.tags,
#   )
# }

# # DynamoDB SSM Value to be used by Lambda as Environment Variables
# resource "aws_ssm_parameter" "bc_dynamodb_output_table_name" {
#   name  = "bc_dynamodb_output_table_name" // This is the 'unique key'
#   type  = "String"
#   value = aws_dynamodb_table.bc_output.id // Name of the DynamoDB table

#   tags = merge(
#     {
#       "AppName" = var.bc_app_name
#     },
#     var.tags,
#   )
# }
