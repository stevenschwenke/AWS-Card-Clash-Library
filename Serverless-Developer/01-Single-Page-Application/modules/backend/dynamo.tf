resource "aws_dynamodb_table" "Fortunes" {
  name = "Fortunes"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "id"
  attribute {
    name = "id"
    type = "S"  # String data type
  }
  attribute {
    name = "fortune"
    type = "S"
  }

  global_secondary_index {
    name            = "FortuneIndex"
    hash_key        = "fortune"
    projection_type = "ALL"
  }

  tags = {
    Name = "Fortunes"
    architecture = "sd-01"
  }
}
