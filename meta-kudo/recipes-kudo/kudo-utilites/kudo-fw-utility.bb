SUMMARY = "Phosphor OpenBMC Kudo Firmware Upgrade Command"
DESCRIPTION = "Phosphor OpenBMC Kudo Firmware Upgrade Comman Daemon"
FILESEXTRAPATHS_prepend := "${THISDIR}/kudo-fw-utility:"

PR = "r1"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

inherit systemd
inherit obmc-phosphor-systemd

DEPENDS += "systemd"
DEPENDS += "phosphor-ipmi-flash"
RDEPENDS_${PN} += "libsystemd"
RDEPENDS_${PN} += "bash"

FILES_${PN} += "${datadir}/phosphor-ipmi-flash/config-bmc.json"
FILES_${PN} += "${datadir}/phosphor-ipmi-flash/config-bios.json"
FILES_${PN} += "${datadir}/phosphor-ipmi-flash/config-bmccpld.json"
FILES_${PN} += "${datadir}/phosphor-ipmi-flash/config-mbcpld.json"
FILES_${PN} += "${datadir}/phosphor-ipmi-flash/config-scp.json"
FILES_${PN} += "${datadir}/phosphor-ipmi-flash/config-scpback.json"

SRC_URI_append_kudo = " \ 
	file://kudo-fw.sh \
	file://phosphor-ipmi-flash-bios-update.service \
	file://phosphor-ipmi-flash-bmccpld-update.service \
	file://phosphor-ipmi-flash-mbcpld-update.service \
	file://phosphor-ipmi-flash-scp-update.service \
	file://phosphor-ipmi-flash-scpback-update.service \
	file://config-bios.json \
	file://config-bmc.json \
	file://config-bmccpld.json \
	file://config-mbcpld.json \
	file://config-scp.json \
	file://config-scpback.json \
	"

SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN}_append_kudo = " \
	phosphor-ipmi-flash-bios-update.service \
	phosphor-ipmi-flash-bmccpld-update.service \
        phosphor-ipmi-flash-mbcpld-update.service \
	phosphor-ipmi-flash-scp-update.service \ 
	phosphor-ipmi-flash-scpback-update.service \
	"

do_install () {
	install -d ${D}/${sbindir}
	install -m 0755 ${WORKDIR}/kudo-fw.sh ${D}/${sbindir}/kudo-fw.sh

	install -d ${D}${datadir}/phosphor-ipmi-flash
        install -m 0644 ${WORKDIR}/config-bmc.json ${D}${datadir}/phosphor-ipmi-flash
        install -m 0644 ${WORKDIR}/config-bios.json ${D}${datadir}/phosphor-ipmi-flash
        install -m 0644 ${WORKDIR}/config-bmccpld.json ${D}${datadir}/phosphor-ipmi-flash
        install -m 0644 ${WORKDIR}/config-mbcpld.json ${D}${datadir}/phosphor-ipmi-flash
        install -m 0644 ${WORKDIR}/config-scp.json ${D}${datadir}/phosphor-ipmi-flash
        install -m 0644 ${WORKDIR}/config-scpback.json ${D}${datadir}/phosphor-ipmi-flash

        install -d ${D}${systemd_system_unitdir}
        install -m 0644 ${WORKDIR}/phosphor-ipmi-flash-bios-update.service  ${D}${systemd_system_unitdir}
	install -m 0644 ${WORKDIR}/phosphor-ipmi-flash-bmccpld-update.service ${D}${systemd_system_unitdir}
        install -m 0644 ${WORKDIR}/phosphor-ipmi-flash-mbcpld-update.service ${D}${systemd_system_unitdir}
        install -m 0644 ${WORKDIR}/phosphor-ipmi-flash-scp-update.service ${D}${systemd_system_unitdir}
        install -m 0644 ${WORKDIR}/phosphor-ipmi-flash-scpback-update.service ${D}${systemd_system_unitdir}
}
