output "user_ids" {
  value = {
    for users in aws_iam_user.user:
    users.name => users.unique_id
  }
}

output "user_name" {
  value       = try(aws_iam_user.user[0].name)
  #value = {
    #for users in aws_iam_user.user:
    #users.name => users.name
  #}
}
  
output "user_arns" {
  value = {
    for users in aws_iam_user.user:
    users.name => users.arn
  }
}
