output "user_ids" {
  value = {
    for users in aws_iam_user.user:
    users.name => users.unique_id
  }
}

output "user_arns" {
  value = {
    for users in aws_iam_user.user:
    users.name => users.arn
  }
}
