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

# Overlay
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

# Proprietary files
$(call inherit-product, vendor/samsung/grandprimevelte/grandprimevelte-vendor.mk)


ifneq ($(TARGET_BUILD_VARIANT),user) 
ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.secure=0 \
    ro.adb.secure=0 \
    ro.debuggable=1 \
    persist.service.adb.enable=1 \
    persist.sys.usb.config=mtp,adb \
    service.adb.root=1
endif

# Ramdisk
PRODUCT_PACKAGES += \
    fstab.pxa1908 \
    fstab_lpm.pxa1908 \
    init.target.rc \
    init.trace.rc \
    init.tel.rc \
    init.pxa1908.tel.rc \
    init.pxa1908.security.rc \
    init.wifi.rc \
    init_bsp.pxa1908.tel.rc \
    init.usb.rc \
    init_bsp.pxa1908.rc \
    init_bsp.rc \
    init.pxa1908.usb.rc \
    init.container.rc \
    init.pxa1908.sensor.rc \
    init.pxa1908.rc \
    ueventd.pxa1908.rc \
    ueventd.rc	

# Inherit from 
$(call inherit-product, device/samsung/pxa1908-common/pxa1908-common.mk)
