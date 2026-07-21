resource "buddy_project" "this" {
  for_each = var.projects

  domain       = var.domain
  display_name = each.value.display_name
}
