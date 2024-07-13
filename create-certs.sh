#!/bin/bash

# Set variables
DOMAIN="localhost"
COUNTRY="ID"
STATE="West Java"
LOCALITY="Bandung"
ORGANIZATION="My Company"
ORGANIZATIONAL_UNIT="IT Department"
EMAIL="admin@example.com"
DAYS_VALID=365
SSL_DIR="ssl"

# Create private key in PEM format
openssl genrsa -out $SSL_DIR/key.pem 2048

# Create Certificate Signing Request (CSR)
openssl req -new -key $SSL_DIR/key.pem -out $SSL_DIR/csr.pem -subj "/C=$COUNTRY/ST=$STATE/L=$LOCALITY/O=$ORGANIZATION/OU=$ORGANIZATIONAL_UNIT/CN=$DOMAIN/emailAddress=$EMAIL"

# Create self-signed certificate in PEM format
openssl x509 -req -days $DAYS_VALID -in $SSL_DIR/csr.pem -signkey $SSL_DIR/key.pem -out $SSL_DIR/cert.pem

# Create a single PEM file containing both the certificate and the key
cat $SSL_DIR/cert.pem $SSL_DIR/key.pem > $SSL_DIR/fullchain.pem

echo "TLS certificate and key created successfully in PEM format!"
echo "Private Key: $SSL_DIR/key.pem"
echo "Certificate: $SSL_DIR/cert.pem"
echo "CSR: $SSL_DIR/csr.pem"
echo "Full Chain (cert + key): $SSL_DIR/fullchain.pem"
