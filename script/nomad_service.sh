#!/bin/bash

cat <<EOF > /etc/systemd/system/nomad.service

[Unit]
Description=Nomad
Documentation=https://nomadproject.io/docs/
Wants=network-online.target
After=network-online.target

# If you are running Consul, please uncomment following Wants/After configs.
# Assuming your Consul service unit name is "consul"
# Wants=consul.service
# After=consul.service

[Service]
KillMode=process
KillSignal=SIGINT
ExecStart=/usr/bin/nomad agent -config=/etc/nomad.d/
ExecReload=/bin/kill -HUP $MAINPID
Restart=on-failure
RestartSec=2
StartLimitBurst=3
StartLimitIntervalSec=10
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF

# Enable & start nomad service
systemctl enable nomad.service

# Enable Nomad's CLI command autocomplete support
nomad -autocomplete-install