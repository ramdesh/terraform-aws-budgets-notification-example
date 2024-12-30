resource "aws_budgets_budget" "my_budget_daily" {
  name              = "my-budget-daily"
  budget_type       = "COST"
  limit_amount      = var.daily_cost_limit
  limit_unit        = "USD"
  time_period_end   = "2029-12-30_00:00"
  time_period_start = "2024-12-30_00:00"
  time_unit         = "DAILY"


  notification {
    comparison_operator       = "GREATER_THAN"
    threshold                 = 100
    threshold_type            = "PERCENTAGE"
    notification_type         = "ACTUAL"
    subscriber_sns_topic_arns = var.subscriber_sns_topic_arns
  }
}

resource "aws_budgets_budget" "my_budget_monthly" {
  name              = "my-budget-monthly"
  budget_type       = "COST"
  limit_amount      = var.monthly_cost_limit
  limit_unit        = "USD"
  time_period_end   = "2029-12-30_00:00"
  time_period_start = "2024-12-30_00:00"
  time_unit         = "MONTHLY"


  notification {
    comparison_operator       = "GREATER_THAN"
    threshold                 = 80
    threshold_type            = "PERCENTAGE"
    notification_type         = "ACTUAL"
    subscriber_sns_topic_arns = var.subscriber_sns_topic_arns
  }
}
