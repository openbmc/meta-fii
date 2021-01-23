#!/bin/bash

for i in {1..6};
do
    echo 1 > /sys/class/hwmon/hwmon4/pwm${i}_enable
    echo 155 > /sys/class/hwmon/hwmon4/pwm${i}
done

