FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://Kudo.json"

do_install_append () {
        install -m 0644 -D ${WORKDIR}/Kudo.json ${D}/usr/share/entity-manager/configurations/Kudo.json
}
