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

}
