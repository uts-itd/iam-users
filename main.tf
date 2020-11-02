resource "aws_iam_user" "user" {
  for_each      = var.users

  name          = each.key
  path          = each.value["path"]
  force_destroy = each.value["force_destroy"]

  tags          = map("EmailAddress", each.value["tag_email"])
}

resource "aws_iam_access_key" "credentials" {
  for_each      = var.users
  user          = each.key
}

resource "aws_secretsmanager_secret" "credentials" {
  for_each      = var.users

  name          = each.key
  description   = "credentials for ${each.key}"
}

resource "aws_secretsmanager_secret_version" "credentials" {
  for_each      = var.users

  secret_id     = aws_secretsmanager_secret.credentials[each.key].id
  secret_string = "{\"AccessKey\": data.aws_iam_access_key.credentials${each.key}.id,\"SecretAccessKey\": data.aws_iam_access_key.credentials${each.key}.secret}"
}
