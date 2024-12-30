output "budget_subscriber_topic_arns" {
  value       = [aws_sns_topic.my_cost_alerts_topic.arn]
  description = "Topic ARNs for SNS subscriptions for budget"
}
