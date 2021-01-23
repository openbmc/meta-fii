#!/bin/bash

#str="0000004b  01 23 45 67 89 ab 03 ff  ff ff ff ff ff ff ff ff  |.#Eg............|"
str=$(hexdump -s 0x4B -n 6 -C /sys/bus/i2c/devices/14-0055/eeprom | grep 004b)

for i in {2..7}
do
  tmp=$(echo $str | cut -d ' ' -f $i)
  mac=$mac$tmp
done

mac0=$mac
mac1=$(printf "%lx" "$((16#${mac}+1))")
#mac2=$(echo "obase=16;$((16#${mac}+1))"|bc)
#if [ $(echo `expr length $mac2`) -lt 16 ]
if [ $(echo ${#mac1}) -lt 12 ]; then
  mac1='0'$mac1
fi

for i in {0..5}
do
#  tmp0=${mac1:$(echo `expr $i \* 2`):2}
#  tmp1=${mac2:$(echo `expr $i \* 2`):2}
  tmp0=${mac0:$[ $i * 2 ]:2}
  tmp1=${mac1:$[ $i * 2 ]:2}
  if [ $i -eq 0 ]; then
    eth0mac=$tmp0
    eth1mac=$tmp1
  else
    eth0mac=$eth0mac:$tmp0
    eth1mac=$eth1mac:$tmp1
  fi
done


#echo "====== MAC0 initial ======" $eth0mac > /dev/ttyS0
ip link set eth0 down
sleep 1
ip link set eth0 address $eth0mac
sleep 1
ip link set eth0 up
sleep 2
udhcpc -i eth0 -n
#echo "====== MAC1 initial ======" $eth1mac > /dev/ttyS0
sleep 1
ip link set eth1 down
sleep 1
ip link set eth1 address $eth1mac
sleep 1
ip link set eth1 up
sleep 2
udhcpc -i eth1 -n
#echo "====== MAC Finished ======" > /dev/ttyS0

echo "====================" > /dev/ttyS0
echo "===  IP address  ===" > /dev/ttyS0
cmd=$(ip address | grep "eth1" | grep "global" | cut -d '/' -f 1 | tr -s ' ' | cut -d ' ' -f 3)
echo " IP Address : " ${cmd} > /dev/ttyS0

cmd=$(kudo.sh fw ver)
echo "===   Version    ===" > /dev/ttyS0
echo ${cmd} > /dev/ttyS0
echo "====================" > /dev/ttyS0
