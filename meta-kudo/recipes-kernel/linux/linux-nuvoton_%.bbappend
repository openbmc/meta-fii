FILESEXTRAPATHS_prepend_kudo := "${THISDIR}/linux-nuvoton:"

LINUX_VERSION = "5.8.8"
SRCREV="9dfd247baa45a6f0e148cfde11526de2ca9f9dce"

SRC_URI_append_kudo = " file://kudo.cfg"
SRC_URI_append_kudo = " file://arch"
SRC_URI_append_kudo = " file://0001-Add-DIMM-G0-and-DIMM-G1-features-to-Smpmpro-hwmon-dr.patch"

# Merge source tree by original project with our layer of additional files
do_add_vesnin_files () {
    cp -r "${WORKDIR}/arch" \
          "${STAGING_KERNEL_DIR}"
}
addtask do_add_vesnin_files after do_kernel_checkout before do_patch

