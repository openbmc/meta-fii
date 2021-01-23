FILESEXTRAPATHS_prepend_kudo := "${THISDIR}/linux-nuvoton:"

SRC_URI_append_kudo = " \
	file://kudo.cfg \
	file://0001-Ampere-Altra-MAX-SMpro-hwmon-driver.patch \
	file://0002-Ampere-Altra-MAX-SSIF-IPMI-driver.patch \
	file://0003-Support-Hwmon-ADM1266-Driver.patch \
	file://0005-Add-Support-for-nuvoton-jtag-master-npcm-7xx-jtag-ma.patch \
	"
