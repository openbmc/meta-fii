FILESEXTRAPATHS_prepend_kudo := "${THISDIR}/linux-nuvoton:"

SRC_URI_append_kudo = " file://kudo.cfg"
SRC_URI_append_kudo = " file://arch"
SRC_URI_append_kudo = " file://0001-Ampere-Altra-MAX-SMpro-hwmon-driver.patch"
SRC_URI_append_kudo = " file://0002-Ampere-Altra-MAX-SSIF-IPMI-driver.patch"

# Merge source tree by original project with our layer of additional files
do_patch_append_kudo () {
    cp -r "${WORKDIR}/arch" \
          "${STAGING_KERNEL_DIR}"
}

