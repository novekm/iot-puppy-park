# # # SNS
# # variable "bc_enable_sns" {
# #   type        = bool
# #   default     = true
# #   description = "Conditional creation of SNS resources"

# # }
# # variable "bc_sns_email_endpoint" {
# #   type        = string
# #   default     = null
# #   description = "The Admin email address to be used for SNS subscription. Required if bc_enable_sns is set to 'true'"

# # }

# SSM
variable "lookup_ssm_github_access_token" {
  type        = bool
  default     = false
  description = <<-EOF
  *IMPORTANT!*
  Conditional data fetch of SSM parameter store for GitHub access token.
  To ensure security of this token, you must manually add it via the AWS console
  before using.
  EOF

}
variable "ssm_github_access_token_name" {
  type        = string
  default     = null
  description = "The name (key) of the SSM parameter store of your GitHub access token"

}

# - S3 -
variable "bc_landing_bucket_name" {
  type        = string
  default     = "bc-landing-bucket"
  description = "Name of the S3 bucket for audio file upload. Max 27 characters"
}
variable "bc_input_bucket_name" {
  type        = string
  default     = "bc-input-bucket"
  description = "Name of the S3 bucket for transcribe job source. Max 27 characters"
}
variable "bc_devices_bucket_name" {
  type        = string
  default     = "bc-output-bucket"
  description = "Output bucket for completed transcriptions. Max 27 characters"
}
variable "bc_app_storage_bucket_name" {
  type        = string
  default     = "bc-app-storage-bucket"
  description = "Bucket used for Amplify app storage. Max 27 characters"
}

variable "s3_enable_force_destroy" {
  type    = string
  default = "true"

}
variable "bc_s3_enable_bucket_policy" {
  type        = bool
  default     = true
  description = "Conditional creation of S3 bucket policies"

}
variable "bc_s3_block_public_access" {
  type        = bool
  default     = true
  description = "Conditional enabling of the block public access S3 feature"

}
variable "bc_s3_block_public_acls" {
  type        = bool
  default     = true
  description = "Conditional enabling of the block public ACLs S3 feature"

}
variable "bc_s3_block_public_policy" {
  type        = bool
  default     = true
  description = "Conditional enabling of the block public policy S3 feature"

}
variable "bc_landing_bucket_enable_cors" {
  type        = bool
  default     = true
  description = "Contiditional enabling of CORS"

}
variable "bc_landing_bucket_create_nuke_everything_lifecycle_config" {
  type        = bool
  default     = true
  description = "Conditional create of the lifecycle config to remove all objects from the bucket"
}
variable "bc_landing_bucket_days_until_objects_expiration" {
  type        = number
  default     = 1
  description = "The number of days until objects in the bucket are deleted"
}

variable "bc_input_bucket_enable_cors" {
  type        = bool
  default     = true
  description = "Contiditional enabling of CORS"

}
variable "bc_input_bucket_create_nuke_everything_lifecycle_config" {
  type        = bool
  default     = true
  description = "Conditional create of the lifecycle config to remove all objects from the bucket"
}
variable "bc_input_bucket_days_until_objects_expiration" {
  type        = number
  default     = 1
  description = "The number of days until objects in the bucket are deleted"
}
variable "bc_devices_bucket_enable_cors" {
  type        = bool
  default     = true
  description = "Contiditional enabling of CORS"

}
variable "bc_devices_bucket_create_nuke_everything_lifecycle_config" {
  type        = bool
  default     = true
  description = "Conditional create of the lifecycle config to remove all objects from the bucket"

}
variable "bc_devices_bucket_days_until_objects_expiration" {
  type        = number
  default     = 1
  description = "The number of days until objects in the bucket are deleted"
}

# - Amplify -
variable "create_amplify_app" {
  type        = bool
  default     = false
  description = "Conditional creation of AWS Amplify Web Application"
}
variable "bc_app_name" {
  type        = string
  default     = "bc-App"
  description = "The name of the Amplify Application"
}
variable "bc_enable_auto_branch_creation" {
  type        = bool
  default     = true
  description = "Enables automated branch creation for the Amplify app"

}
variable "bc_enable_auto_branch_deletion" {
  type        = bool
  default     = true
  description = "Automatically disconnects a branch in the Amplify Console when you delete a branch from your Git repository"

}
variable "bc_auto_branch_creation_patterns" {
  type        = list(any)
  default     = ["main", "dev", ]
  description = "Automated branch creation glob patterns for the Amplify app. Ex. feat*/*"

}
variable "bc_enable_auto_build" {
  type        = bool
  default     = true
  description = "Enables auto-building of autocreated branches for the Amplify App."

}
variable "bc_enable_amplify_app_pr_preview" {
  type        = bool
  default     = false
  description = "Enables pull request previews for the autocreated branch"

}
variable "bc_enable_performance_mode" {
  type        = bool
  default     = false
  description = "Enables performance mode for the branch. This keeps cache at Edge Locations for up to 10min after changes"
}
variable "bc_framework" {
  type        = string
  default     = "React"
  description = "Framework for the autocreated branch"

}
variable "bc_existing_repo_url" {
  type        = string
  default     = null
  description = "URL for the existing repo"

}
variable "github_access_token" {
  type        = string
  default     = null
  description = "Optional GitHub access token. Only required if using GitHub repo."

}
variable "bc_amplify_app_framework" {
  type    = string
  default = "React"

}
variable "create_bc_amplify_domain_association" {
  type    = bool
  default = false

}
variable "bc_amplify_app_domain_name" {
  type        = string
  default     = "example.com"
  description = "The name of your domain. Ex. naruto.ninja"

}


