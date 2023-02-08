# AWS Current Region
output "aws_current_region" {
  value = "AWS Region: ${module.bittle-iot-core.aws_current_region.name}"
}

# S3
output "bc_input_bucket" {
  value       = module.bittle-iot-core.bc_input_bucket_id.id
  description = "The name of the S3 input bucket"
}
output "bc_output_bucket" {
  value       = module.bittle-iot-core.bc_output_bucket_id.id
  description = "The name of the S3 output bucket"
}
output "bc_app_storage_bucket" {
  value       = module.bittle-iot-core.bc_app_storage_bucket_id.id
  description = "The name of the S3 app storage bucket"
}



# Amplify

# Step Function

# IAM

# DynamoDB

# Cognito
output "bc_user_pool_region" {
  value = module.bittle-iot-core.bc_user_pool_region.name
}
output "bc_user_pool_id" {
  value = module.bittle-iot-core.bc_user_pool_id.id
}
output "bc_user_pool_client" {
  value = module.bittle-iot-core.bc_user_pool_client_id.id
}
output "bc_identity_pool" {
  value = module.bittle-iot-core.bc_identity_pool_id.id
}

# AppSync (GraphQL)
output "bc_appsync_graphql_api_region" {
  value = module.bittle-iot-core.bc_appsync_graphql_api_region.name
}
output "bc_appsync_graphql_api_id" {
  value = module.bittle-iot-core.bc_appsync_graphql_api_id.id
}
output "bc_appsync_graphql_api_uris" {
  value = module.bittle-iot-core.bc_appsync_graphql_api_uris.uris
}

