module "bittle-iot-core" {
  // location of the module - can be local or git repo
  source = "./modules/bittle-iot-core"


  # - IoT -
  # Dynamic Creation of IoT Things for Bittles
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
    # ...n bittles
  }

}
