#!/bin/sh

export PATH=/app/node-v8.11.4-linux-x64/bin/:$PATH 

qemu-system-x86_64 -nographic -net nic,vlan=0 -net user,hostfwd=tcp:127.0.0.1:8888-:22 -m 512 -hda /app/ssh_and_ss/tc/tc.img < /dev/null &

cd /app && npm install && /app/node-v8.11.4-linux-x64/bin/node app.js -p $PORT
