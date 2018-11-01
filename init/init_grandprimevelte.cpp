/*
   Copyright (c) 2016, The Linux Foundation. All rights reserved.
   Copyright (c) 2017-2018, The LineageOS Project. All rights reserved.
   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are
   met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of The Linux Foundation nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.
   THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
   WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
   ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
   BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
   BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
   WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
   OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
   IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include <cutils/properties.h>

#include "vendor_init.h"
#include "property_service.h"
#include "log.h"
#include "util.h"

#include "init_pxa1908.h"

enum
{
	G531F,
	NONE
};

int get_device_variant(const char* bootloader)
{
	if( strstr(bootloader,"SM-G531F") != NULL )
		return G531F;

	return NONE;
}

void set_rild_libpath(char const *variant)
{
    char libpath[512];

    strcpy(libpath, "/system/lib/libsec-ril");
    strcat(libpath, variant);
    strcat(libpath,".so");
    property_override("rild.libpath", libpath);
}

void cdma_properties(char const *operator_alpha,
        char const *operator_numeric,
        char const *default_network,
        char const *rild_lib_variant)
{
    /* Dynamic CDMA Properties */
    property_set("ro.cdma.home.operator.alpha", operator_alpha);
    property_set("ro.cdma.home.operator.numeric", operator_numeric);
    property_set("ro.telephony.default_network", default_network);
    set_rild_libpath(rild_lib_variant);

    /* Static CDMA Properties */
    property_set("ril.subscription.types", "NV,RUIM");
    property_set("ro.telephony.default_cdma_sub", "0");
    property_set("telephony.lteOnCdmaDevice", "1");
}

void lte_properties(char const *rild_lib_variant)
{
    set_rild_libpath(rild_lib_variant);

    property_set("ro.telephony.default_network", "9");
    property_set("telephony.lteOnGsmDevice", "1");
}

void gsm_properties(char const *rild_lib_variant)
{
    set_rild_libpath(rild_lib_variant);

    property_set("ro.telephony.default_network", "3");
    property_set("telephony.lteOnCdmaDevice", "0");
}

void init_target_properties()
{
    char platform[PROPERTY_VALUE_MAX];
    property_get("ro.board.platform", platform);
    if ( strstr(platform,ANDROID_TARGET) == NULL )
        return;

    char bootloader[PROPERTY_VALUE_MAX];
    property_get("ro.bootloader", bootloader);

    switch(get_device_variant(bootloader))
    {
        case G531F:
            property_override("ro.build.fingerprint", "samsung/grandprimeveltexx/grandprimevelte:5.1.1/LMY48B/G531FXXU1APG2:user/release-keys");
            property_override("ro.build.description", "grandprimeveltexx-user 5.1.1 LMY48B G531FXXU1APG2 release-keys");
            property_override("ro.product.model", "SM-G531F");
            property_override("ro.product.device", "grandprimevelte");
            property_override("ro.telephony.ril_class", "SamsungMRVLRIL");
            lte_properties("");
            break;
        default:
	    break;
    }

    char device[PROPERTY_VALUE_MAX];
    property_get("ro.product.device", device);
    INFO("Found bootloader id %s setting build properties for %s device\n", bootloader, device);
}
