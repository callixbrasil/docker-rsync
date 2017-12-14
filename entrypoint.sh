#!/bin/sh

VOLUME_NAME=${VOLUME_NAME:-volume}
ALLOW=${ALLOW:-192.168.0.0/16 172.16.0.0/12}
USER=${USER:-nobody}
GROUP=${GROUP:-nogroup}

cat <<EOF > /etc/rsyncd.conf
uid = ${USER}
gid = ${GROUP}
use chroot = yes
log file = /dev/stdout
reverse lookup = no
[${VOLUME_NAME}]
    hosts deny = *
    hosts allow = ${ALLOW}
    read only = false
    path = /volume
    comment = docker volume
EOF

exec /usr/bin/rsync --no-detach --daemon --config /etc/rsyncd.conf
