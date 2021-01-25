FILESEXTRAPATHS_prepend_kudo := "${THISDIR}/${PN}:"

SRC_URI_append_kudo = " file://power-config-host0.json"

FILES_${PN} += " ${datadir}/x86-power-control/power-config-host0.json \"

do_install_append_kudo() {
    install -d ${D}${datadir}/x86-power-control
    install -m 0755 ${WORKDIR}/power-config-host0.json \
        ${D}${datadir}/x86-power-control/power-config-host0.json
}
