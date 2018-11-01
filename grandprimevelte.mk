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

# IDC
#PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/usr/idc/Synaptics_HID_TouchPad.idc:system/usr/idc/Synaptics_HID_TouchPad.idc \
    $(LOCAL_PATH)/usr/idc/elan-ts.idc:system/usr/idc/elan-ts.idc \
    $(LOCAL_PATH)/usr/idc/ft5306-ts.idc:system/usr/idc/ft5306-ts.idc \
    $(LOCAL_PATH)/usr/idc/msg2133.idc:system/usr/idc/msg2133.idc \
    $(LOCAL_PATH)/usr/idc/synaptics_dsx_i2c.idc:system/usr/idc/synaptics_dsx_i2c.idc

# Keylayouts
#PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/usr/keylayout/AVRCP.kl:system/usr/keylayout/AVRCP.kl \
    $(LOCAL_PATH)/usr/keylayout/Generic.kl:system/usr/keylayout/Generic.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_0079_Product_0011.kl:system/usr/keylayout/Vendor_0079_Product_0011.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_028e.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_0461_Product_4dfc.kl:system/usr/keylayout/Vendor_0461_Product_4dfc.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_046d_Product_b32f.kl:system/usr/keylayout/Vendor_046d_Product_b32f.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_046d_Product_b330.kl:system/usr/keylayout/Vendor_046d_Product_b330.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_046d_Product_b331.kl:system/usr/keylayout/Vendor_046d_Product_b331.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_046d_Product_b332.kl:system/usr/keylayout/Vendor_046d_Product_b332.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_046d_Product_b343.kl:system/usr/keylayout/Vendor_046d_Product_b343.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_046d_Product_b344.kl:system/usr/keylayout/Vendor_046d_Product_b344.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_046d_Product_b501.kl:system/usr/keylayout/Vendor_046d_Product_b501.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_046d_Product_c216.kl:system/usr/keylayout/Vendor_046d_Product_c216.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_046d_Product_c219.kl:system/usr/keylayout/Vendor_046d_Product_c219.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_046d_Product_c21d.kl:system/usr/keylayout/Vendor_046d_Product_c21d.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_046d_Product_c21f.kl:system/usr/keylayout/Vendor_046d_Product_c21f.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_046d_Product_c294.kl:system/usr/keylayout/Vendor_046d_Product_c294.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_046d_Product_c299.kl:system/usr/keylayout/Vendor_046d_Product_c299.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_046d_Product_c532.kl:system/usr/keylayout/Vendor_046d_Product_c532.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_04e8_Product_7021.kl:system/usr/keylayout/Vendor_04e8_Product_7021.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_04e8_Product_a000.kl:system/usr/keylayout/Vendor_04e8_Product_a000.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_04e8_Product_a005.kl:system/usr/keylayout/Vendor_04e8_Product_a005.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_04e8_Product_a006.kl:system/usr/keylayout/Vendor_04e8_Product_a006.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_054c_Product_0268.kl:system/usr/keylayout/Vendor_054c_Product_0268.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_0583_Product_2060.kl:system/usr/keylayout/Vendor_0583_Product_2060.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_05ac_Product_0239.kl:system/usr/keylayout/Vendor_05ac_Product_0239.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_05ac_Product_0255.kl:system/usr/keylayout/Vendor_05ac_Product_0255.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_0b05_Product_4500.kl:system/usr/keylayout/Vendor_0b05_Product_4500.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_1038_Product_1412.kl:system/usr/keylayout/Vendor_1038_Product_1412.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_12bd_Product_d015.kl:system/usr/keylayout/Vendor_12bd_Product_d015.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_1532_Product_0900.kl:system/usr/keylayout/Vendor_1532_Product_0900.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_1689_Product_fd00.kl:system/usr/keylayout/Vendor_1689_Product_fd00.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_1689_Product_fd01.kl:system/usr/keylayout/Vendor_1689_Product_fd01.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_1689_Product_fe00.kl:system/usr/keylayout/Vendor_1689_Product_fe00.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_18d1_Product_2c40.kl:system/usr/keylayout/Vendor_18d1_Product_2c40.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_1949_Product_0401.kl:system/usr/keylayout/Vendor_1949_Product_0401.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_1bad_Product_f016.kl:system/usr/keylayout/Vendor_1bad_Product_f016.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_1bad_Product_f023.kl:system/usr/keylayout/Vendor_1bad_Product_f023.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_1bad_Product_f027.kl:system/usr/keylayout/Vendor_1bad_Product_f027.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_1bad_Product_f036.kl:system/usr/keylayout/Vendor_1bad_Product_f036.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_1d79_Product_0009.kl:system/usr/keylayout/Vendor_1d79_Product_0009.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_22b8_Product_093d.kl:system/usr/keylayout/Vendor_22b8_Product_093d.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_2378_Product_1008.kl:system/usr/keylayout/Vendor_2378_Product_1008.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_2378_Product_100a.kl:system/usr/keylayout/Vendor_2378_Product_100a.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_2943_Product_0020.kl:system/usr/keylayout/Vendor_2943_Product_0020.kl \
    $(LOCAL_PATH)/usr/keylayout/pxa27x-keypad.kl:system/usr/keylayout/pxa27x-keypad.kl \
    $(LOCAL_PATH)/usr/keylayout/qwerty.kl:system/usr/keylayout/qwerty.kl

