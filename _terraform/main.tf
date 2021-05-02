terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 2.20"
    }
    vultr = {
      source  = "vultr/vultr"
      version = "2.2.0"
    }
    github = {
      source  = "integrations/github"
      version = "4.9.2"
    }
  }
}
