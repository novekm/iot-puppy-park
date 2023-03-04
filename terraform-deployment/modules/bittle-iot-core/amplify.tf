# Relevant values:
# - AWS Region
# - Cognito User Pool ID
# - Cognito Web Client ID
# - Cognito Identity Pool ID
# - AppSync GraphQL Region
# - AppSync GraphQL Endpoint ID
# - AppSync GraphQL Authentication Type ('AMAZON_COGNITO_USER_POOLS')
# - Relevant S3 Buckets

resource "aws_amplify_app" "bc_app" {
  count                       = var.create_amplify_app ? 1 : 0
  name                        = var.bc_app_name
  repository                  = var.bc_create_codecommit_repo ? aws_codecommit_repository.bc_codecommit_repo[0].clone_url_http : var.bc_existing_repo_url
  enable_branch_auto_build    = true
  enable_auto_branch_creation = true
  auto_branch_creation_config {
    enable_auto_build           = true
    enable_pull_request_preview = var.bc_enable_amplify_app_pr_preview
  }

  # OPTIONAL - Necessary if not using oauth_token or access_token (used for GitLab and GitHub repos)
  iam_service_role_arn = var.bc_create_codecommit_repo ? aws_iam_role.bc_amplify_codecommit[0].arn : null
  access_token         = var.lookup_ssm_github_access_token ? data.aws_ssm_parameter.ssm_github_access_token[0].value : var.github_access_token // optional, only needed if using github repo

  build_spec = file("${path.root}/../amplify.yml")
  # Redirects for Single Page Web Apps (SPA)
  # https://docs.aws.amazon.com/amplify/latest/userguide/redirects.html#redirects-for-single-page-web-apps-spa
  custom_rule {
    source = "</^[^.]+$|\\.(?!(css|gif|ico|jpg|js|png|txt|svg|woff|ttf|map|json)$)([^.]+$)/>"
    status = "200"
    target = "/index.html"
  }

  environment_variables = {
    bc_REGION             = "${data.aws_region.current.id}"
    bc_CODECOMMIT_REPO_ID = "${var.bc_create_codecommit_repo ? aws_codecommit_repository.bc_codecommit_repo[0].repository_id : null}" //return null if no cc repo is created
    bc_USER_POOL_ID       = "${aws_cognito_user_pool.bc_user_pool.id}"
    bc_IDENTITY_POOL_ID   = "${aws_cognito_identity_pool.bc_identity_pool.id}"
    bc_APP_CLIENT_ID      = "${aws_cognito_user_pool_client.bc_user_pool_client.id}"
    bc_GRAPHQL_ENDPOINT   = "${aws_appsync_graphql_api.bc_appsync_graphql_api.uris.GRAPHQL}"
    bc_GRAPHQL_API_ID     = "${aws_appsync_graphql_api.bc_appsync_graphql_api.id}"
    # bc_LANDING_BUCKET_NAME = "${aws_s3_bucket.bc_landing_bucket.id}"
  }
}


resource "aws_amplify_branch" "bc_amplify_branch_main" {
  count       = var.create_bc_amplify_branch_main ? 1 : 0
  app_id      = aws_amplify_app.bc_app[0].id
  branch_name = var.bc_amplify_branch_main_name

  framework = var.bc_amplify_app_framework
  stage     = var.bc_amplify_branch_main_stage

  environment_variables = {
    Env = "prod"
  }
}

resource "aws_amplify_branch" "bc_amplify_branch_dev" {
  count       = var.create_bc_amplify_branch_dev ? 1 : 0
  app_id      = aws_amplify_app.bc_app[0].id
  branch_name = var.bc_amplify_branch_dev_name

  framework = var.bc_amplify_app_framework
  stage     = var.bc_amplify_branch_dev_stage

  environment_variables = {
    ENV = "dev"
  }
}


resource "aws_amplify_domain_association" "example" {
  count       = var.create_bc_amplify_domain_association ? 1 : 0
  app_id      = aws_amplify_app.bc_app[0].id
  domain_name = var.bc_amplify_app_domain_name

  # https://example.com
  sub_domain {
    branch_name = aws_amplify_branch.bc_amplify_branch_main[0].branch_name
    prefix      = ""
  }

  # https://www.example.com
  sub_domain {
    branch_name = aws_amplify_branch.bc_amplify_branch_main[0].branch_name
    prefix      = "www"
  }
  # https://dev.example.com
  sub_domain {
    branch_name = aws_amplify_branch.bc_amplify_branch_dev[0].branch_name
    prefix      = "dev"
  }
  # https://www.dev.example.com
  sub_domain {
    branch_name = aws_amplify_branch.bc_amplify_branch_dev[0].branch_name
    prefix      = "www.dev"
  }
}
