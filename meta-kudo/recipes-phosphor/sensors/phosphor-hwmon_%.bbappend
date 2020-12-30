FILESEXTRAPATHS_append_kudo := "${THISDIR}/${PN}:"

EXTRA_OECONF_append_kudo = " --enable-negative-errno-on-fail"


CHIPS = " \
        i2c-bus@8d000/i2c-switch@77/i2c@3/lm75@28 \
        i2c-bus@8d000/i2c-switch@77/i2c@4/lm75@29 \
        i2c-bus@8d000/i2c-switch@77/i2c@5/lm75@28 \
        i2c-bus@8d000/i2c-switch@77/i2c@6/lm75@29 \
         "
CHIPS += " \
        i2c-bus@81000/i2c-switch@75/i2c@6/lm75@5c \
        i2c-bus@81000/i2c-switch@75/i2c@7/lm75@5c \
        i2c-bus@81000/i2c-switch@75/i2c@4/lm75@5c \
        i2c-bus@81000/i2c-switch@75/i2c@5/lm75@5c \
        i2c-bus@81000/i2c-switch@77/i2c@2/pmbus@74 \
        i2c-bus@84000/i2c-switch@77/i2c@0/adm1266@40 \
        i2c-bus@84000/i2c-switch@77/i2c@1/adm1266@41 \
        "
CHIPS += " \
        i2c-bus@82000/smpro@4f \
        i2c-bus@82000/smpro@4e \
        "
CHIPS += "i2c-bus@81000/i2c-switch@75/i2c@2/max31790@58"
CHIPS += "i2c-bus@81000/i2c-switch@75/i2c@3/max31790@58"

ITEMSFMT = "ahb/apb/{0}.conf"

ITEMS = "${@compose_list(d, 'ITEMSFMT', 'CHIPS')}"

ENVS = "obmc/hwmon/{0}"
SYSTEMD_ENVIRONMENT_FILE_${PN}_append_kudo = " ${@compose_list(d, 'ENVS', 'ITEMS')}"

do_install_append_kudo() {
  SOURCEDIR="${WORKDIR}/obmc/hwmon"
  DESTDIR="${D}${sysconfdir}/default/obmc"
  install -d ${DESTDIR}
  cp -r ${SOURCEDIR} ${DESTDIR}
}
