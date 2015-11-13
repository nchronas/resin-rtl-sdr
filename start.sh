#!/bin/bash
#Set the root password as root if not set as an ENV variable
export PASSWD=${PASSWD:=root}
#Set the root password
echo "root:$PASSWD" | chpasswd

echo "Hello"

udevd --daemon
udevadm trigger

if [ ! -c /dev/fb1 ]; then
  echo "loading piTFT kernel module"
  modprobe spi-bcm2708
  modprobe fbtft_device name=pitft verbose=0 rotate=270

  sleep 1

  mknod /dev/fb1 c $(cat /sys/class/graphics/fb1/dev | tr ':' ' ')
fi

sleep 2