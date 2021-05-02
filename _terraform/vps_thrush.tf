############
# firewall #
############
resource "vultr_firewall_group" "thrush_fw_group" {
  description = "thrush.vl.oefd.net firewall"
}

resource "vultr_firewall_rule" "thrush_fw_rule" {
  for_each = {
    "ssh"   = { proto = "tcp", ipv = "v4", net = "0.0.0.0", net_len = 0, port = "22" }
    "http"  = { proto = "tcp", ipv = "v4", net = "0.0.0.0", net_len = 0, port = "80" }
    "https" = { proto = "tcp", ipv = "v4", net = "0.0.0.0", net_len = 0, port = "443" }
  }
  firewall_group_id = vultr_firewall_group.thrush_fw_group.id
  protocol          = each.value.proto
  ip_type           = each.value.ipv
  subnet            = each.value.net
  subnet_size       = each.value.net_len
  port              = each.value.port
  notes             = each.key
}

###############
# private net #
###############
resource "vultr_private_network" "vl_private_net" {
  description = "vl private network"
  region      = "yto"
}

############
# instance #
############
resource "vultr_instance" "thrush_vl_oefd_net" {
  plan        = "vc2-1c-1gb"
  region      = "yto"
  os_id       = 352
  label       = "thrush.vl.oefd.net"
  hostname    = "thrush.vl.oefd.net"
  ssh_key_ids = [vultr_ssh_key.ssh_key["terry_at_oefd_net"].id]

  enable_ipv6            = true
  enable_private_network = true
  private_network_ids    = [vultr_private_network.vl_private_net.id]
  firewall_group_id      = vultr_firewall_group.thrush_fw_group.id
}
