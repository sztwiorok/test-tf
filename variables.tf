variable "buddy_token" {
  description = "Buddy Personal Access Token or OAuth2 token. Prefer setting BUDDY_TOKEN env var instead of hardcoding."
  type        = string
  sensitive   = true
  default     = null
}

variable "domain" {
  description = "The Buddy workspace URL handle (e.g. 'mydomain' from mydomain.buddy.works)."
  type        = string
}

variable "projects" {
  description = "Projects to create in the workspace, keyed by internal name."
  type = map(object({
    display_name = string
  }))
  default = {
    service-a = { display_name = "Service A" }
    service-b = { display_name = "Service B" }
  }
}

variable "environments" {
  description = "Pipeline environments per project. mode: PUSH (auto on push to branch) or MANUAL."
  type = map(object({
    ref  = string
    mode = string
  }))
  default = {
    dev   = { ref = "develop", mode = "PUSH" }
    stage = { ref = "staging", mode = "PUSH" }
    prod  = { ref = "main", mode = "MANUAL" }
  }

  validation {
    condition     = alltrue([for e in var.environments : contains(["PUSH", "MANUAL"], e.mode)])
    error_message = "Each environment's mode must be either PUSH or MANUAL."
  }
}
