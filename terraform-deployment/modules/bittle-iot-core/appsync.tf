# TODO - Consider replacing 'Scan' DynamoDB operations with 'Query'
# https://docs.aws.amazon.com/appsync/latest/devguide/resolver-mapping-template-reference-dynamodb.html#aws-appsync-resolver-mapping-template-reference-dynamodb-getitem
# https://docs.aws.amazon.com/appsync/latest/devguide/security-authz.html#amazon-cognito-user-pools-authorization
# API Data Source
resource "aws_appsync_datasource" "bc_appsync_dynamodb_datasource" {
  api_id           = aws_appsync_graphql_api.bc_appsync_graphql_api.id
  name             = "bc_output_dynamodb_datasource"
  service_role_arn = aws_iam_role.bc_appsync_dynamodb_restricted_access[0].arn
  type             = "AMAZON_DYNAMODB"

  dynamodb_config {
    table_name = aws_dynamodb_table.bc_devices.name
  }
}
# API
resource "aws_appsync_graphql_api" "bc_appsync_graphql_api" {
  authentication_type = "AMAZON_COGNITO_USER_POOLS"
  name                = var.bc_appsync_graphql_api_name

  user_pool_config {
    aws_region     = data.aws_region.current.name
    default_action = "ALLOW"
    user_pool_id   = aws_cognito_user_pool.bc_user_pool.id
  }


  schema = <<EOF
type Bittle  @aws_auth(cognito_groups: ["Admin", "Standard"])  {
  DeviceId: String!
  Battery: Float
  DeviceStatus: String
  ShortName: String
  NyboardVersion: String
}

type BittlePaginated {
  items: [Bittle]
  nextToken: String
  @aws_auth(cognito_groups: ["Admin", "Standard"])
}


type Query {
  getAllBittles(limit: Int, nextToken: String): BittlePaginated @aws_auth(cognito_groups: ["Admin", "Standard"])
  getAllBittlesPaginated(limit: Int, nextToken: String): BittlePaginated @aws_auth(cognito_groups: ["Admin", "Standard"])
  getOneBittle(DeviceId: String!): Bittle @aws_auth(cognito_groups: ["Admin", "Standard"])
  }

type Mutation {
  deleteOneBittle(DeviceId: String!): Bittle
  @aws_auth(cognito_groups: ["Admin",])
}

schema {
  query: Query
  mutation: Mutation
}
EOF
}


# Resolvers
# UNIT type resolver (default)
# Query - Get One Object
resource "aws_appsync_resolver" "bc_appsync_resolver_query_get_one_bittle" {
  api_id = aws_appsync_graphql_api.bc_appsync_graphql_api.id
  field  = "getOneBittle"
  type   = "Query"
  # data_source = [aws_appsync_datasource.bc_appsync_dynamodb_datasource.name]
  data_source = aws_appsync_datasource.bc_appsync_dynamodb_datasource.name

  request_template = <<EOF
{
    "version" : "2017-02-28",
    "operation" : "GetItem",
    "key" : {
       "DeviceId" : $util.dynamodb.toDynamoDBJson($ctx.args.DeviceId)
    },
    "consistentRead" : false
}
EOF

  response_template = <<EOF
    $util.toJson($ctx.result)
EOF
}
# Scan - Get All Objects (Limit of 1,000,000)
resource "aws_appsync_resolver" "bc_appsync_resolver_query_get_all_bittles" {
  api_id      = aws_appsync_graphql_api.bc_appsync_graphql_api.id
  field       = "getAllBittles"
  type        = "Query"
  data_source = aws_appsync_datasource.bc_appsync_dynamodb_datasource.name

  request_template = <<EOF

{
    "version" : "2017-02-28",
    "operation" : "Scan",
    "limit" : 1000000,
    "consistentRead" : false,
    "nextToken" : $util.toJson($util.defaultIfNullOrEmpty($ctx.args.nextToken, null)),
}
EOF

  response_template = <<EOF
   $util.toJson($ctx.result)
EOF
}
# Scan - Get All Objects Paginated
resource "aws_appsync_resolver" "bc_appsync_resolver_query_get_all_bittles_paginated" {
  api_id      = aws_appsync_graphql_api.bc_appsync_graphql_api.id
  field       = "getAllBittlesPaginated"
  type        = "Query"
  data_source = aws_appsync_datasource.bc_appsync_dynamodb_datasource.name

  request_template = <<EOF

{
    "version" : "2017-02-28",
    "operation" : "Scan",
    "limit" : 20,
    "consistentRead" : false,
    "nextToken" : $util.toJson($util.defaultIfNullOrEmpty($ctx.args.nextToken, null)),
}
EOF

  response_template = <<EOF
   $util.toJson($ctx.result)
EOF
}


# Mutation - Delete One Object
resource "aws_appsync_resolver" "bc_appsync_resolver_mutation_delete_one_bittle" {
  api_id      = aws_appsync_graphql_api.bc_appsync_graphql_api.id
  field       = "deleteOneBittle"
  type        = "Mutation"
  data_source = aws_appsync_datasource.bc_appsync_dynamodb_datasource.name

  request_template = <<EOF
{
    "version" : "2017-02-28",
    "operation" : "DeleteItem",
    "key" : {
        "DeviceId" : $util.dynamodb.toDynamoDBJson($ctx.args.DeviceId)
    }
}
EOF

  response_template = <<EOF
   $util.toJson($ctx.result)
EOF
}















