output "sns_topic_arn" {
  value = aws_sns_topic.cpu_alerts.arn
}

output "cloudwatch_alarm_name" {
  value = aws_cloudwatch_metric_alarm.high_cpu_alarm.alarm_name
} 
