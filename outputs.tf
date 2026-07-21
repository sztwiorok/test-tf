output "projects" {
  description = "Created projects: internal key => unique name / URL."
  value = {
    for k, p in buddy_project.this : k => {
      name     = p.name
      html_url = p.html_url
    }
  }
}

output "pipelines" {
  description = "Created pipelines: key => project / name / URL."
  value = {
    for k, p in buddy_pipeline.this : k => {
      project  = p.project_name
      name     = p.name
      html_url = p.html_url
    }
  }
}
