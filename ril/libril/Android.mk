# Copyright 2006 The Android Open Source Project

LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_C_INCLUDES += 

LOCAL_SRC_FILES:= \
    ril.cpp \
    ril_event.cpp

LOCAL_SHARED_LIBRARIES := \
    liblog \
    libutils \
    libbinder \
    libcutils \
    libhardware_legacy \
    librilutils

#LOCAL_CFLAGS := -DANDROID_MULTI_SIM -DDSDA_RILD1
ifneq ($(ANDROID_MULTI_SIM),)
LOCAL_CFLAGS += -DANDROID_MULTI_SIM
endif

LOCAL_CFLAGS += -g

ifeq ($(SIM_COUNT), 2)
    LOCAL_CFLAGS += -DANDROID_SIM_COUNT_2
endif
ifeq ($(SIM_COUNT), 3)
    LOCAL_CFLAGS += -DANDROID_SIM_COUNT_3
endif
ifeq ($(SIM_COUNT), 4)
    LOCAL_CFLAGS += -DANDROID_SIM_COUNT_4
endif

LOCAL_MODULE:= libril

include $(BUILD_SHARED_LIBRARY)


# For RdoServD which needs a static library
# =========================================
ifneq ($(ANDROID_BIONIC_TRANSITION),)
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
    ril.cpp

LOCAL_STATIC_LIBRARIES := \
    libutils_static \
    libcutils \
    librilutils_static

LOCAL_CFLAGS :=

LOCAL_MODULE:= libril_static

include $(BUILD_STATIC_LIBRARY)
endif # ANDROID_BIONIC_TRANSITION
