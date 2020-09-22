FILESEXTRAPATHS_prepend_kudo := "${THISDIR}/linux-nuvoton:"

SRC_URI_append_kudo = " file://kudo.cfg"
SRC_URI_append_kudo = " file://arch"

# Merge source tree by original project with our layer of additional files
do_patch_append_kudo () {
    cp -r "${WORKDIR}/arch" \
          "${STAGING_KERNEL_DIR}"
}

