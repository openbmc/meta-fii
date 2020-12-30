FILESEXTRAPATHS_prepend_kudo := "${THISDIR}/${PN}:"
SRC_URI_append_kudo = " file://config.json"
SRC_URI_append_kudo = " file://phosphor-pid-control.service"

FILES_${PN}_append_kudo = " ${datadir}/swampd/config.json"

inherit systemd

SYSTEMD_SERVICE_${PN}_append_kudo = " phosphor-pid-control.service"

do_install_append_kudo() {
    install -d ${D}${datadir}/swampd
    install -m 0644 -D ${WORKDIR}/config.json \
        ${D}${datadir}/swampd/config.json

    install -d ${D}${systemd_unitdir}/system/
    install -m 0644 ${WORKDIR}/phosphor-pid-control.service \
        ${D}${systemd_unitdir}/system
}
