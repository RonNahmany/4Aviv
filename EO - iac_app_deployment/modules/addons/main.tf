resource "random_password" "dbpass" {
  length           = 32
  special          = true
  override_special = "_%@"
}
resource "random_password" "scim_token" {
  length  = 32              
  special = false           
}