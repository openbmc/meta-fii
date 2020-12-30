FILESEXTRAPATHS_append_kudo := "${THISDIR}/${PN}:"

EXTRA_OECONF_append_kudo = " --enable-negative-errno-on-fail"

ITEMS = " \
        i2c@81000/i2c-switch@75/i2c@2/max31790@2c \ 
        i2c@81000/i2c-switch@75/i2c@3/max31790@2c \
        i2c@81000/i2c-switch@75/i2c@6/lm75@5c \
        i2c@81000/i2c-switch@75/i2c@7/lm75@5c \
        i2c@81000/i2c-switch@75/i2c@4/lm75@5c \
        i2c@81000/i2c-switch@75/i2c@5/lm75@5c \
        i2c@81000/i2c-switch@77/i2c@2/pmbus@74 \
        i2c@82000/smpro@4e \
        i2c@82000/smpro@4f \ 
        i2c@84000/i2c-switch@77/i2c@0/adm1266@40 \
        i2c@84000/i2c-switch@77/i2c@0/adm1266@41 \ 
        i2c@8d000/i2c-switch@77/i2c@2/lm75@48 \
        i2c@8d000/i2c-switch@77/i2c@3/lm75@49 \
        i2c@8d000/i2c-switch@77/i2c@4/lm75@48 \
        i2c@8d000/i2c-switch@77/i2c@5/lm75@49 \
        i2c@8e000/max34451@59 \
        "
         
ITEMSFMT = "obmc/hwmon/ahb/apb/{0}.conf"

SYSTEMD_ENVIRONMENT_FILE_${PN}_append_kudo = " ${@compose_list(d, 'ITEMSFMT', 'ITEMS')}"