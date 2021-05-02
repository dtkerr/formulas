resource "cloudflare_zone" "oefd_xyz" {
  zone   = "oefd.xyz"
  paused = false
  plan   = "free"
  type   = "full"
}

########
# acme #
########
resource "cloudflare_record" "oefd_xyz_caa" {
  for_each = {
    # cloudflare manages CAA records already
    #10 = { name = "@", val = "letsencrypt.org.", tag = "issue", ttl = 14400 }
  }
  zone_id = cloudflare_zone.oefd_xyz.id
  type    = "CAA"

  name = each.value.name
  data = {
    flags = 0
    tag   = "issue"
    value = "letsencrypt.org."
  }
  ttl = each.value.ttl
}
resource "cloudflare_record" "oefd_xyz_acme_txt" {
  for_each = {
    ""     = "oefd.xyz.acme.oefd.net"
    ".www" = "www.oefd.xyz.acme.oefd.net"
  }
  zone_id = cloudflare_zone.oefd_xyz.id
  type    = "CNAME"
  name    = join("", ["_acme-challenge", each.key])
  value   = each.value
  ttl     = 1
}

############
# apex web #
############
resource "cloudflare_record" "oefd_xyz_apex_web" {
  for_each = {
    10 = { type = "A", host = "@", val = vultr_instance.thrush_vl_oefd_net.main_ip }
    20 = { type = "AAAA", host = "@", val = vultr_instance.thrush_vl_oefd_net.v6_main_ip }
    30 = { type = "CNAME", host = "www", val = "oefd.xyz" }
  }
  zone_id = cloudflare_zone.oefd_xyz.id
  type    = each.value.type
  proxied = true

  name  = each.value.host
  value = each.value.val
  ttl   = 1
}
