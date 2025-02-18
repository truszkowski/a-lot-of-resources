terraform {
  required_providers {
    spacelift = {
      source  = "spacelift-io/spacelift"
      version = "~> 0.1"
    }
  }
}

provider "spacelift" {}

variable stacks {
  type    = number
  default = 5
}

variable pets_resources {
  type    = number 
  default = 5
}

variable worker_pool_id {
  type = string
}

resource "spacelift_stack" "resources-redesign-stack" {
  count          = var.stacks 
  name           = "Resources redesign stack #${count.index}"
  repository     = "a-lot-of-resources"
  branch         = "main"
  autodeploy     = true
  space_id       = "root"
  labels         = ["index-${count.index}", "resources-redesign"]
  worker_pool_id = var.worker_pool_id
}

resource "spacelift_environment_variable" "resources-redesign-pets" {
  count       = var.stacks
  stack_id    = spacelift_stack.resources-redesign-stack[count.index].id
  name        = "TF_VAR_pets"
  value       = "${var.pets_resources}"
  write_only  = false
}

