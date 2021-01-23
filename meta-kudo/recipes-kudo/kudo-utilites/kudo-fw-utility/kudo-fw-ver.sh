#!/bin/bash

BMC_CPLD_VER_FILE="/run/cpld0.version"
MB_CPLD_VER_FILE="/run/cpld1.version"
ver=''

function fw_rev() {
  case $1 in
    cpldb)
      cmd=$(i2cget -y -f -a 13 0x76 0x00 i 5)
      ver=$(printf "%02X.%02X.%02X.%02X" "$(echo $cmd | cut -d ' ' -f 6)" "$(echo $cmd | cut -d ' ' -f 5)" \
            "$(echo $cmd | cut -d ' ' -f 4)" "$(echo $cmd | cut -d ' ' -f 3)")
      ;;
    cpldm)
      cmd=$(i2cget -y -a -f 26 0x76 0x00 i 5)
      ver=$(printf "%02X.%02X.%02X.%02X" "$(echo $cmd | cut -d ' ' -f 6)" "$(echo $cmd | cut -d ' ' -f 5)" \
            "$(echo $cmd | cut -d ' ' -f 4)" "$(echo $cmd | cut -d ' ' -f 3)")
      ;;
    *)
      ;;
  esac
}


fw_rev cpldb
echo "BMC CPLD version : ${ver}"
echo "${ver}" > "${BMC_CPLD_VER_FILE}"
fw_rev cpldm
echo "MB CPLD version  : ${ver}"
echo "${ver}" > "${MB_CPLD_VER_FILE}"
