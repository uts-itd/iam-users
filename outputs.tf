output "user_ids" {
  value = {
    for users in aws_iam_user.user:
    user_name.name => user_name.unique_id
  }
}

output "user_arns" {
  value = {
    for users in aws_iam_user.user:
    user_name.name => user_name.arn
  }
}
