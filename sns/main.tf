data "aws_caller_identity" "current" {}

resource "aws_sns_topic" "my_cost_alerts_topic" {
  name = "my-cost-alerts-topic"
}

resource "aws_sns_topic_policy" "my_cost_alerts_topic_policy" {
  arn    = aws_sns_topic.my_cost_alerts_topic.arn
  policy = data.aws_iam_policy_document.my_sns_topic_policy.json
}

data "aws_iam_policy_document" "my_sns_topic_policy" {
  policy_id = "my-sns-topic-policy"

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission"
    ]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        data.aws_caller_identity.current.account_id
      ]
    }
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    resources = [
      aws_sns_topic.my_cost_alerts_topic.arn
    ]
    sid = "SnsPolicyStmt"
  }

  statement {
    sid    = "BudgetsPublishingPermission"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["budgets.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"

      values = [
        data.aws_caller_identity.current.account_id
      ]
    }
    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values = [
        "arn:aws:budgets::${data.aws_caller_identity.current.account_id}:*"
      ]
    }
    actions = [
      "SNS:Publish"
    ]
    resources = [
      aws_sns_topic.my_cost_alerts_topic.arn
    ]
  }
}


resource "aws_sns_topic_subscription" "cost_alerts_email_subscription" {
  count     = length(var.cost_alert_email_recipients)
  topic_arn = aws_sns_topic.my_cost_alerts_topic.arn
  protocol  = "email"
  endpoint  = var.cost_alert_email_recipients[count.index]
}



