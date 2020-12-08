SUMMARY = "YAML configuration for Kudo"
PR = "r1"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

inherit allarch

SRC_URI = " \
	file://kudo-ipmi-fru.yaml \
	file://ipmi-sensors-kudo.yaml \
	"

S = "${WORKDIR}"

do_install() {
	install -m 0644 -D kudo-ipmi-fru.yaml \
		${D}${datadir}/${BPN}/ipmi-fru-read.yaml

	install -m 0644 -D ipmi-sensors-kudo.yaml \
		 ${D}${datadir}/${BPN}/ipmi-sensors-kudo.yaml
}

FILES_${PN}-dev = " \
	${datadir}/${BPN}/ipmi-fru-read.yaml \
	${datadir}/${BPN}/ipmi-sensors-kudo.yaml \
	"

ALLOW_EMPTY_${PN} = "1"
