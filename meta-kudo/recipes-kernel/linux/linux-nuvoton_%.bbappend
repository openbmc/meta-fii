FILESEXTRAPATHS_prepend_kudo := "${THISDIR}/linux-nuvoton:"

SRC_URI_append_kudo = " file://kudo.cfg"
SRC_URI_append_kudo = " \
  file://0001-dts-nuvoton-add-kudo-support.patch \
	file://0002-dtsiwq-nuvoton-common-update.patch \
	file://0003-modify-mtd-spi-nor-fix-for-mx66l51235f.patch \
	file://0004-npcm_7xx-EMC-driver.patch \
  "
