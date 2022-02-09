output "generated_user_password" {
  description = "The auto generated default user password if not input password was provided"
  #value       = module.postgres.random_id.user-password.hex
  value       = module.postgres.generated_user_password
  sensitive   = true
}