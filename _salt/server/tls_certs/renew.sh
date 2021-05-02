#!/bin/bash
IFS=$'\n'

printf "renewing for\n"
{%- for cert in pillar.tls_certs %}
printf "* {{ cert.domain }} with aliases [{{ cert.aliases | join(", ") }}]\n"
{%- endfor %}

need_reload=0
errors=()
{% for cert in pillar.tls_certs %}
output=$(uacme --confdir /etc/acme \
    --hook /var/lib/acme/dns-01_hook.sh --type EC \
    issue {{ cert.domain }} {{ cert.aliases | join(" ") }} 2>&1)
if [[ "$?" == "0" ]]; then
    need_reload=1
fi
if [[ "$output" != "" ]]; then
    errors+=($output)
fi
{% endfor %}

if [[ "$need_reload" == "1" ]]; then
    echo "reloading nginx..."
    sudo /usr/bin/systemdctl reload nginx
fi
if [[ "${{ '{#' }}errors[@]}" != "0" ]]; then
    for error in ${errors[@]}; do
        echo $error
    done
    exit 1
else
    exit 0
fi
