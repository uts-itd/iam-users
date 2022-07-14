output "user_ids" {
  value = {
    for users in aws_iam_user.user:
    users.name => users.unique_id
  }
}
  
output "user_names" {
  value = {
    for users in aws_iam_user.user:
    users.name => users.name
  }
}

output "user_arns" {
  value = {
    for users in aws_iam_user.user:
    users.name => users.arn
  }
}

output "userids" {
  value       = values(aws_iam_user.user)[*].unique_id
}

output "usernames" {
  #value       = values(aws_iam_user.user)[*].name
  value       = try(aws_iam_user.user[0].name, "")
}
  
output "userarns" {
  value       = values(aws_iam_user.user)[*].arn
}
