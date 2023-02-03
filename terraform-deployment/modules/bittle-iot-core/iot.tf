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
#     #   "AppName" = var.app_name
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

// Create IoT Thing Group for all Bittles
resource "aws_iot_thing_group" "bittle_fleet" {
  name = "Bittle_Fleet"
  properties {
    description = "Group containing all Petoi Bittles."
  }
}

// Assign Bittles to IoT Thing Group
resource "aws_iot_thing_group_membership" "bittle_fleet" {
  for_each         = var.all_bittles == null ? {} : var.all_bittles
  thing_name       = each.value.name
  thing_group_name = aws_iot_thing_group.bittle_fleet.name

  override_dynamic_group = true
}

// Create IoT Certificate Dynamically for each
resource "aws_iot_certificate" "cert" {
  for_each = var.all_bittles == null ? {} : var.all_bittles
  active   = true
}

// Create IoT Policy
resource "aws_iot_policy" "pubsub" {
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
// Policies have targets - these can include certificates, identities, and
// thing groups. Device certificates are installed on each ESP8266 via the
// .ino sketch. This allows the devices to use the policy and have permissions
// for what the policy permits.

// Policy Attachment
resource "aws_iot_policy_attachment" "att" {
  for_each = var.all_bittles == null ? {} : var.all_bittles

  policy = aws_iot_policy.pubsub.name
  target = aws_iot_certificate.cert[each.key].arn
}
