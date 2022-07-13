resource "aws_iam_user" "user" {
  for_each      = var.users

  name          = each.key
  path          = each.value["path"]
  force_destroy = each.value["force_destroy"]

  #tags          = map("EmailAddress", each.value["tag_email"])
}

resource "aws_iam_access_key" "credentials" {
  for_each      = var.users
  user          = each.key
  depends_on = [
    aws_iam_user.user,
  ]
}

resource "aws_secretsmanager_secret" "credentials" {
  for_each      = var.users

  name          = each.key
  description   = "credentials for ${each.key}"
}

resource "aws_secretsmanager_secret_version" "credentials" {
  for_each      = var.users

  secret_id     = aws_secretsmanager_secret.credentials[each.key].id
	secret_string = jsonencode({"AccessKey" = aws_iam_access_key.credentials[each.key].id, "SecretAccessKey" = aws_iam_access_key.credentials[each.key].secret})
	depends_on = [
   aws_secretsmanager_secret.credentials,
  ]
}
