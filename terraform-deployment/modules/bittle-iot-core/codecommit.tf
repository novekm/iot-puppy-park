# # Optional - Only necessary if you want a full Amplify App running in AWS (not just localhost)

# resource "aws_codecommit_repository" "bc_codecommit_repo" {
#   count           = var.bc_create_codecommit_repo ? 1 : 0
#   repository_name = var.bc_codecommit_repo_name
#   description     = var.bc_codecommit_repo_description
#   default_branch  = var.bc_codecommit_repo_default_branch

#   tags = merge(
#     {
#       "AppName" = var.bc_app_name
#     },
#     var.tags,
#   )
# }
