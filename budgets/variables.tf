variable "subscriber_sns_topic_arns" {
  description = "List of SNS topics to trigger when cost threshold is met"
  type        = list(string)
}
variable "daily_cost_limit" {
  description = "Cost limit for daily budget"
  type        = string
}
variable "monthly_cost_limit" {
  description = "Cost limit for monthly budget"
  type        = string
}
