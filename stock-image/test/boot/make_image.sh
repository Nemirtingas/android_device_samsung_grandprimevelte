#! /bin/bash

OUT_DIR=/tmp
IMAGE=boot.img
KERNEL="Image.gz"
RAMDISK_ROOT="boot"
UBOOT="${IMAGE}-zImage"
RAMDISK="${IMAGE}-ramdisk.gz"
DTBIMAGE="${IMAGE}-dtb"
SIGNATURE="${IMAGE}-signature"
ARGS=()

echo "Making uBoot..."
mkimage -A arm64 -O linux -T kernel -C gzip -a 01000000 -e 01000000 -n "pxa1928dkb linux" -d "${KERNEL}" "${UBOOT}"
echo "Uboot done !"

echo "Making ramdisk..."
mkbootfs "${RAMDISK_ROOT}" | minigzip >"${RAMDISK}"
echo "Ramdisk done !"

echo "Making $OUT_DIR/$IMAGE"

ARGS+=("--kernel"    "${UBOOT}")
ARGS+=("--ramdisk"   "${RAMDISK}")
ARGS+=("--base"      "0x10000000")
ARGS+=("--pagesize"  "2048")
ARGS+=("--dt"        "${DTBIMAGE}")
#ARGS+=("--signature" "${SIGNATURE}")
ARGS+=("--unknown"   "0x3000000")
echo "mkbootimg-pxa ${ARGS[@]} --output ${OUT_DIR}/${IMAGE}"
mkbootimg-pxa "${ARGS[@]}" --output "${OUT_DIR}/${IMAGE}"
echo "$OUT_DIR/$IMAGE done !"
