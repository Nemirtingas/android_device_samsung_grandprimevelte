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

# Audio Configs
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/audio/audio_swvol_element.xml:system/etc/audio_swvol_element.xml \
    $(LOCAL_PATH)/configs/audio/audio_basic_element_codec.xml:system/etc/audio_basic_element_codec.xml \
    $(LOCAL_PATH)/configs/audio/audio_basic_element_apu.xml:system/etc/audio_basic_element_apu.xml \
    $(LOCAL_PATH)/configs/audio/platform_audio_config.xml:system/etc/platform_audio_config.xml \
    $(LOCAL_PATH)/configs/audio/audio_virtualpath_config.xml:system/etc/audio_virtualpath_config.xml \
    $(LOCAL_PATH)/configs/audio/audio_path_config_apu.xml:system/etc/audio_path_config_apu.xml \
    $(LOCAL_PATH)/configs/audio/audio_path_config_codec.xml:system/etc/audio_path_config_codec.xml \
    $(LOCAL_PATH)/configs/audio/audio_gain_config.xml:system/etc/audio_gain_config.xml \
    $(LOCAL_PATH)/configs/audio/audio_policy.conf:system/etc/audio_policy.conf

# Media
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/media/media_profiles.xml:system/etc/media_profiles.xml

# Ramdisk
PRODUCT_PACKAGES += \
    init.tel.rc \
    init.wifi.rc \
    init.container.rc \
    init_bsp.pxa1908.rc \
    init_bsp.pxa1908.tel.rc \
    init_bsp.rc \
    fstab.pxa1908 \
    fstab_lpm.pxa1908

# Wifi
PRODUCT_PACKAGES += \
    p2p_supplicant_overlay.conf \
    wpa_supplicant_overlay.conf \
    wpa_supplicant.conf

ifneq ($(TARGET_BUILD_VARIANT),user) 
ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.secure=0 \
    ro.adb.secure=0
endif

# Inherit from 
$(call inherit-product, device/samsung/pxa1908-common/pxa1908-common.mk)

# Permissions
#PRODUCT_COPY_FILES += \
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

