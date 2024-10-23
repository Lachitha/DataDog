provider "aws" {
  region = "us-east-1" # Adjust the region as necessary
}

provider "datadog" {
  api_key   = var.datadog_api_key
  app_key   = var.datadog_app_key
}

resource "datadog_synthetics_test" "test_uptime" {
  name       = "Synthetics Test"
  type       = "api"
  subtype    = "http"
  status     = "live"
  message    = "Notify on failure"

  request_definition {
    method = "GET"
    url    = "http://54.160.164.216/datadog_monitor.html"
  }

  assertion {
    operator = "is"
    target   = "302"
    type     = "statusCode"
  }

  locations = [
    "aws:ap-southeast-1",
    "aws:eu-central-1",
    "aws:us-east-1",
  ]

  tick_every = 60 # Interval in seconds for the test to run

  # Optional: Uncomment if you have an existing monitor ID to link
  # monitor_id = "your_monitor_id" 
}

variable "datadog_api_key" {
  description = "The API key for Datadog"
  type        = string
}

variable "datadog_app_key" {
  description = "The application key for Datadog"
  type        = string
}
