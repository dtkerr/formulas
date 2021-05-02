resource "vultr_dns_domain" "oefd_ca" {
  domain = "oefd.ca"
}

########
# acme #
########
resource "vultr_dns_record" "oefd_ca_acme" {
  for_each = {
    10 = { type = "CAA", host = "", val = "0 issue \"letsencrypt.org\"", ttl = 14400 }
    20 = { type = "CNAME", host = "_acme-challenge", val = "oefd.ca.acme.oefd.net", ttl = 14400 }
    30 = { type = "CNAME", host = "_acme-challenge.www", val = "www.oefd.ca.acme.oefd.net", ttl = 14400 }
  }
  domain = vultr_dns_domain.oefd_ca.id
  type   = each.value.type

  name = each.value.host
  data = each.value.val
  ttl  = each.value.ttl
}

############
# apex web #
############
resource "vultr_dns_record" "oefd_ca_apex_web" {
  for_each = {

    10 = { type = "A", host = "", val = vultr_instance.thrush_vl_oefd_net.main_ip, ttl = 14400 }
    20 = { type = "AAAA", host = "", val = vultr_instance.thrush_vl_oefd_net.v6_main_ip, ttl = 14400 }
    30 = { type = "CNAME", host = "www", val = "oefd.ca", ttl = 14400 }
  }
  domain = vultr_dns_domain.oefd_ca.id
  type   = each.value.type

  name = each.value.host
  data = each.value.val
  ttl  = each.value.ttl
}

##############
# apex email #
##############
resource "vultr_dns_record" "oefd_ca_apex_email_mx" {
  for_each = {
    10 = { val = "mail.protonmail.ch", ttl = 14400, priority = 10 }
    11 = { val = "mailsec.protonmail.ch", ttl = 14400, priority = 20 }
  }
  domain = vultr_dns_domain.oefd_ca.id
  type   = "MX"

  name     = ""
  data     = each.value.val
  ttl      = each.value.ttl
  priority = each.value.priority
}
resource "vultr_dns_record" "oefd_ca_apex_email" {
  for_each = {
    10 = { type = "TXT", host = "", val = "\"v=spf1 include:_spf.protonmail.ch mx ~all\"", ttl = 14400 }
    20 = { type = "TXT", host = "", val = "\"protonmail-verification=7fa3d2897573c83c9964429f4eb4dad7442b2fd1\"", ttl = 14400 }
    30 = { type = "TXT", host = "_dmarc", val = "\"v=DMARC1; p=quarantine; rua=mailto:postmaster@oefd.ca\"", ttl = 14400 }
    40 = { type = "CNAME", host = "protonmail._domainkey", val = "protonmail.domainkey.dnrfil4ed4ofjws6sn3swij7pfca4c4l3o7i2m4q7xayihdvory6a.domains.proton.ch", ttl = 14400 }
    41 = { type = "CNAME", host = "protonmail2._domainkey", val = "protonmail2.domainkey.dnrfil4ed4ofjws6sn3swij7pfca4c4l3o7i2m4q7xayihdvory6a.domains.proton.ch", ttl = 14400 }
    42 = { type = "CNAME", host = "protonmail3._domainkey", val = "protonmail3.domainkey.dnrfil4ed4ofjws6sn3swij7pfca4c4l3o7i2m4q7xayihdvory6a.domains.proton.ch", ttl = 14400 }
  }
  domain = vultr_dns_domain.oefd_ca.id
  type   = each.value.type

  name = each.value.host
  data = each.value.val
  ttl  = each.value.ttl
}
