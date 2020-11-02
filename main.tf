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
  secret_id     = aws_secretsmanager_secret.credentials.*.id
  secret_string = "{\"AccessKey\": data.aws_iam_access_key.credentials.*.id,\"SecretAccessKey\": data.aws_iam_access_key.credentials.*.secret}"
}

resource "aws_iam_user_group_membership" "group_membership" {
  for_each      = var.group_memberships

  user          = each.key
  groups        = each.value

  depends_on    = [aws_iam_user.user]
}
