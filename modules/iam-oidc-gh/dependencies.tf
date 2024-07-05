# Create the policy that will allow GitHub Actions to assume a certain role

# Second use the aws_iam_policy_document to create the template of the iam oidc policy. 
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
      values   = ["repo:pnjlavtech/"]
      variable = "token.actions.githubusercontent.com:sub"
    }
  }
}


# Fourth identify the AWS services and policy actions needed for oidc (gha assumed) role to be able to perform
# for now give blanket s3 perms on all s3 resources
data "aws_iam_policy_document" "deploy" {
  statement {
    effect  = "Allow"
    actions = [
      "s3:*",
    ]
    resources = ["*"]
  }
}


# {
#   "Effect": "Allow",
#   "Action": "s3:ListBucket",
#   "Resource": "arn:aws:s3:::productionapp"
# },
# {
#   "Effect": "Allow",
#   "Action": [
#     "s3:GetObject",
#     "s3:PutObject",
#     "s3:DeleteObject"
#   ],
#   "Resource": "arn:aws:s3:::productionapp/*"
# }


# "Action": [
#     "s3:GetObject",
#     "s3:GetBucketLocation",
#     "s3:ListBucket"
# ],
# "Resource": [
#     "arn:aws:s3:::awsexamplebucket1/*",
#     "arn:aws:s3:::awsexamplebucket1"



# alt
# data "tls_certificate" "oidc_thumbprint" {
#   url = "https://token.actions.githubusercontent.com"
# }
