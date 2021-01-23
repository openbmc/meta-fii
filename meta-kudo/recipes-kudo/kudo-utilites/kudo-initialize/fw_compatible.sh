#!/bin/bash
fw=0
run=0
if [ -f "/home/root/fw" ]; then
  fw=1
fi

reva="v00.03.svf"
revm="v00.05.svf"
# Check the Agora CPLD
#str="Conan_Agora_CPLD_v00.03.svf"
#cmd="5: 0x02 0x00 0x00 0x04 0x00"
str=$(ls /home/root/ | grep Agora)
cmd=$(i2cget -y -f -a 13 0x76 0x00 i 5)
file="/home/root/"$str
CPLDID=$(echo $cmd | cut -d ' ' -f 2)
rev=$(printf "v%02X.%02X.svf" "$(echo $cmd | cut -d ' ' -f 6)" "$(echo $cmd | cut -d ' ' -f 5)")
filerev=$(echo $str | cut -d '_' -f 4)

#echo $rev
#echo $filerev
#echo $file
if [ $fw -eq 1 ]; then
  if [ ${rev} != ${reva} ]; then
    echo "Agora CPLD didn't match!!! " ${rev} ":"  ${reva} > /dev/ttyS0
  fi
elif [ ${rev} != ${filerev} ]; then
  #echo "Updating the BMC CPLD !!!" > /dev/ttyS0
  gpioset 6 26=0
#  loadsvf -d /dev/jtag0 -s $file -m 1
  gpioset 6 26=1
  run=1
fi

# Check the Mobo CPLD
#str="Conan_MB_CPLD_v00.03.svf"
#cmd="5: 0x02 0x00 0x00 0x05 0x00"
str=$(ls /home/root/ | grep MB)
cmd=$(i2cget -y -a -f 26 0x76 0x00 i 5)
file="/home/root/"$str
CPLDID=$(echo $cmd | cut -d ' ' -f 2)
rev=$(printf "v%02X.%02X.svf" "$(echo $cmd | cut -d ' ' -f 6)" "$(echo $cmd | cut -d ' ' -f 5)")
filerev=$(echo $str | cut -d '_' -f 4)

if [ $fw -eq 1 ]; then
  if [ ${rev} != ${revm} ]; then
    echo "Mobo CPLD didn't match!!! " ${rev} ":"  ${revm} > /dev/ttyS0
  fi
elif [ ${rev} != ${filerev} ]; then
  #echo "Updating the MB CPLD !!!" > /dev/ttyS0
  gpioset 0 16=1
  gpioset 5 4=1
#  loadsvf -d /dev/jtag0 -s $file -m 1
  gpioset 5 4=0
  run=1
fi

# doing node hotswap
if [ $fw -eq 1 ]; then
  exit 1
fi

if [ $run -eq 1 ]; then
  echo "Finished update CPLD and power cycle node!!!" > /devttyS0
  touch /home/root/fw
  sleep 1
  gpioset 2 30=1
fi
