FILESEXTRAPATHS_append_kudo := "${THISDIR}/${PN}:"

DEPENDS_append_kudo = " kudo-yaml-config"

RRECOMMENDS_${PN} += "ipmitool"

EXTRA_OECONF_kudo = " \
	FRU_YAML_GEN=${STAGING_DIR_HOST}${datadir}/kudo-yaml-config/ipmi-fru-read.yaml \
	SENSOR_YAML_GEN=${STAGING_DIR_HOST}${datadir}/kudo-yaml-config/ipmi-sensors-kudo.yaml \
	"

do_install_append_kudo(){
	install -d ${D}${includedir}/phosphor-ipmi-host
	install -m 0644 -D ${S}/sensorhandler.hpp ${D}${includedir}/phosphor-ipmi-host
	install -m 0644 -D ${S}/selutility.hpp ${D}${includedir}/phosphor-ipmi-host
}
