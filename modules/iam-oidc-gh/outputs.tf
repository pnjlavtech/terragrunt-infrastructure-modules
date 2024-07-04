output "aws_iam_role_github_actions_name" {
  description = "AWS IAM role for gihub actions to use for JWT (OIDC)"
  value       = aws_iam_role.github_actions.name
}