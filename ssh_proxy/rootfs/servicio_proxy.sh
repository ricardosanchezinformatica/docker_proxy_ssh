#!/bin/ash

# generate host keys if not present
#ssh-keygen -A

exec ssh -i ~/.ssh/id_rsa -N -D 0.0.0.0:443 localhost
