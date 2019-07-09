#!/bin/bash

# output: $OUT/u-boot-dtb-{sha}.bin 

set -e

SCRIPT_DIR=$(dirname "$0")
SCRIPT_NAME=$(basename "$0")
ECHO="echo $SCRIPT_NAME:"

# dependencies
$SCRIPT_DIR/fetch-uboot.sh

source $SCRIPT_DIR/main.env
source $UBOOT_ENV

if [ -f $OUT/$UBOOT_BIN ]; then
  $ECHO "$UBOOT_BIN is update-to-date, skip building"
  exit 0
fi 

TMPDIR=tmp/u-boot-$UBOOT_SHA

rm -rf $TMPDIR
unzip -q $OUT/$UBOOT_ZIP -d tmp

make -C $TMPDIR ARCH=arm CROSS_COMPILE=aarch64-linux-gnu- rk3328-backus_defconfig
make -C $TMPDIR ARCH=arm CROSS_COMPILE=aarch64-linux-gnu- -j8

mkdir -p $OUT/tools

cp $TMPDIR/u-boot-dtb.bin $OUT/$UBOOT_BIN

cp $TMPDIR/tools/boot_merger $OUT/tools
cp $TMPDIR/tools/loaderimage $OUT/tools
cp $TMPDIR/tools/mkimage $OUT/tools
cp $TMPDIR/tools/trust_merger $OUT/tools