# AppSync - GraphQL
variable "bc_appsync_graphql_api_name" {
  type    = string
  default = "bc-graphql-api"

}


# - Step Function -
variable "bc_sfn_state_machine_name" {
  type        = string
  default     = "bc-state-machine"
  description = "Name of the state machine used to orchestrate pipeline"

}

# - IAM -

variable "create_restricted_access_roles" {
  type        = bool
  default     = true
  description = "Conditional creation of restricted access roles"

}


# - DynamoDB -
variable "dynamodb_ttl_enable" {
  type    = bool
  default = false
}
variable "dynamodb_ttl_attribute" {
  type    = string
  default = "TimeToExist"
}
variable "bc_devices_billing_mode" {
  type    = string
  default = "PROVISIONED"
}
variable "bc_devices_read_capacity" {
  type    = number
  default = 20

}
variable "bc_devices_write_capacity" {
  type    = number
  default = 20

}


# - Cognito -
# User Pool
variable "bc_user_pool_name" {
  type        = string
  default     = "bc_user_pool"
  description = "The name of the Cognito User Pool created"
}
variable "bc_user_pool_client_name" {
  type        = string
  default     = "bc_user_pool_client"
  description = "The name of the Cognito User Pool Client created"
}
variable "bc_identity_pool_name" {
  type        = string
  default     = "bc_identity_pool"
  description = "The name of the Cognito Identity Pool created"

}
variable "bc_identity_pool_allow_unauthenticated_identites" {
  type    = bool
  default = false
}
variable "bc_identity_pool_allow_classic_flow" {
  type    = bool
  default = false

}
variable "bc_email_verification_message" {
  type        = string
  default     = <<-EOF

  Thank you for registering with the Bittle Control App. This is your email confirmation.
  Verification Code: {####}

  EOF
  description = "The Cognito email verification message"
}
variable "bc_email_verification_subject" {
  type        = string
  default     = "bc App Verification"
  description = "The Cognito email verification subject"
}
variable "bc_invite_email_message" {
  type    = string
  default = <<-EOF
    You have been invited to the Bittle Control App! Your username is "{username}" and
    temporary password is "{####}". Please reach out to an admin if you have issues signing in.

  EOF

}
variable "bc_invite_email_subject" {
  type    = string
  default = <<-EOF
  Welcome to Bittle Control!
  EOF

}
variable "bc_invite_sms_message" {
  type    = string
  default = <<-EOF
    You have been invited to the Bittle Control App! Your username is "{username}" and
    temporary password is "{####}".

  EOF

}
variable "bc_password_policy_min_length" {
  type        = number
  default     = 8
  description = "The minimum nmber of characters for Cognito user passwords"
}
variable "bc_password_policy_require_lowercase" {
  type        = bool
  default     = true
  description = "Whether or not the Cognito user password must have at least 1 lowercase character"

}
variable "bc_password_policy_require_uppercase" {
  type        = bool
  default     = true
  description = "Whether or not the Cognito user password must have at least 1 uppercase character"

}
variable "bc_password_policy_require_numbers" {
  type        = bool
  default     = true
  description = "Whether or not the Cognito user password must have at least 1 number"

}

variable "bc_password_policy_require_symbols" {
  type        = bool
  default     = true
  description = "Whether or not the Cognito user password must have at least 1 special character"

}

variable "bc_password_policy_temp_password_validity_days" {
  type        = number
  default     = 7
  description = "The number of days a temp password is valid. If user does not sign-in during this time, will need to be reset by an admin"

}
# General Schema
variable "bc_schemas" {
  description = "A container with the schema attributes of a user pool. Maximum of 50 attributes"
  type        = list(any)
  default     = []
}
# Schema (String)
variable "bc_string_schemas" {
  description = "A container with the string schema attributes of a user pool. Maximum of 50 attributes"
  type        = list(any)
  default = [{
    name                     = "email"
    attribute_data_type      = "String"
    required                 = true
    mutable                  = false
    developer_only_attribute = false

    string_attribute_constraints = {
      min_length = 7
      max_length = 25
    }
    },
    {
      name                     = "given_name"
      attribute_data_type      = "String"
      required                 = true
      mutable                  = true
      developer_only_attribute = false

      string_attribute_constraints = {
        min_length = 1
        max_length = 25
      }
    },
    {
      name                     = "family_name"
      attribute_data_type      = "String"
      required                 = true
      mutable                  = true
      developer_only_attribute = false

      string_attribute_constraints = {
        min_length = 1
        max_length = 25
      }
    },
    {
      name                     = "IAC_PROVIDER"
      attribute_data_type      = "String"
      required                 = false
      mutable                  = true
      developer_only_attribute = false

      string_attribute_constraints = {
        min_length = 1
        max_length = 10
      }
    },
  ]
}
# Schema (number)
variable "bc_number_schemas" {
  description = "A container with the number schema attributes of a user pool. Maximum of 50 attributes"
  type        = list(any)
  default     = []
}









# Admin Users
variable "bc_admin_cognito_users" {
  type    = map(any)
  default = {}
}

variable "bc_admin_cognito_user_group_name" {
  type    = string
  default = "Admin"

}
variable "bc_admin_cognito_user_group_description" {
  type    = string
  default = "Admin Group"

}
# Standard Users
variable "bc_standard_cognito_users" {
  type    = map(any)
  default = {}

}
variable "bc_standard_cognito_user_group_name" {
  type    = string
  default = "Standard"

}
variable "bc_standard_cognito_user_group_description" {
  type    = string
  default = "Standard Group"

}

# GitLab Mirroring

variable "bc_enable_gitlab_mirroring" {
  type        = bool
  default     = false
  description = "Enables GitLab mirroring to the option AWS CodeCommit repo."
}
variable "bc_gitlab_mirroring_iam_user_name" {
  type        = string
  default     = "bc_gitlab_mirroring"
  description = "The IAM Username for the GitLab Mirroring IAM User."
}
variable "bc_gitlab_mirroring_policy_name" {
  type        = string
  default     = "bc_gitlab_mirroring_policy"
  description = "The name of the IAM policy attached to the GitLab Mirroring IAM User"
}



# CodeCommit
variable "bc_create_codecommit_repo" {
  type    = bool
  default = false
}
variable "bc_codecommit_repo_name" {
  type    = string
  default = "bc_codecommit_repo"
}
variable "bc_codecommit_repo_description" {
  type    = string
  default = "The CodeCommit repo created in the bc deployment"
}
variable "bc_codecommit_repo_default_branch" {
  type    = string
  default = "main"

}


#  - Step Function -
# State Management
# GenerateUUID
variable "bc_sfn_state_generate_uuid_name" {
  type        = string
  default     = "GenerateUUID"
  description = "Name for SFN State that generates a UUID that is appended to the object key of the file copied from bc_landing to bc_input bucket"

}
# variable "bc_sfn_state_generate_uuid_type" {
#   type        = string
#   default     = "Pass"
#   description = "Pass state type"

# }
variable "bc_sfn_state_generate_uuid_next_step" {
  type    = string
  default = "GetbcInputFile"

}

# GetInputFile
variable "create_bc_sfn_state_get_bc_input_file" {
  type        = bool
  default     = true
  description = "Enables creation of GetbcInputFile sfn state"

}
variable "bc_sfn_state_get_bc_input_file_name" {
  type        = string
  default     = "GetbcInputFile"
  description = "Generates a UUID that is appended to the object key of the file copied from bc_landing to bc_input bucket"

}


# IoT Things
variable "all_bittles" {
  type    = map(any)
  default = {}
}
variable "all_gas_sensors" {
  type    = map(any)
  default = {}
}

# WiFi Information
variable "bc_wifi_ssid_1" {
  type        = string
  default     = ""
  description = "The SSID for the primary local network you want Bittle to connect to."
  sensitive   = true

}
variable "bc_wifi_password_1" {
  type        = string
  default     = ""
  description = "The password for the primary local network you want Bittle to connect to."
  sensitive   = true

}
variable "bc_wifi_ssid_2" {
  type        = string
  default     = ""
  description = "The SSID for the 1st backup local network you want Bittle to connect to."
  sensitive   = true

}
variable "bc_wifi_password_2" {
  type        = string
  default     = ""
  description = "The password for the 1st backup local network you want Bittle to connect to."
  sensitive   = true

}
variable "bc_wifi_ssid_3" {
  type        = string
  default     = ""
  description = "The SSID for the 2nd backup local network you want Bittle to connect to."
  sensitive   = true

}
variable "bc_wifi_password_3" {
  type        = string
  default     = ""
  description = "The password for the 2nd backup local network you want Bittle to connect to."
  sensitive   = true

}
variable "bc_wifi_ssid_4" {
  type        = string
  default     = ""
  description = "The SSID for the 3rd backup local network you want Bittle to connect to."
  sensitive   = true

}
variable "bc_wifi_password_4" {
  type        = string
  default     = ""
  description = "The password for the 3rd backup local network you want Bittle to connect to."
  sensitive   = true

}

# Tagging
variable "tags" {
  type        = map(any)
  description = "Tags to apply to resources"
  default = {
    "IAC_PROVIDER" = "Terraform"
  }
}
