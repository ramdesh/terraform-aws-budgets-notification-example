variable "daily_cost_limit" {
  description = "Cost limit for daily budget"
  type        = string
  default     = "100"
}

variable "monthly_cost_limit" {
  description = "Cost limit for monthly budget"
  type        = string
  default     = "1000"
}

variable "cost_alert_email_recipients" {
  description = "List of email addresses to send cost alerts to"
}