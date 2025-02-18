################################################################################
# SQS Module
################################################################################

module "sqs" {
  source = "git@github.com:terraform-aws-modules/terraform-aws-sqs.git?ref=v4.2.1"

  name = local.sqs_name

  tags = local.tags
}
