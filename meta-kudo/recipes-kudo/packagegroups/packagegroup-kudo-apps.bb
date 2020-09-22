SUMMARY = "OpenBMC for KUDO system - Applications"
PR = "r1"

inherit packagegroup

PROVIDES = "${PACKAGES}"
PACKAGES = " \
     ${PN}-kudo-system \
     ${PN}-kudo-common-utils \
     "

SUMMARY_${PN}-kudo-common-utils = "KUDO common utils"
RDEPENDS_${PN}-kudo-common-utils = " \
    ipmitool \
    phosphor-webui \
    phosphor-host-postd \
    loadsvf \
    "

SUMMARY_${PN}-kudo-system = "KUDO System"
RDEPENDS_${PN}-kudo-system = " \
    dhcpcd \
    phosphor-sel-logger \
    "

