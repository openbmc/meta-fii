SUMMARY = "OpenBMC for kudo system - Applications"
PR = "r1"

inherit packagegroup
inherit obmc-phosphor-utils

PROVIDES = "${PACKAGES}"
PACKAGES = " \
	${PN}-kudo-chassis \
	${PN}-kudo-system \
	"

PROVIDES += "virtual/obmc-chassis-mgmt"
PROVIDES += "virtual/obmc-system-mgmt"

RPROVIDES_${PN}-kudo-chassis += "virtual-obmc-chassis-mgmt"
RPROVIDES_${PN}-kudo-system += "virtual-obmc-system-mgmt"

SUMMARY_${PN}-kudo-chassis = "Kudo Chassis"
RDEPENDS_${PN}-kudo-chassis = " \
        obmc-phosphor-buttons-signals \
        obmc-phosphor-buttons-handler \
	phosphor-hostlogger \
	phosphor-sel-logger \
	phosphor-logging \
        "

SUMMARY_${PN}-kudo-system = "kudo System"
RDEPENDS_${PN}-kudo-system = " \
	ipmitool \
	google-ipmi-sys \
	google-ipmi-i2c \
	phosphor-ipmi-flash \
	phosphor-host-postd \
	obmc-console \
	kudo-boot \
	kudo-initialize \
	kudo-fw-utility \
	"
