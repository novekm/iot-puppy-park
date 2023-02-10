# AWS Current Region
output "aws_current_region" {
  value = data.aws_region.current

}

# S3
output "bc_input_bucket_id" {
  value       = aws_s3_bucket.bc_input_bucket
  description = "The name of the S3 input bucket"
}
output "bc_input_bucket_arn" {
  value       = aws_s3_bucket.bc_input_bucket
  description = "The Arn of the S3 input bucket"
}
output "bc_devices_bucket_id" {
  value       = aws_s3_bucket.bc_devices_bucket
  description = "The name of the S3 output bucket"
}
output "bc_devices_bucket_arn" {
  value       = aws_s3_bucket.bc_devices_bucket
  description = "The Arn of the S3 input bucket"
}
output "bc_app_storage_bucket_id" {
  value       = aws_s3_bucket.bc_app_storage_bucket
  description = "The name of the S3 app storage bucket"
}
output "bc_app_storage_bucket_arn" {
  value       = aws_s3_bucket.bc_app_storage_bucket
  description = "The ARN of the S3 app storage bucket"
}

# Amplify

# Step Function
output "bc_step_function_arn" {
  value = aws_sfn_state_machine.bc_sfn_state_machine.arn

}

# IAM

# DynamoDB
output "bc_dynamodb_output_table_name" {
  value = aws_dynamodb_table.bc_devices.name
}



# Cognito
output "bc_user_pool_region" {
  value = data.aws_region.current
}
output "bc_user_pool_id" {
  value = aws_cognito_user_pool.bc_user_pool
}
output "bc_user_pool_client_id" {
  value = aws_cognito_user_pool_client.bc_user_pool_client
}
output "bc_identity_pool_id" {
  value = aws_cognito_identity_pool.bc_identity_pool
}


# AppSync (GraphQL)
output "bc_appsync_graphql_api_region" {
  value = data.aws_region.current
}
output "bc_appsync_graphql_api_id" {
  value = aws_appsync_graphql_api.bc_appsync_graphql_api
}
output "bc_appsync_graphql_api_uris" {
  value = aws_appsync_graphql_api.bc_appsync_graphql_api
}
