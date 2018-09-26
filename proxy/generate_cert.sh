#!/bin/sh

: ${DOMAIN:=example.com}
: ${COUNTRY:=JP}
: ${STATE:=Tokyo}
: ${LOCALITY:=Chiyoda-ku}
: ${ORGANIZATIONAL_NAME:=Company}
: ${ORGANIZATIONAL_UNIT:=Section}

if [ -s ${DOMAIN}.crt ] && [ -s ${DOMAIN}.csr ] && [ -s ${DOMAIN}.key ] && [ -s ${DOMAIN}_dhparam.pem ]; then
    echo "Skipping SSL certificate generation: ${DOMAIN}"
else
    echo "Generating self-signed certificate: ${DOMAIN}"
    echo subjectAltName=DNS:${DOMAIN},DNS:*.${DOMAIN} > ${DOMAIN}_san.ext
    openssl genrsa -out ${DOMAIN}.key 2048
    openssl req -new -key ${DOMAIN}.key -out ${DOMAIN}.csr -subj "/C=${COUNTRY}/ST=${STATE}/L=${LOCALITY}/O=${ORGANIZATIONAL_NAME}/OU=${ORGANIZATIONAL_UNIT}/CN=${DOMAIN}"
    openssl x509 -in ${DOMAIN}.csr -days 36500 -req -signkey ${DOMAIN}.key -out ${DOMAIN}.crt -extfile ${DOMAIN}_san.ext
    openssl dhparam -out ${DOMAIN}_dhparam.pem 2048
fi
