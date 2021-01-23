SUMMARY = "Phosphor OpenBMC Kudo Initialize Progress"
DESCRIPTION = "Phosphor OpenBMC Kudo Initialize Progress Daemon"
FILESEXTRAPATHS_prepend := "${THISDIR}/kudo-initialize:"

PR = "r1"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

inherit systemd
inherit obmc-phosphor-systemd

DEPENDS += "systemd"
RDEPENDS_${PN} += "libsystemd"
RDEPENDS_${PN} += "bash"

SRC_URI_append_kudo += " \ 
	file://mac_ctrl.sh \
	file://fw_compatible.sh \
	file://initialize.service \
	"

SYSTEMD_PACKAGES = "${PN}"
FILES_${PN} = " \
	${sbindir}/mac_ctrl.sh \
	${sbindir}/fw_compatible.sh \
	"

SYSTEMD_SERVICE_${PN}_append_kudo = " initialize.service"

do_install () {

	install -d ${D}/${sbindir}
	install -m 0755 ${WORKDIR}/mac_ctrl.sh ${D}/${sbindir}/mac_ctrl.sh
	install -m 0755 ${WORKDIR}/fw_compatible.sh ${D}/${sbindir}/fw_compatible.sh

	install -d ${D}${systemd_unitdir}/system/
	install -m 0644 ${WORKDIR}/initialize.service ${D}${systemd_unitdir}/system
}
