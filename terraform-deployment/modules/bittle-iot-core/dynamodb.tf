# TODO - Dynamically create item for each Bittle defined. Metadata should include
# ThingName/Device Name, NyBoard Version, Device Status, Battery percentage, etc.

resource "random_uuid" "bc_devices" {
}

// Generate random device ID for each defined bittle
resource "random_uuid" "bittle_device_id" {
  for_each = var.all_bittles == null ? {} : var.all_bittles
}
resource "aws_dynamodb_table" "bc_devices" {
  name           = "bc_devices-${random_uuid.bc_devices.result}" // No touchy
  billing_mode   = var.bc_devices_billing_mode
  read_capacity  = var.bc_devices_read_capacity
  write_capacity = var.bc_devices_write_capacity
  hash_key       = "DeviceId" // Partition Key
  # range_key      = "-" // Sort Key

  attribute {
    name = "DeviceId"
    type = "S"
  }


  # ttl {
  #   attribute_name = "TimeToExist"
  #   enabled        = false
  # }

  # Workaround for "ValidationException: TimeToLive is already disabled"
  # when running terraform apply twice
  dynamic "ttl" {
    for_each = local.ttl
    content {
      enabled        = local.ttl[0].ttl_enable
      attribute_name = local.ttl[0].ttl_attribute
    }
  }

  # global_secondary_index {
  #   name               = "GameTitleIndex"
  #   hash_key           = "GameTitle"
  #   range_key          = "TopScore"
  #   write_capacity     = 10
  #   read_capacity      = 10
  #   projection_type    = "INCLUDE"
  #   non_key_attributes = ["UserId"]
  # }

  tags = merge(
    {
      "AppName" = var.bc_app_name
    },
    var.tags,
  )
}


resource "aws_dynamodb_table_item" "bc_devices_item" {
  for_each = var.all_bittles == null ? {} : var.all_bittles
  table_name = aws_dynamodb_table.bc_devices.name
  hash_key   = aws_dynamodb_table.bc_devices.hash_key

  item = jsonencode({
  "${aws_dynamodb_table.bc_devices.hash_key}": {"S": "${random_uuid.bittle_device_id[each.key].result}"},
  "DeviceName": {"S": "${each.value.name}"},
  "ShortName": {"S": "${each.value.short_name}"},
  "NyboardVersion": {"S": "${each.value.nyboard_version}"},
})
}

# resource "aws_dynamodb_table" "customer_table" {
# name           = "customer"
# billing_mode   = "PAY_PER_REQUEST"
# hash_key       = "customerId"
# stream_enabled = false
# attribute {
#   name = "customerId"
#   type = "S"
#  }
# }

# resource "aws_dynamodb_table_item" "customer_table_item" {
#   table_name = aws_dynamodb_table.customer_table.name
#   hash_key   = aws_dynamodb_table.customer_table.hash_key
#   depends_on = [aws_dynamodb_table.customer_table]
#   item = jsonencode({
#   "customerId" : {
#     "S" : "1"
#  },
#   "firstName" : {
#     "S" : "John"
#   },
#   "lastName" : {
#     "S" : "Doe"
#   },
# })
# }



