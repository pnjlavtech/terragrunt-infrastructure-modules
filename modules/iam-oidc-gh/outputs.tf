output "aws_iam_role_github_actions_arn" {
  description = "aws_iam_openid_connect_provider_github_actions_arn"
  value       = module.iam-oidc-gh.aws_iam_role.github_actions.arn
}