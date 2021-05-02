#!/bin/bash
# https://github.com/ndilieto/uacme/blob/master/uacme.sh
ARGS=5
E_BADARGS=85
ZONE_ID="8567a108e77cc81d7cba602ee9499f4a"

if test $# -ne "$ARGS"; then
    echo "Usage: $(basename "$0") method type ident token auth" 1>&2
    exit $E_BADARGS
fi

METHOD=$1
TYPE=$2
IDENT=$3
TOKEN=$4
AUTH=$5

if [ "$TYPE" != "dns-01" ]; then
    echo "only dns-01 challenge type is supported" 1>&2
    exit 1
fi

source ~/dns_api_token

mkdir -p /tmp/acme

RECORD_NAME="$IDENT.acme"

case "$METHOD" in
    "begin")
        echo "creating *.acme.oefd.net record..."
        curl -X POST "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records" \
            -H "Authorization: Bearer $DNS_API_TOKEN" \
            -H "Content-Type: application/json" \
            --data '{"type": "TXT", "name": "'$RECORD_NAME'", "content": "'$AUTH'", "ttl": 120}' > /tmp/acme/$IDENT.response 2>/dev/null
        if [[ "$?" != "0" ]]; then
            exit $?
        fi

        echo "waiting for dns propagation..."
        sleep 5
        for i in $(seq 30); do
            txt="$(dig @major.ns.cloudflare.com +short TXT $IDENT.acme.oefd.net)"
            for record in $txt; do
                if [[ "$record" == "$AUTH" ]]; then
                    echo "found expected challenge value"
                    exit 0
                fi
                if [[ "$record" == "\"$AUTH\"" ]]; then
                    echo "found expected challenge value"
                    exit 0
                fi
            done
            echo "waiting a bit longer..."
            sleep 10
        done
        echo "unable to find expected challenge value"
        exit 1
        ;;
    "done"|"failed")
        record_id=$(cat /tmp/acme/$IDENT.response | jq ".result.id" | cut -d'"' -f2)
        echo "cleanup up of *.acme.oefd.net record for $record_id..."
        curl -X DELETE "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$record_id" \
            -H "Authorization: Bearer $DNS_API_TOKEN" 2>/dev/null
        exit $?
        ;;
esac
