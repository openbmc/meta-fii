FILESEXTRAPATHS_prepend_kudo := "${THISDIR}/linux-nuvoton:"

SRC_URI_append_kudo = " file://kudo.cfg"
SRC_URI_append_kudo = " file://0001-Ampere-Altra-MAX-SMpro-hwmon-driver.patch"
SRC_URI_append_kudo = " file://0002-Ampere-Altra-MAX-SSIF-IPMI-driver.patch"
SRC_URI_append_kudo = " file://0003-Support-Hwmon-ADM1266-Driver.patch"

