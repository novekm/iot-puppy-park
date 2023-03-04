// This is a template file for a basic deployment.
// Modify the parameters below with actual values
module "bittle-iot-core" {
  // location of the module - can be local or git repo
  source = "./modules/bittle-iot-core"

  # - Network information -
  // note - for added security, eventually these could be values stored in parameter store
  // however that would require users to manually enter them before deploying the terraform code.

  # Primary WiFi - REQUIRED
  bc_wifi_ssid_1     = "AWSEnergyDemo1" // enter SSID for the primary local network you want bittle to connect to
  bc_wifi_password_1 = "Wattsup1176*!"  // enter password for the primary local network you want bittle to connect to
  # Backup 1 - Optional
  bc_wifi_ssid_2     = "CERAWeek"    // enter SSID for the local network you want bittle to connect to
  bc_wifi_password_2 = "CW@houston!" // enter password for the local network you want bittle to connect to
  # Backup 2 - Optional
  # bc_wifi_ssid_3     = "CERAWeek"    // enter SSID for the local network you want bittle to connect to
  # bc_wifi_password_3 = "CW@houston!" // enter password for the local network you want bittle to connect to
  # Backup 3 - Optional
  # bc_wifi_ssid_4     = "AzulNuevo"           // enter SSID for the local network you want bittle to connect to
  # bc_wifi_password_4 = "Barbados727xS1176*!" // enter password for the local network you want bittle to connect to

  # - IoT -
  # Dynamic Creation of IoT Things for Bittles

  // Enter an object for each Bittle you would like to connect
  all_bittles = {
    Bittle1 : {
      name            = "Bittle1"
      short_name      = "B1"
      nyboard_version = "v1_2"
    },
    Bittle2 : {
      name            = "Bittle2"
      short_name      = "B2"
      nyboard_version = "v1_2"
    },
    Bittle3 : {
      name            = "Bittle3"
      short_name      = "B3"
      nyboard_version = "v1_1"
    },
    Bittle4 : {
      name            = "Bittle4"
      short_name      = "B4"
      nyboard_version = "v1_1"
    },
    Bittle5 : {
      name            = "Bittle5"
      short_name      = "B5"
      nyboard_version = "v1_1"
    },
    Bittle6 : {
      name            = "Bittle6"
      short_name      = "B6"
      nyboard_version = "v1_1"
    },
  }
  // Enter an object for each gas sensor you would like to connect
  all_gas_sensors = {
    Gas1 : {
      name       = "Gas1"
      short_name = "G1"
    },
    Gas2 : {
      name       = "Gas2"
      short_name = "G2"
    },
  }

  # - Amplify App -
  create_amplify_app         = true
  bc_create_codecommit_repo  = false
  bc_enable_gitlab_mirroring = false
  # Connect Amplify to GitHub
  bc_existing_repo_url             = "https://github.com/novekm/iot-puppy-park"
  lookup_ssm_github_access_token   = true
  ssm_github_access_token_name     = "github-access-token"
  bc_enable_amplify_app_pr_preview = true


  # - Cognito -
  # Admin Users to create
  bc_admin_cognito_users = {
    DefaultAdmin : {
      username       = "admin"
      given_name     = "Default"
      family_name    = "Admin"
      email          = "novekm@amazon.com"
      email_verified = true // no touchy
    },
    NarutoUzumaki : {
      username       = "kmayers"
      given_name     = "Naruto"
      family_name    = "Uzumaki"
      email          = "kevonmayers31@gmail.com"
      email_verified = true // no touchy
    },
    NarutoUzumaki : {
      username       = "kmayers"
      given_name     = "Naruto"
      family_name    = "Uzumaki"
      email          = "kevonmayers31@gmail.com"
      email_verified = true // no touchy
    },
    DemoUser : {
      username       = "demo"
      given_name     = "Demo"
      family_name    = "User"
      email          = "novekm+ippdemo@amazon.com"
      email_verified = true // no touchy
    },
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
