#!/bin/bash

# set_gpio_ctrl
# pin #, direction, high(1)/low(0)
function set_gpio_ctrl() {
  echo $1 > /sys/class/gpio/export
  echo $2 > /sys/class//gpio/gpio$1/direction
  echo $3 > /sys/class/gpio/gpio$1/value
#  echo $1 > /sys/class/gpio/unexport
}
# MON_BMC_ALIVE, GPIO 10
set_gpio_ctrl 10 out 1

# S0_BMC_OK, GPIO 69
set_gpio_ctrl 69 out 1

# BMC_S0_SYSRESET_N, GPIO 65 
set_gpio_ctrl 65 out 1

# BMC_S1_SYSRESET_N, GPIO 127
set_gpio_ctrl 127 out 1