# Permissions
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/permissions/allshare_library.xml:system/etc/permissions/allshare_library.xml \
    $(LOCAL_PATH)/configs/permissions/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    $(LOCAL_PATH)/configs/permissions/android.hardware.nfc.hce.xml:system/etc/permissions/android.hardware.nfc.hce.xml \
    $(LOCAL_PATH)/configs/permissions/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
    $(LOCAL_PATH)/configs/permissions/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    $(LOCAL_PATH)/configs/permissions/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    $(LOCAL_PATH)/configs/permissions/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    $(LOCAL_PATH)/configs/permissions/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    $(LOCAL_PATH)/configs/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    $(LOCAL_PATH)/configs/permissions/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    $(LOCAL_PATH)/configs/permissions/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    $(LOCAL_PATH)/configs/permissions/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml \
    $(LOCAL_PATH)/configs/permissions/com.broadcom.bt.xml:system/etc/permissions/com.broadcom.bt.xml \
    $(LOCAL_PATH)/configs/permissions/com.broadcom.nfc.xml:system/etc/permissions/com.broadcom.nfc.xml \
    $(LOCAL_PATH)/configs/permissions/com.google.android.maps.xml:system/etc/permissions/com.google.android.maps.xml \
    $(LOCAL_PATH)/configs/permissions/com.google.android.media.effects.xml:system/etc/permissions/com.google.android.media.effects.xml \
    $(LOCAL_PATH)/configs/permissions/com.google.widevine.software.drm.xml:system/etc/permissions/com.google.widevine.software.drm.xml \
    $(LOCAL_PATH)/configs/permissions/com.gsma.services.nfc.xml:system/etc/permissions/com.gsma.services.nfc.xml \
    $(LOCAL_PATH)/configs/permissions/com.marvell.atclient.xml:system/etc/permissions/com.marvell.atclient.xml \
    $(LOCAL_PATH)/configs/permissions/com.marvell.fmmanager.xml:system/etc/permissions/com.marvell.fmmanager.xml \
    $(LOCAL_PATH)/configs/permissions/com.samsung.bbc.xml:system/etc/permissions/com.samsung.bbc.xml \
    $(LOCAL_PATH)/configs/permissions/com.samsung.device.xml:system/etc/permissions/com.samsung.device.xml \
    $(LOCAL_PATH)/configs/permissions/com.sec.feature.call_vt_support.xml:system/etc/permissions/com.sec.feature.call_vt_support.xml \
    $(LOCAL_PATH)/configs/permissions/com.sec.smartcard.auth.xml:system/etc/permissions/com.sec.smartcard.auth.xml \
    $(LOCAL_PATH)/configs/permissions/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    $(LOCAL_PATH)/configs/permissions/hw-features.xml:system/etc/permissions/hw-features.xml \
    $(LOCAL_PATH)/configs/permissions/imsmanager_library.xml:system/etc/permissions/imsmanager_library.xml \
    $(LOCAL_PATH)/configs/permissions/org.simalliance.openmobileapi.xml:system/etc/permissions/org.simalliance.openmobileapi.xml \
    $(LOCAL_PATH)/configs/permissions/rcsopenapi_library.xml:system/etc/permissions/rcsopenapi_library.xml \
    $(LOCAL_PATH)/configs/permissions/sec_edm.xml:system/etc/permissions/sec_edm.xml \
    $(LOCAL_PATH)/configs/permissions/sec_mdm.xml:system/etc/permissions/sec_mdm.xml \
    $(LOCAL_PATH)/configs/permissions/sec_platform_library.xml:system/etc/permissions/sec_platform_library.xml \
    $(LOCAL_PATH)/configs/permissions/seccamera.xml:system/etc/permissions/seccamera.xml \
    $(LOCAL_PATH)/configs/permissions/secimaging.xml:system/etc/permissions/secimaging.xml \
    $(LOCAL_PATH)/configs/permissions/secmediarecorder.xml:system/etc/permissions/secmediarecorder.xml \
    $(LOCAL_PATH)/configs/permissions/secvisualeffect.xml:system/etc/permissions/secvisualeffect.xml \
    $(LOCAL_PATH)/configs/permissions/sw-features.xml:system/etc/permissions/sw-features.xml \
    $(LOCAL_PATH)/configs/permissions/touchwiz.xml:system/etc/permissions/touchwiz.xml \
    $(LOCAL_PATH)/configs/permissions/vtmanager_library.xml:system/etc/permissions/vtmanager_library.xml

ifneq ($(TARGET_BUILD_VARIANT),user) 
ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.secure=0 \
    ro.adb.secure=0 \
    ro.debuggable=1 \
    sys.usb.config=mtp,adb \
    persist.service.adb.enable=1 \
    persist.sys.usb.config=mtp,adb \
    service.adb.root=1
endif

# Ramdisk
#PRODUCT_PACKAGES += \
#    init.tel.rc \
#    init.wifi.rc \
#    init_bsp.rc \
#    init.container.rc \
#    fstab.pxa1908 \
#    fstab_lpm.pxa1908 \
#    init.pxa1908.tel.rc \
#    init_bsp.pxa1908.tel.rc \
#    init_bsp.pxa1908.rc \
#    init.pxa1908.security.rc \
#    init.pxa1908.sensor.rc \
#    ueventd.rc	


# Inherit from 
$(call inherit-product, device/samsung/pxa1908-common/pxa1908-common.mk)
