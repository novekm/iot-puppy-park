// This is a template file for a basic deployment.
// Modify the parameters below with actual values
module "bittle-iot-core" {
  // location of the module - can be local or git repo
  source = "./modules/bittle-iot-core"

  # - Network information -
  // note - for added security, eventually these could be values stored in parameter store
  // however that would require users to manually enter them before deploying the terraform code.

  bc_local_ssid             = "" // enter SSID for the local network you want bittle to connect to
  bc_local_network_password = "" // enter password for the local network you want bittle to connect to


  # - IoT -
  # Dynamic Creation of IoT Things for Bittles

  // Enter an object for each Bittle you would like to connect
  all_bittles = {
    Bittle1 : {
      name            = "Bittle1"
      short_name      = "B1"
      nyboard_version = "v1_1"
    },
    Bittle2 : {
      name            = "Bittle2"
      short_name      = "B2"
      nyboard_version = "v1_1"
    },
    Bittle3 : {
      name            = "Bittle3"
      short_name      = "B3"
      nyboard_version = "v1_1"
    },
  }

  # - Amplify App -
  create_amplify_app         = true
  bc_create_codecommit_repo  = false
  bc_enable_gitlab_mirroring = false
  bc_existing_repo_url       = "https://github.com/YOUR-REPO"

  # - SSM -
  lookup_ssm_github_access_token = true                              // find the github access token in ssm
  ssm_github_access_token_name   = "your-ssm-paramater-with-github-" // name of your ssm parameter

  # - Cognito -
  # Admin Users to create
  bc_admin_cognito_users = {
    DefaultAdmin : {
      username       = "admin"
      given_name     = "Default"
      family_name    = "Admin"
      email          = "admin@example.com"
      email_verified = true // no touchy
    },
    NarutoUzumaki : {
      username       = "nuzumaki"
      given_name     = "Naruto"
      family_name    = "Uzumaki"
      email          = "kevonmayers31@gmail.com"
      email_verified = true // no touchy
    }
  }
  # Standard Users to create
  bc_standard_cognito_users = {
    DefaultStandardUser : {
      username       = "default"
      given_name     = "Default"
      family_name    = "User"
      email          = "default@example.com"
      email_verified = true // no touchy
    }
  }

}
