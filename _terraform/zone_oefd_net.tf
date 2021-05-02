resource "cloudflare_zone" "oefd_net" {
  zone   = "oefd.net"
  paused = false
  plan   = "free"
  type   = "full"
}

########
# acme #
########
resource "cloudflare_record" "oefd_net_caa" {
  for_each = {
    # cloudflare manages CAA records already
    #10 = { name = "@", val = "letsencrypt.org.", tag = "issue", ttl = 14400 }
  }
  zone_id = cloudflare_zone.oefd_net.id
  type    = "CAA"

  name = each.value.name
  data = {
    flags = 0
    tag   = "issue"
    value = "letsencrypt.org."
  }
  ttl = each.value.ttl
}
resource "cloudflare_record" "oefd_net_acme_txt" {
  for_each = {
    ""            = "oefd.net.acme.oefd.net"
    ".www"        = "www.oefd.net.acme.oefd.net"
    ".assets"     = "assets.oefd.net.acme.oefd.net"
    ".pasteflare" = "pasteflare.oefd.net.acme.oefd.net"
    ".cfweb"      = "cfweb.oefd.net.acme.oefd.net"
    ".thrush.v1"  = "thrush.v1.oefd.net.acme.oefd.net"
  }
  zone_id = cloudflare_zone.oefd_net.id
  type    = "CNAME"
  name    = join("", ["_acme-challenge", each.key])
  value   = each.value
  ttl     = 1
}

############
# apex web #
############
resource "cloudflare_record" "oefd_net_apex_web" {
  for_each = {
    10 = { type = "A", host = "@", val = vultr_instance.thrush_vl_oefd_net.main_ip }
    20 = { type = "AAAA", host = "@", val = vultr_instance.thrush_vl_oefd_net.v6_main_ip }
    30 = { type = "CNAME", host = "www", val = "oefd.net" }
  }
  zone_id = cloudflare_zone.oefd_net.id
  type    = each.value.type
  proxied = true

  name  = each.value.host
  value = each.value.val
  ttl   = 1
}

##############
# apex email #
##############
resource "cloudflare_record" "oefd_net_apex_email_mx" {
  for_each = {
    10 = { val = "aspmx1.migadu.com", ttl = 14400, priority = 10 }
    11 = { val = "aspmx2.migadu.com", ttl = 14400, priority = 20 }
  }
  zone_id = cloudflare_zone.oefd_net.id
  type    = "MX"

  name     = "oefd.net"
  value    = each.value.val
  ttl      = each.value.ttl
  priority = each.value.priority
}
resource "cloudflare_record" "oefd_net_apex_email" {
  for_each = {
    10 = { type = "CNAME", host = "key1._domainkey", val = "key1.oefd.net._domainkey.migadu.com", ttl = 14400 }
    11 = { type = "CNAME", host = "key2._domainkey", val = "key2.oefd.net._domainkey.migadu.com", ttl = 14400 }
    12 = { type = "CNAME", host = "key3._domainkey", val = "key3.oefd.net._domainkey.migadu.com", ttl = 14400 }
    20 = { type = "TXT", host = "@", val = "hosted-email-verify=ljtp9k6p", ttl = 14400 }
    30 = { type = "TXT", host = "@", val = "v=spf1 include:spf.migadu.com -all", ttl = 14400 }
    40 = { type = "TXT", host = "_dmarc", val = "v=DMARC1; p=reject;", ttl = 14400 }
  }
  zone_id = cloudflare_zone.oefd_net.id
  type    = each.value.type

  name  = each.value.host
  value = each.value.val
  ttl   = each.value.ttl
}

#######################
# pasteflare.oefd.net #
#######################
resource "cloudflare_record" "pasteflare_oefd_net" {
  for_each = {
    10 = { type = "A", host = "pasteflare", val = vultr_instance.thrush_vl_oefd_net.main_ip }
    20 = { type = "AAAA", host = "pasteflare", val = vultr_instance.thrush_vl_oefd_net.v6_main_ip }
  }
  zone_id = cloudflare_zone.oefd_net.id
  type    = each.value.type
  proxied = true

  name  = each.value.host
  value = each.value.val
  ttl   = 1
}

##################
# cfweb.oefd.net #
##################
resource "cloudflare_record" "cfweb_oefd_net" {
  for_each = {
    10 = { type = "A", host = "cfweb", val = vultr_instance.thrush_vl_oefd_net.main_ip }
    20 = { type = "AAAA", host = "cfweb", val = vultr_instance.thrush_vl_oefd_net.v6_main_ip }
  }
  zone_id = cloudflare_zone.oefd_net.id
  type    = each.value.type
  proxied = true

  name  = each.value.host
  value = each.value.val
  ttl   = 1
}

###################
# assets.oefd.net #
###################
resource "cloudflare_record" "assets_oefd_net" {
  for_each = {
    10 = { type = "A", host = "assets", val = vultr_instance.thrush_vl_oefd_net.main_ip }
    20 = { type = "AAAA", host = "assets", val = vultr_instance.thrush_vl_oefd_net.v6_main_ip }
  }
  zone_id = cloudflare_zone.oefd_net.id
  type    = each.value.type
  proxied = true

  name  = each.value.host
  value = each.value.val
  ttl   = 1
}

###################
# vultr instances #
###################
resource "cloudflare_record" "oefd_net_thrush_vl" {
  for_each = {
    10 = { type = "A", host = "thrush.vl", val = vultr_instance.thrush_vl_oefd_net.main_ip }
    20 = { type = "AAAA", host = "thrush.vl", val = vultr_instance.thrush_vl_oefd_net.v6_main_ip }
  }
  zone_id = cloudflare_zone.oefd_net.id
  type    = each.value.type
  proxied = false

  name  = each.value.host
  value = each.value.val
  ttl   = 14400
}
