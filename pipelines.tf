# Build one pipeline per (project x environment) combination.
locals {
  pipelines = {
    for pair in setproduct(keys(var.projects), keys(var.environments)) :
    "${pair[0]}-${pair[1]}" => {
      project_key = pair[0]
      env         = pair[1]
      ref         = var.environments[pair[1]].ref
      mode        = var.environments[pair[1]].mode
    }
  }
}

resource "buddy_pipeline" "this" {
  for_each = local.pipelines

  domain       = var.domain
  project_name = buddy_project.this[each.value.project_key].name
  name         = each.value.env

  # MANUAL: run on demand against the given branch (e.g. prod).
  refs = each.value.mode == "MANUAL" ? [each.value.ref] : null

  # PUSH: run automatically on every push to the environment's branch.
  dynamic "event" {
    for_each = each.value.mode == "PUSH" ? [each.value.ref] : []
    content {
      type = "PUSH"
      refs = ["refs/heads/${event.value}"]
    }
  }
}
