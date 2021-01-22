FILESEXTRAPATHS_prepend_kudo := "${THISDIR}/linux-nuvoton:"

SRC_URI_append_kudo = " \
	file://kudo.cfg \
	file://0001-Ampere-Altra-MAX-SMpro-hwmon-RAS-bootpost-driver.patch \
	"
