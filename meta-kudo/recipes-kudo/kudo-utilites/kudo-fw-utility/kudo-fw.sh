#!/bin/bash

# set_gpio_ctrl
# pin #, direction, high(1)/low(0)
function set_gpio_ctrl() {
  echo $1 > /sys/class/gpio/export
  echo $2 > /sys/class//gpio/gpio$1/direction
  echo $3 > /sys/class/gpio/gpio$1/value
  echo $1 > /sys/class/gpio/unexport
  sleep 1
}

function fwbios() {
  KERNEL_FIU_ID="f0200000.spi"
  KERNEL_SYSFS_FIU="/sys/bus/platform/drivers/npcm-pspi"

  # switch the SPI mux from Host to BMC
  i2cset -y -f -a 13 0x76 0x10 0x01

  # rescan the spi bus
  if [ -d "${KERNEL_SYSFS_FIU}/${KERNEL_FIU_ID}" ]; then
    echo "${KERNEL_FIU_ID}" > "${KERNEL_SYSFS_FIU}"/unbind
    sleep 1
    echo "${KERNEL_FIU_ID}" > "${KERNEL_SYSFS_FIU}"/bind
  fi

  # write to the mtd device
  BIOS_MTD=$(cat /proc/mtd | grep "bios" | sed -n 's/^\(.*\):.*/\1/p')

  if [ ! -f $1 ]; then
    echo " Cannot find the" $1 "image file"
    exit 1
  fi  

  echo "turning chassis off"
  obmcutil chassisoff
  sleep 20

  echo "Flashing BIOS @/dev/$BIOS_MTD"
  flashcp -v $1 /dev/$BIOS_MTD
  wait

  # switch the SPI mux from BMC to Host
  if [ -d "${KERNEL_SYSFS_FIU}/${KERNEL_FIU_ID}" ]; then
    echo "${KERNEL_FIU_ID}" > "${KERNEL_SYSFS_FIU}"/unbind
  fi
  i2cset -y -f -a 13 0x76 0x10 0x00
  rm -f $1
}

function fwbmccpld() {
  # BMC_JTAG_MUX_1 #218 0:BMC 1:MB
  set_gpio_ctrl 218 out 0
  loadsvf -d /dev/jtag0 -s $1 -m 1
  wait
  set_gpio_ctrl 218 out 1
  rm -f $1
}

function fwmbcpld() {
  # JTAG_TMS_BMC_MUX #16 0:Mux 1:CPU
  # BMC_JTAG_SEL #164 0:BMC 1:CPU
  set_gpio_ctrl 16 out 1
  set_gpio_ctrl 164 out 1
  loadsvf -d /dev/jtag0 -s $1 -m 1
  wait
  set_gpio_ctrl 164 out 0
  rm -f $1
}

function fwscp() {
  # BMC_I2C_BACKUP_SEL #168 0:failover, 1:main
  # BMC_CPU_EEPROM_I2C_SEL #85 0:BMC, 1:CPU
  set_gpio_ctrl 168 out 1
  set_gpio_ctrl 85 out 0
  I2C_BUS_DEV=$(ls -l $devpath/"13-0077" | grep channel-0 | awk '{ print $11}' | cut -c 8-)
  ampere_eeprom_prog -b $I2C_BUS_DEV -s 0x50 -p -f $1
  wait
  set_gpio_ctrl 85 out 1
  set_gpio_ctrl 168 out 1
  rm -f $1
}

function fwscpback() {
  # BMC_I2C_BACKUP_SEL #168 0:failover, 1:main
  # BMC_CPU_EEPROM_I2C_SEL #85 0:BMC, 1:CPU
  set_gpio_ctrl 168 out 0
  set_gpio_ctrl 85 out 0
  I2C_BUS_DEV=$(ls -l $devpath/"13-0077" | grep channel-0 | awk '{ print $11}' | cut -c 8-)
  ampere_eeprom_prog -b $I2C_BUS_DEV -s 0x50 -p -f $1
  wait
  set_gpio_ctrl 85 out 1
  set_gpio_ctrl 168 out 1
  rm -f $1
}

case $1 in
  bios)
    fwbios $2
    ;;
  bmccpld)
    fwbmccpld $2
    ;;
  mbcpld)
    fwmbcpld $2
    ;;
  scp)
    fwscp $2
    ;;
  scpback)
    fwscpback $2
    ;;
  *)
    ;;
esac
