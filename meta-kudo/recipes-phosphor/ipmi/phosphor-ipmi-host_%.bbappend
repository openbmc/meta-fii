FILESEXTRAPATHS_append_kudo := "${THISDIR}/${PN}:"

DEPENDS_append_kudo = " kudo-yaml-config"

RRECOMMENDS_${PN} += "ipmitool"

EXTRA_OECONF_kudo = " \
	SENSOR_YAML_GEN=${STAGING_DIR_HOST}${datadir}/kudo-yaml-config/ipmi-sensors.yaml \
	"
