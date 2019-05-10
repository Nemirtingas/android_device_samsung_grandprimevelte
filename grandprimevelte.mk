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
    fstab.pxa1908 \
    fstab_lpm.pxa1908

# Wifi
PRODUCT_PACKAGES += \
    p2p_supplicant_overlay.conf \
    wpa_supplicant_overlay.conf \
    wpa_supplicant.conf

# I want busybox :)
PRODUCT_PACKAGES += busybox

ifneq ($(TARGET_BUILD_VARIANT),user) 
ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.secure=0 \
    ro.adb.secure=0
endif

# Inherit from 
$(call inherit-product, device/samsung/pxa1908-common/pxa1908-common.mk)
$(call inherit-product, vendor/nemirtingas/common_board.mk)
