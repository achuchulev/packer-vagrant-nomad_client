#!/bin/bash

mkdir -p /etc/nomad.d
chmod a+w /etc/nomad.d

mkdir -p /opt/nomad

cat <<EOF > /etc/nomad.d/client.hcl

data_dir  = "/opt/nomad"

bind_addr = "0.0.0.0"

# Enable the client
client {
  enabled = true
  servers = ["192.168.10.11", "192.168.10.12", "192.168.10.13"]

  options = {
    "driver.raw_exec" = "1"
    "driver.raw_exec.enable" = "1"
  }
}
EOF