# Copyright (C) 2015 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Inherit from pxa1908-common
-include device/samsung/pxa1908-common/BoardConfigCommon.mk

# inherit from the proprietary version
#-include vendor/samsung/grandprimevelte/BoardConfigVendor.mk

DEVICE_PATH := device/samsung/grandprimevelte

TARGET_OTA_ASSERT_DEVICE := grandprimevelte

# Init
TARGET_LIBINIT_PXA1908_DEFINES_FILE := $(DEVICE_PATH)/init/init_grandprimevelte.cpp
TARGET_UNIFIED_DEVICE := true

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop

# Kernel
TARGET_KERNEL_SOURCE := kernel/samsung/grandprimevelte
#TARGET_KERNEL_CONFIG := cm_grandprimevelte_defconfig
TARGET_KERNEL_CONFIG := pxa1908_grandprimevelte_eur_defconfig
TARGET_KERNEL_ARCH := arm64
#TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_KERNEL_CROSS_COMPILE_PREFIX := aarch64-linux-android-
KERNEL_TOOLCHAIN := $(ANDROID_BUILD_TOP)/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/

BOARD_KERNEL_BASE         := 0x10000000
BOARD_KERNEL_CMDLINE      :=
BOARD_KERNEL_PAGESIZE     := 2048
BOARD_KERNEL_SEPARATED_DT := true
BOARD_KERNEL_IMAGE_NAME   := Image.gz
BOARD_DTBTOOL_ARGS        :=
BOARD_MKBOOTIMG_ARGS      := --signature device/samsung/grandprimevelte/boot.img-signature --unknown 0x3000000 --tags_offset 0x00000100
BOARD_MKRECOVERYIMG_ARGS  := --signature device/samsung/grandprimevelte/recovery.img-signature --unknown 0x3000000 --tags_offset 0x00000100
BOARD_UBOOT_ARGS          := -A arm64 -O linux -T kernel -C gzip -a 01000000 -e 01000000 -n "pxa1928dkb linux"
INSTALLED_UBOOT_TARGET    := uKernel

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE     := 16777216
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 16777216
BOARD_SYSTEMIMAGE_PARTITION_SIZE   := 1932525568
BOARD_USERDATAIMAGE_PARTITION_SIZE := 5518655488
BOARD_FLASH_BLOCK_SIZE             := 131072

# Filesystems
TARGET_USERIMAGES_USE_EXT4         := true
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE  := ext4

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.pxa1908

# TWRP Recovery
RECOVERY_VARIANT := twrp
TW_THEME := portrait_mdpi
PRODUCT_COPY_FILES += $(DEVICE_PATH)/twrp.fstab:recovery/root/etc/twrp.fstab
