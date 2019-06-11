#!/bin/bash

mkdir -p /etc/nomad.d
chmod a+w /etc/nomad.d

mkdir -p /opt/nomad

cat <<EOF > /etc/nomad.d/client.hcl

data_dir  = "/opt/nomad"

advertise {
  rpc = "{{ GetInterfaceIP \"eth0\" }}"
  http = "{{ GetInterfaceIP \"eth0\" }}"
  serf = "{{ GetInterfaceIP \"eth0\" }}"
}

# Enable the client
client {
  enabled = true
  servers = ["192.168.10.11:4647", "192.168.10.12:4647", "192.168.10.13:4647"]

  options = {
    "driver.raw_exec" = "1"
    "driver.raw_exec.enable" = "1"
  }
}
EOF