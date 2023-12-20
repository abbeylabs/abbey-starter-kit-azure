locals {
  account_name = ""
  repo_name = ""

  project_path = "github://${local.account_name}/${local.repo_name}"
  policies_path = "${local.project_path}/policies"
}

resource "azuread_group" "quickstart_group" {
  display_name = "quickstart_group"
  security_enabled = true
}

data "azuread_user" "dev_azure_user" {
  user_principal_name = "replace-me-EXT-MICROSOFT_UPN@example.com" # need to use azure userPrincipalName
}

resource "abbey_grant_kit" "azure_quickstart_group" {
  name = "azure_quickstart_group"
  description = <<-EOT
    Grants access to our Azure quickstart group.
  EOT

  workflow = {
    steps = [
      {
        reviewers = {
          one_of = ["replace-me@example.com"] # CHANGEME
        }
      }
    ]
  }

  policies = [
    { bundle = local.policies_path }
  ]

  output = {
    location = "${local.project_path}/access.tf"
    append = <<-EOT
      resource "azuread_group_member" "group_member" {
        group_object_id  = azuread_group.quickstart_group.id}
        member_object_id = data.azuread_user.dev_azure_user.id
      }
    EOT
  }
}

