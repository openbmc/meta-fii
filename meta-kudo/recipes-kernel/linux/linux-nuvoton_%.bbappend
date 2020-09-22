FILESEXTRAPATHS_prepend_kudo := "${THISDIR}/linux-nuvoton:"

LINUX_VERSION = "5.8.8"
SRCREV="${AUTOREV}"

SRC_URI_append_kudo = " file://kudo.cfg"
SRC_URI_append_kudo = " file://arch"

# Merge source tree by original project with our layer of additional files
do_add_vesnin_files () {
    cp -r "${WORKDIR}/arch" \
          "${STAGING_KERNEL_DIR}"
}
addtask do_add_vesnin_files after do_kernel_checkout before do_patch

