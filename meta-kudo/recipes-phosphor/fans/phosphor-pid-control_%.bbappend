FILESEXTRAPATHS_prepend_kudo := "${THISDIR}/${PN}:"
SRC_URI_append_kudo = " file://config.json"
SRC_URI_append_kudo = " file://fan-default-speed.sh"
SRC_URI_append_kudo = " file://phosphor-pid-control.service"
SRC_URI_append_kudo = " file://fan-reboot-control.service"
SRC_URI_append_kudo = " file://fan-boot-control.service"

FILES_${PN}_append_kudo = " ${datadir}/swampd/config.json"
FILES_${PN}_append_kudo = " ${bindir}/fan-default-speed.sh"

inherit systemd
RDEPENDS_${PN} += "bash"

SYSTEMD_SERVICE_${PN}_append_kudo = " phosphor-pid-control.service"
SYSTEMD_SERVICE_${PN}_append_kudo = " fan-reboot-control.service"
SYSTEMD_SERVICE_${PN}_append_kudo = " fan-boot-control.service"

do_install_append_kudo() {
    install -d ${D}/${bindir}
    install -m 0755 ${WORKDIR}/fan-default-speed.sh ${D}/${bindir}

    install -d ${D}${datadir}/swampd
    install -m 0644 -D ${WORKDIR}/config.json \
        ${D}${datadir}/swampd/config.json

    install -d ${D}${systemd_unitdir}/system/
    install -m 0644 ${WORKDIR}/phosphor-pid-control.service \
        ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/fan-reboot-control.service \
        ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/fan-boot-control.service \
        ${D}${systemd_unitdir}/system
}
