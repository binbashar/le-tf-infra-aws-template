#=============================#
# Notifications               #
#=============================#
#
# AWS SNS -> Lambda -> Slack: tools-monitoring-sec
#
variable "sns_topic_name_monitoring_sec" {
  description = ""
  default     = "sns-topic-slack-notify-monitoring-sec"

#
# security/config/backend.tfvars
#
#================================#
# Terraform AWS Backend Settings #
#================================#
variable "region" {
  type        = string
  description = "AWS Region"
}

variable "profile" {
  type        = string
  description = "AWS Profile (required by the backend but also used for other resources)"
}

variable "bucket" {
  type        = string
  description = "AWS S3 TF State Backend Bucket"
}

variable "dynamodb_table" {
  type        = string
  description = "AWS DynamoDB TF Lock state table name"
}

variable "encrypt" {
  type        = bool
  description = "Enable AWS DynamoDB with server side encryption"
}

#
# config/common.tfvars
#
#=============================#
# Project Variables           #
#=============================#
variable "project" {
  type        = string
  description = "Project Name"
}

variable "project_long" {
  type        = string
  description = "Project Long Name"
}

variable "environment" {
  type        = string
  description = "Environment Name"
}

variable "region_secondary" {
  type        = string
  description = "AWS Secondary Region for HA"
}

variable "management_account_id" {
  type        = string
  description = "Account: Management"
}

variable "security_account_id" {
  type        = string
  description = "Account: Security & Users Management"
}

variable "shared_account_id" {
  type        = string
  description = "Account: Shared Resources"
}
