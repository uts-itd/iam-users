output "user_ids" {
  value       = values(aws_iam_user.user)[*].unique_id
}

output "user_name" {
  value       = values(aws_iam_user.user)[*].name
}
  
output "user_arns" {
  value       = values(aws_iam_user.user)[*].arn
}
