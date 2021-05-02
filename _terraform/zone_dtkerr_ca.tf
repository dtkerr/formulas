resource "vultr_dns_domain" "dtkerr_ca" {
  domain = "dtkerr.ca"
}

########
# acme #
########
resource "vultr_dns_record" "dtkerr_ca_acme" {
  for_each = {
    10 = { type = "CAA", host = "", val = "0 issue \"letsencrypt.org\"", ttl = 14400 }
    20 = { type = "CNAME", host = "_acme-challenge", val = "dtkerr.ca.acme.oefd.net", ttl = 14400 }
    30 = { type = "CNAME", host = "_acme-challenge.www", val = "www.dtkerr.ca.acme.oefd.net", ttl = 14400 }
  }
  domain = vultr_dns_domain.dtkerr_ca.id
  type   = each.value.type

  name = each.value.host
  data = each.value.val
  ttl  = each.value.ttl
}

############
# apex web #
############
resource "vultr_dns_record" "dtkerr_ca_apex_web" {
  for_each = {

    10 = { type = "A", host = "", val = vultr_instance.thrush_vl_oefd_net.main_ip, ttl = 14400 }
    20 = { type = "AAAA", host = "", val = vultr_instance.thrush_vl_oefd_net.v6_main_ip, ttl = 14400 }
    30 = { type = "CNAME", host = "www", val = "dtkerr.ca", ttl = 14400 }
  }
  domain = vultr_dns_domain.dtkerr_ca.id
  type   = each.value.type

  name = each.value.host
  data = each.value.val
  ttl  = each.value.ttl
}

##############
# apex email #
##############
resource "vultr_dns_record" "dtkerr_ca_apex_email_mx" {
  for_each = {
    10 = { val = "aspmx1.migadu.com", ttl = 14400, priority = 10 }
    11 = { val = "aspmx2.migadu.com", ttl = 14400, priority = 20 }
  }
  domain = vultr_dns_domain.dtkerr_ca.id
  type   = "MX"

  name     = ""
  data     = each.value.val
  ttl      = each.value.ttl
  priority = each.value.priority
}
resource "vultr_dns_record" "dtkerr_ca_apex_email" {
  for_each = {
    10 = { type = "CNAME", host = "key1._domainkey", val = "key1.dtkerr.ca._domainkey.migadu.com", ttl = 14400 }
    11 = { type = "CNAME", host = "key2._domainkey", val = "key2.dtkerr.ca._domainkey.migadu.com", ttl = 14400 }
    12 = { type = "CNAME", host = "key3._domainkey", val = "key3.dtkerr.ca._domainkey.migadu.com", ttl = 14400 }
    20 = { type = "TXT", host = "", val = format("\"%s\"", "hosted-email-verify=cpzsgwok"), ttl = 14400 }
    30 = { type = "TXT", host = "", val = format("\"%s\"", "v=spf1 include:spf.migadu.com -all"), ttl = 14400 }
    40 = { type = "TXT", host = "_dmarc", val = format("\"%s\"", "v=DMARC1; p=reject;"), ttl = 14400 }
  }
  domain = vultr_dns_domain.dtkerr_ca.id
  type   = each.value.type

  name = each.value.host
  data = each.value.val
  ttl  = each.value.ttl
}
