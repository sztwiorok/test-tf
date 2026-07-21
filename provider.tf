# The token can also be supplied via the BUDDY_TOKEN environment variable.
# Required token scopes: WORKSPACE, PROJECT_DELETE, EXECUTION_MANAGE, EXECUTION_INFO
provider "buddy" {
  token = var.buddy_token
}
