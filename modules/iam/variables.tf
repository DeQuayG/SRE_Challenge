variable "environment_name" {
  default = "dev"
} 

variable "app_name" {
  default = "web_app"
} 

variable "log_role_name" {
    default = "log_watcher"
} 

variable "log_watcher_policy_name" {
  default = "log_policy"
} 

variable "rate" {
  description = "This variable defines how often canary is run, can be in minutes or hours"
  default = "10"
} 

variable "canary_runtime" {
  description = "This is the runtime version and language canary will use for testing"
  default = "syn-python-selenium-1.0"
} 

variable "canary_handler" {
  default = "exports.handler"
} 

variable "canary_role_policy_name" {
  default = "canary_role_policy"
} 

variable "canary_role_name" {
  default = "canary"
}

variable "vpc" {
  type = list
}