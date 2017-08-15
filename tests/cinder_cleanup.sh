#!/bin/bash

set -x

sudo mysql -u root << EOF
DROP DATABASE cinder;
EOF

# Clean up the cinder volume group and file-based loopback device
sudo lvremove -f cinder-volumes
sudo vgremove -f cinder-volumes
loop_dev=$(sudo losetup -j /var/cinder/cinder-volumes-file | awk -F':' '/'cinder-volumes-file'/ { print $1}')
[ -n $loop_dev ] || sudo losetup -d $loop_dev
[ -e /var/cinder/cinder-volumes-file ] && sudo rm /var/cinder/cinder-volumes-file
