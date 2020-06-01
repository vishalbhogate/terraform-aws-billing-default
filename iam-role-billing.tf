resource aws_iam_role billing {
  name                 = "${var.org_name}-billing"
  assume_role_policy   = data.aws_iam_policy_document.billing.json
  max_session_duration = var.role_max_session_duration
}

resource aws_iam_role_policy_attachment "billing" {
  role       = aws_iam_role.billing.name
  policy_arn = "arn:aws:iam::aws:policy/job-function/Billing"
}

