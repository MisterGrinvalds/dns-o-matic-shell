source .env


urlencode() {
    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf "$c" ;;
            *) printf '%%%02X' "'$c" ;;
        esac
    done
}

USER=$(urlencode "$USER")
PASSWORD=$(urlencode "$PASSWORD")
HOST=$(urlencode "$HOST")
DOMAIN=$(urlencode "$DOMAIN")
IP=$(dig @resolver1.opendns.com myip.opendns.com +short)


curl "http://$USER:$PASSWORD@updates.dnsomatic.com/nic/update?myip=$IP&wildcard=NOCHG&mx=NOCHG&backmx=NOCHG"
