#!/bin/bash
#
# create_crt_key.sh <wildcard dns name>
#
# creates the encrypted data bag secret
# creates a key and certificate
# adds them to a local encrypted data bag
#

set -e

export LANG="en_US.UTF-8"

pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null

if [ $# -eq 0 ]; then
    echo "Usage: create_crt_key.sh <wildcard dns name>"
    exit 1;
fi

knifeflags="-z"

name=$1

country="CA"
state="British Columbia"
company=""
city="Vancouver"
organiztion=""
email=""


# Generate a passphrase
export PASSPHRASE=$(head -c 500 /dev/urandom | LC_CTYPE=C tr -dc "a-z0-9A-Z" | head -c 128; echo)

# Certificate details; replace items in angle brackets with your own info
subj="
C=$country
ST=$state
O=$company
localityName=$city
commonName=*.$name
organizationalUnitName=$organization
emailAddress=$email
"

unencrypted_path="test/integration/unencrypted"
encrypted_path="test/integration/default"

if [ ! -f $encrypted_path/encrypted_data_bag_secret ]; then
  openssl rand -base64 512 | tr -d '\r\n' > $encrypted_path/encrypted_data_bag_secret
fi

if [ ! -f ${name}.key ] || [ ! -f ${name}.crt ]; then
  openssl genrsa -out ${name}.key -passout env:PASSPHRASE 2048
  openssl req -new -subj "$(echo -n "$subj" | tr "\n" "/")" -key "${name}.key" -out "${name}.csr" -passin env:PASSPHRASE
  cp ${name}.key ${name}.key.org
  openssl rsa -in ${name}.key.org -out ${name}.key -passin env:PASSPHRASE
  openssl x509 -req -days 3650 -in "${name}.csr" -signkey "${name}.key" -out "${name}.crt"
fi

CERT=`cat ${name}.crt | sed 's/$/\\\\n/' | tr -d '\n'`
KEY=`cat ${name}.key | sed 's/$/\\\\n/' | tr -d '\n'`

if [ ! -d $unencrypted_path/data_bags/certificates ]; then
  mkdir -p $unencrypted_path/data_bags/certificates
fi

cat <<EOT > $unencrypted_path/data_bags/certificates/${name}.json
{
  "id": "$name",
  "key": "$KEY",
  "cert": "$CERT"
}
EOT

cd $encrypted_path
if [ ! -d data_bags/certificates ]; then
  knife data bag create certificates -z
fi
knife data bag from file certificates $SCRIPTPATH/$unencrypted_path/data_bags/certificates/${name}.json --secret-file encrypted_data_bag_secret -z
cd $SCRIPTPATH

rm ${name}.key ${name}.key.org ${name}.csr ${name}.crt

