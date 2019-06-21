#!/usr/bin/env bash

echo "Installing Nomad..."

# Define Nomad releases URL
release='https://releases.hashicorp.com/nomad/index.json'

# Export the higher version of Nomad product
NOMAD_VERSION=`curl -sL $release | jq -r '.versions | to_entries[] | .value.version' | sort --version-sort | grep -v 'ent|beta|rc|alpha' | tail -1`

cd /tmp/
curl -sSL https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip -o nomad.zip
unzip nomad.zip
install nomad /usr/bin/nomad