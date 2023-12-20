terraform {
  required_providers {
    abbey = {
      source = "abbeylabs/abbey"
      version = "~> 0.2.6"
    }

    azuread = {
      source = "hashicorp/azuread"
      version = "~> 2.41.0"
    }
  }
}
