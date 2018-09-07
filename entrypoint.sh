#!/bin/sh

qemu-system-x86_64 -nographic -net nic,vlan=0 -net user -m 512 -hda /app/ssh_and_ss/tc/tc.img < /dev/null &

cd /app && npm install && node app.js -p 3000
