module "my-sns" {
  source                      = "./sns"
  cost_alert_email_recipients = var.cost_alert_email_recipients
}

module "my-budget" {
  source                    = "./budgets"
  daily_cost_limit          = var.daily_cost_limit
  monthly_cost_limit        = var.monthly_cost_limit
  subscriber_sns_topic_arns = module.my-sns.budget_subscriber_topic_arns
}
