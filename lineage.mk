# Copyright (C) 2016 The Android OpenSource Project
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

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit from the common Open Source product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit device configuration
$(call inherit-product, device/samsung/grandprimevelte/grandprimevelte.mk)

# Release name
PRODUCT_RELEASE_NAME := SM-G531F

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := grandprimevelte
PRODUCT_NAME := lineage_grandprimevelte
PRODUCT_BRAND := samsung
PRODUCT_MODEL := SM-G531F
PRODUCT_MANUFACTURER := samsung
