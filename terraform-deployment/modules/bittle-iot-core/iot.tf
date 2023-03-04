// Takes a long time when destroying. On AWS side, ThingType is marked as 'deprecated'
// and cane take some time to be deleted after (around 4-5min)
// Create IoT Thing Type for all Bittles
# resource "aws_iot_thing_type" "petoi_bittle" {
#   name = "Petoi_Bittle"
#   properties {
#     description = "The world's First Palm-sized, Servo-activated Quadruped Robot Dog. https://www.petoi.com/pages/bittle-open-source-bionic-robot-dog"

#   }

#   tags = merge(
#     # {
#     #   "AppName" = var.bc_app_name
#     # },
#     var.tags,
#   )

# }

// Create IoT Thing for each Bittle user defines
resource "aws_iot_thing" "all_bittles" {
  for_each = var.all_bittles == null ? {} : var.all_bittles
  name     = each.value.name
  # thing_type_name = aws_iot_thing_type.petoi_bittle.name

  attributes = {
    short_name      = each.value.short_name
    nyboard_version = each.value.nyboard_version
  }
}
// Create IoT Thing for each Gas sensor user defines
resource "aws_iot_thing" "all_gas_sensors" {
  for_each = var.all_gas_sensors == null ? {} : var.all_gas_sensors
  name     = each.value.name
  # thing_type_name = aws_iot_thing_type.petoi_bittle.name

  attributes = {
    short_name = each.value.short_name
  }
}

// Create IoT Thing Group for all Bittles
resource "aws_iot_thing_group" "bittle_fleet" {
  name = "Bittle_Fleet"
  properties {
    description = "Group containing all Petoi Bittles."
  }
}
// Create IoT Thing Group for all gas sensors
resource "aws_iot_thing_group" "all_gas_sensors" {
  name = "All_Gas_Sensors"
  properties {
    description = "Group containing all Gas Sensors."
  }
}

// Assign Bittles to IoT Thing Group
resource "aws_iot_thing_group_membership" "bittle_fleet" {
  for_each         = var.all_bittles == null ? {} : var.all_bittles
  thing_name       = each.value.name
  thing_group_name = aws_iot_thing_group.bittle_fleet.name

  override_dynamic_group = true

  depends_on = [
    aws_iot_thing.all_bittles
  ]
}
// Assign Gas Sensors to IoT Thing Group
resource "aws_iot_thing_group_membership" "gas_sensors" {
  for_each         = var.all_gas_sensors == null ? {} : var.all_gas_sensors
  thing_name       = each.value.name
  thing_group_name = aws_iot_thing_group.all_gas_sensors.name

  override_dynamic_group = true

  depends_on = [
    aws_iot_thing.all_gas_sensors
  ]
}

// Create IoT Certificate Dynamically for each bittle
resource "aws_iot_certificate" "cert_bittles" {
  for_each = var.all_bittles == null ? {} : var.all_bittles
  active   = true
}
// Create IoT Certificate Dynamically for each gas sensor
resource "aws_iot_certificate" "cert_gas_sensors" {
  for_each = var.all_gas_sensors == null ? {} : var.all_gas_sensors
  active   = true
}

// Create IoT Policy - Bittles
resource "aws_iot_policy" "pubsub_bittles" {
  name = "BittlePubSubToAnyTopic"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "iot:Connect",
          "iot:Publish",
          "iot:Subscribe",
          "iot:Receive",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
// Create IoT Policy - Gas Sensors
resource "aws_iot_policy" "pubsub_gas_sensors" {
  name = "GasSensorPubSubToAnyTopic"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "iot:Connect",
          "iot:Publish",
          "iot:Subscribe",
          "iot:Receive",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
// Policies have targets - these can include certificates, identities, and
// thing groups. Device certificates are installed on each ESP8266 via the
// .ino sketch. This allows the devices to use the policy and have permissions
// for what the policy permits.

// Policy Attachment - Bittle
resource "aws_iot_policy_attachment" "att_bittles" {
  for_each = var.all_bittles == null ? {} : var.all_bittles

  policy = aws_iot_policy.pubsub_bittles.name
  target = aws_iot_certificate.cert_bittles[each.key].arn
}
// Policy Attachment - Bittle
resource "aws_iot_policy_attachment" "att_gas_sensors" {
  for_each = var.all_gas_sensors == null ? {} : var.all_gas_sensors

  policy = aws_iot_policy.pubsub_gas_sensors.name
  target = aws_iot_certificate.cert_gas_sensors[each.key].arn
}
