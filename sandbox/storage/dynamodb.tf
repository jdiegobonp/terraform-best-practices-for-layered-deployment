module "dynamodb_table" {
  source = "git@github.com:terraform-aws-modules/terraform-aws-dynamodb-table.git?ref=v4.2.0"

  name                        = local.dynamodb_table_name
  hash_key                    = "id"
  range_key                   = "title"
  table_class                 = "STANDARD"
  deletion_protection_enabled = false

  attributes = [
    {
      name = "id"
      type = "N"
    },
    {
      name = "title"
      type = "S"
    },
    {
      name = "age"
      type = "N"
    }
  ]

  global_secondary_indexes = [
    {
      name               = "TitleIndex"
      hash_key           = "title"
      range_key          = "age"
      projection_type    = "INCLUDE"
      non_key_attributes = ["id"]

      on_demand_throughput = {
        max_write_request_units = 1
        max_read_request_units  = 1
      }
    }
  ]

  on_demand_throughput = {
    max_read_request_units  = 1
    max_write_request_units = 1
  }

  tags = {
    name        = local.dynamodb_table_name
    environment = local.environment
  }
}
