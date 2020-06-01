data aws_iam_policy_document billing {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.idp_account_id}:root"]
    }
  }
}

data aws_iam_policy_document "sns_topic_policy_budget" {
  count     = var.enable_budget ? 1 : 0
  policy_id = "__default_policy_ID"

  statement {
    actions   = ["SNS:Publish"]
    effect    = "Allow"
    resources = [aws_sns_topic.budget_updates.*.arn[0]]
    sid       = "__default_policy_ID"
    principals {
      type        = "Service"
      identifiers = ["budgets.amazonaws.com"]
    }
  }
}

data aws_iam_policy_document "assume_role_chatbot" {
  count = var.enable_budget && var.enable_chatbot_slack ? 1 : 0

  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["chatbot.amazonaws.com"]
    }
  }
}
