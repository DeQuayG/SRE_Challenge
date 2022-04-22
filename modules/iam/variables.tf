variable "environment_name" {
} 

variable "app_name" {

} 

variable "log_role_name" {
} 

variable "log_watcher_policy_name" {
} 

variable "rate" {
  description = "This variable defines how often canary is run, can be in minutes or hours"
} 

variable "canary_runtime" {
  description = "This is the runtime version and language canary will use for testing"
} 

variable "canary_handler" {
} 

variable "canary_role_policy_name" {
} 

variable "canary_role_name" {
}

variable "vpc" {
  type = list
}