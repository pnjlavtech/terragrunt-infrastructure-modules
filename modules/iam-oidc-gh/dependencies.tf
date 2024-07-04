# Create the policy that will allow GitHub Actions to assume a certain role

# Second use the aws_iam_policy_document to create the template of the policy. 
data "aws_iam_policy_document" "oidc" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github_actions.arn]
    }

    condition {
      test     = "StringEquals"
      values   = ["sts.amazonaws.com"]
      variable = "token.actions.githubusercontent.com:aud"
    }

    condition {
      test     = "StringLike"
      values   = ["repo:pnjlavtech/*"]
      variable = "token.actions.githubusercontent.com:sub"
    }
  }
}



# alt
# data "tls_certificate" "oidc_thumbprint" {
#   url = "https://token.actions.githubusercontent.com"
# }
