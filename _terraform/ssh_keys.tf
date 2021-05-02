variable "ssh_keys" {
  description = "SSH keys to give access to resources"
  type        = map(any)
  default = {
    terry_at_oefd_net = {
      name = "terry@oefd.net"
      key  = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBPAnRmR2KKkZQzMZJ6LjS1ePmfcAy9Z7aXHweuzh9H0"
    },
  }
}

resource "github_user_ssh_key" "ssh_key" {
  for_each = var.ssh_keys
  title    = each.value.name
  key      = each.value.key
}

resource "vultr_ssh_key" "ssh_key" {
  for_each = var.ssh_keys
  name     = each.key
  ssh_key  = each.value.key
}
