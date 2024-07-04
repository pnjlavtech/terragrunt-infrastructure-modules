# first configure the OIDC provider in AWS account
resource "aws_iam_openid_connect_provider" "github_actions" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = ["ffffffffffffffffffffffffffffffffffffffff"]
}
# NOTE: The thumbprint is mandatory, but it won't be used at all so set it to fff as suggested by github. 
# The client_id_list is the audience




# third create the role based on the policy template
resource "aws_iam_role" "github_actions" {
  name               = "github_oidc_role"
  assume_role_policy = data.aws_iam_policy_document.oidc.json
}




# Alt
# resource "aws_iam_openid_connect_provider" "github_actions" {
#   url             = "https://token.actions.githubusercontent.com"
#   client_id_list  = ["sts.amazonaws.com"]
#   thumbprint_list = [data.tls_certificate.oidc_thumbprint.certificates[0].sha1_fingerprint]
# }

