resource "google_iam_workload_identity_pool" "woopick_tfc_identity_pool" {
  workload_identity_pool_id = "terraform-pool-woopick"
  display_name              = "terraform-pool-woopick"
  description               = "Production Pool woopick"
  disabled                  = false
}


resource "google_iam_workload_identity_pool_provider" "woopick_tfc_provider" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.woopick_tfc_identity_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "terraform-provider-woopick"
  display_name                       = "terraform-provider-woopick"
  description                        = "Terraform Cloud OIDC Provider"
  disabled                           = false

  attribute_mapping = {
    "attribute.tfc_organization_id" = "assertion.terraform_organization_id"
    "attribute.tfc_project_id"      = "assertion.terraform_project_id"
    "attribute.tfc_project_name"    = "assertion.terraform_project_name"
    "google.subject"                = "assertion.sub"
    "attribute.tfc_workspace_name"  = "assertion.terraform_workspace_name"
    "attribute.tfc_workspace_env"   = "assertion.terraform_workspace_name.split('-')[assertion.terraform_workspace_name.split('-').size() -1]"
  }

  oidc {
    issuer_uri = "https://app.terraform.io"
  }

}

resource "google_iam_workload_identity_pool_provider" "woopick_github_provider" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.woopick_tfc_identity_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-provider-woopick"
  display_name                       = "github-provider-woopick"
  description                        = "github Cloud OIDC Provider"
  disabled                           = false

  attribute_mapping = {
    "attribute.repository" = "assertion.repository"
    "google.subject"       = "assertion.sub"
  }

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }

}