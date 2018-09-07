#!/bin/sh

qemu-system-x86_64 -nographic -net nic,vlan=0 -net user,hostfwd=tcp:127.0.0.1:8888-:22 -m 256 -hda /app/tc.img < /dev/null &

env | grep -v 'HOME\|PWD\|PATH' | while read env; do echo "export $env" >> /home/term/.bashrc ; done && \
  node /opt/wetty/app.js -p 3000
