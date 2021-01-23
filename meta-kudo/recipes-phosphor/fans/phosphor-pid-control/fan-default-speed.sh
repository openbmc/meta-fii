#!/bin/bash

for i in {1..6};
do
  echo  1 > /sys/devices/platform/ahb/ahb:apb/f0081000.i2c/i2c-1/i2c-18/18-002c/hwmon/*/pwm${i}_enable
  echo 210 > /sys/devices/platform/ahb/ahb:apb/f0081000.i2c/i2c-1/i2c-18/18-002c/hwmon/*/pwm${i}
done

