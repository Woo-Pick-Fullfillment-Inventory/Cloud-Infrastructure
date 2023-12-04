terraform {
  cloud {
    organization = "WooPickInventory"

    hostname = "app.terraform.io"

    workspaces {
      name = "cloud-infrastructure"
    }
  }

  required_providers {
    github = {
      source = "integrations/github"
    }

    google = {
      source  = "hashicorp/google"
      version = ">= 4.0.0"
    }
  }

  required_version = ">= 0.14"
}