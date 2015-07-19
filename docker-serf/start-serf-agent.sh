#!/bin/bash

service dnsmasq start

SERF_CONFIG_DIR=/etc/serf

# if JOIN_IP env variable set generate a config json for serf
[[ -n $JOIN_IP ]] && cat > $SERF_CONFIG_DIR/join.json <<EOF
{
  "start_join" : ["$JOIN_IP"]
}
EOF

#serf agent -rpc-addr=$(hostname -i):7373 -bind=$(hostname -i) -event-handler=/etc/serf-events.sh -node=$(hostname -f) "$JOIN_OPTS"
#[[ -n $JOIN_IP ]] && JOIN_OPTS="-join=$JOIN_IP"
#serf agent -rpc-addr=0.0.0.0:7373 "$JOIN_OPTS"

cat > $SERF_CONFIG_DIR/node.json <<EOF
{
  "node_name" : "$(hostname -f)"
}
EOF

[[ -n $TUTUM_SERVICE_HOSTNAME ]] && cat > $SERF_CONFIG_DIR/serf-config.json <<EOF
{
  "event_handlers": ["/etc/serf/event-router.sh"],
  "rpc_addr": "0.0.0.0:7373",
  "profile": "wan"
  "interface" : "ethwe"
}
EOF

# if JOIN_IP env variable set generate a config json for serf
[[ -n $SLAVE1_HDFS_LOCAL_PORT_9000_TCP_ADDR ]] && cat > $SERF_CONFIG_DIR/join.json <<EOF
{
  "start_join" : ["$SLAVE1_HDFS_LOCAL_PORT_9000_TCP_ADDR"]
}
EOF


/bin/serf agent -config-dir $SERF_CONFIG_DIR
