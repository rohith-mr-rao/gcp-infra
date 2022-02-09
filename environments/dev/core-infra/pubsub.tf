module "pubsub" {
  source       = "../../../shared-modules/terraform-google-pubsub"
  for_each = toset(["questionnaire", "fhir", "dc-to-pas","pas-to-dc"])  
  project_id   = var.project_id
  topic        = "${var.prefix}-${each.key}-topic"
  grant_token_creator	= false
  pull_subscriptions = [
    {
      name                    = "${var.prefix}-${each.key}-sub"
      ack_deadline_seconds    = 10
      max_delivery_attempts   = 5
      maximum_backoff         = "600s"
      minimum_backoff         = "300s"
      enable_message_ordering = false
    }
  ]
}
