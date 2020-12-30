FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " file://kudo.json"

do_install_append () {
        install -m 0644 -D ${WORKDIR}/kudo.json ${D}/usr/share/entity-manager/configurations/kudo.json
}
