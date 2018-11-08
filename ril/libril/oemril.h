/*
 * Copyright (C) 2006 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef OEM_RIL_H
#define OEM_RIL_H

#include <hardware_legacy/power.h>
//////////////////////////////////////////
// Oem structures

struct CallDetails
{
  int32_t call_type;
  int32_t call_domain;
  int32_t num_strings;
  int32_t z;
  char **getCsvFromExtras;
};

struct RIL_OEMCallArgs
{
    int32_t *x;
    CallDetails *callDetails;
};
/////////////////////////////////////

#include "../include/telephony/ril.h"
#include <telephony/ril_cdma_sms.h>
#include <cutils/sockets.h>
#include <cutils/jstring.h>
#include <telephony/record_stream.h>
#include <utils/Log.h>
#include <utils/SystemClock.h>
#include <pthread.h>
#include <binder/Parcel.h>
#include <cutils/jstring.h>

#include <sys/types.h>
#include <sys/limits.h>
#include <pwd.h>

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <time.h>
#include <errno.h>
#include <assert.h>
#include <ctype.h>
#include <alloca.h>
#include <sys/un.h>
#include <assert.h>
#include <netinet/in.h>
#include <cutils/properties.h>

#include <ril_event.h>

#define OEM_SOL_BASE 10000

#define RIL_SAMSUNG_REQUEST_DIAL_EMERGENCY_CALL                10001
#define RIL_SAMSUNG_REQUEST_CALL_DEFLECTION                    10002
#define RIL_SAMSUNG_REQUEST_MODIFY_CALL_INITIATE               10003
#define RIL_SAMSUNG_REQUEST_MODIFY_CALL_CONFIRM                10004
#define RIL_SAMSUNG_REQUEST_SET_VOICE_DOMAIN_PREF              10005
#define RIL_SAMSUNG_REQUEST_SAFE_MODE                          10006
#define RIL_SAMSUNG_REQUEST_SET_TRANSMIT_POWER                 10007
#define RIL_SAMSUNG_REQUEST_GET_CELL_BROADCAST_CONFIG          10008
#define RIL_SAMSUNG_REQUEST_GET_PHONEBOOK_STORAGE_INFO         10009
#define RIL_SAMSUNG_REQUEST_GET_PHONEBOOK_ENTRY                10010
#define RIL_SAMSUNG_REQUEST_ACCESS_PHONEBOOK_ENTRY             10011
#define RIL_SAMSUNG_REQUEST_USIM_PB_CAPA                       10012
#define RIL_SAMSUNG_REQUEST_LOCK_INFO                          10013
#define RIL_SAMSUNG_REQUEST_STK_SIM_INIT_EVENT                 10014
#define RIL_SAMSUNG_REQUEST_SET_PREFERRED_NETWORK_LIST         10015
#define RIL_SAMSUNG_REQUEST_GET_PREFERRED_NETWORK_LIST         10016
#define RIL_SAMSUNG_REQUEST_CHANGE_SIM_PERSO                   10017
#define RIL_SAMSUNG_REQUEST_ENTER_SIM_PERSO                    10018
#define RIL_SAMSUNG_REQUEST_SEND_ENCODED_USSD                  10019
#define RIL_SAMSUNG_REQUEST_CDMA_SEND_SMS_EXPECT_MORE          10020
#define RIL_SAMSUNG_REQUEST_HANGUP_VT                          10021
#define RIL_SAMSUNG_REQUEST_HOLD                               10022
#define RIL_SAMSUNG_REQUEST_SET_SIM_POWER                      10023
#define RIL_SAMSUNG_REQUEST_SET_LTE_BAND_MODE                  10024
#define RIL_SAMSUNG_REQUEST_UICC_GBA_AUTHENTICATE_BOOTSTRAP    10025
#define RIL_SAMSUNG_REQUEST_UICC_GBA_AUTHENTICATE_NAF          10026
#define RIL_SAMSUNG_REQUEST_GET_INCOMING_COMMUNICATION_BARRING 10027
#define RIL_SAMSUNG_REQUEST_SET_INCOMING_COMMUNICATION_BARRING 10028

#define LAST_OEM_SOL RIL_SAMSUNG_REQUEST_SET_INCOMING_COMMUNICATION_BARRING

/* OEM RIL UNSOL */
#define OEM_UNSOL_BASE 11000

#define RIL_SAMSUNG_UNSOL_RESPONSE_NEW_CB_MSG            11000
#define RIL_SAMSUNG_UNSOL_RELEASE_COMPLETE_MESSAGE       11001
#define RIL_SAMSUNG_UNSOL_STK_SEND_SMS_RESULT            11002
#define RIL_SAMSUNG_UNSOL_STK_CALL_CONTROL_RESULT        11003
#define RIL_SAMSUNG_UNSOL_DEVICE_READY_NOTI              11008
#define RIL_SAMSUNG_UNSOL_GPS_NOTI                       11009
#define RIL_SAMSUNG_UNSOL_AM                             11010
#define RIL_SAMSUNG_UNSOL_SAP                            11013
#define RIL_SAMSUNG_UNSOL_UART                           11020
#define RIL_SAMSUNG_UNSOL_SIM_PB_READY                   11021
#define RIL_SAMSUNG_UNSOL_VE                             11024
#define RIL_SAMSUNG_UNSOL_FACTORY_AM                     11026
#define RIL_SAMSUNG_UNSOL_IMS_REGISTRATION_STATE_CHANGED 11027
#define RIL_SAMSUNG_UNSOL_MODIFY_CALL                    11028
#define RIL_SAMSUNG_UNSOL_CS_FALLBACK                    11030
#define RIL_SAMSUNG_UNSOL_VOICE_SYSTEM_ID                11032
#define RIL_SAMSUNG_UNSOL_IMS_RETRYOVER                  11034
#define RIL_SAMSUNG_UNSOL_PB_INIT_COMPLETE               11035
#define RIL_SAMSUNG_UNSOL_HYSTERESIS_DCN                 11037
#define RIL_SAMSUNG_UNSOL_CP_POSITION                    11038
#define RIL_SAMSUNG_UNSOL_HOME_NETWORK_NOTI              11043
#define RIL_SAMSUNG_UNSOL_STK_CALL_STATUS                11054
#define RIL_SAMSUNG_UNSOL_MODEM_CAP                      11056
#define RIL_SAMSUNG_UNSOL_DUN                            11060
#define RIL_SAMSUNG_UNSOL_IMS_PREFERENCE_CHANGED         11061
#define RIL_SAMSUNG_UNSOL_UNKNOWN_11062                  11062
#define RIL_SAMSUNG_UNSOL_SIM_ICCID_NOTI                 11064

#define LAST_OEM_UNSOL RIL_SAMSUNG_UNSOL_SIM_ICCID_NOTI

/////////////////////////////////////////////////////////
namespace android
{

#define PHONE_PROCESS "radio"

#define SOCKET_NAME_RIL "rild"
#define SOCKET2_NAME_RIL "rild2"
#define SOCKET3_NAME_RIL "rild3"
#define SOCKET4_NAME_RIL "rild4"

#define SOCKET_NAME_RIL_DEBUG "rild-debug"

#define ANDROID_WAKE_LOCK_NAME "radio-interface"


#define PROPERTY_RIL_IMPL "gsm.version.ril-impl"

// match with constant in RIL.java
#define MAX_COMMAND_BYTES (8 * 1024)

// Basically: memset buffers that the client library
// shouldn't be using anymore in an attempt to find
// memory usage issues sooner.
#define MEMSET_FREED 1

#define NUM_ELEMS(a)     (sizeof (a) / sizeof (a)[0])

#define MIN(a,b) ((a)<(b) ? (a) : (b))

/* Constants for response types */
#define RESPONSE_SOLICITED 0
#define RESPONSE_UNSOLICITED 1

/* Negative values for private RIL errno's */
#define RIL_ERRNO_INVALID_RESPONSE -1

// request, response, and unsolicited msg print macro
#define PRINTBUF_SIZE 8096

// Enable RILC log
#ifndef RILC_LOG
#define RILC_LOG 1
#endif

class __DEBUG_RIL_LOG__
{
    const char* _func;
    public:
        __DEBUG_RIL_LOG__(int line, const char* func):_func(func)
        {
            RLOGD("Entering %s at line %d", _func, line);
        }

        ~__DEBUG_RIL_LOG__()
        {
            RLOGD("Exiting %s", _func);
        }
};

#define log_func_entry         __DEBUG_RIL_LOG__ __debug_obj__(__LINE__, __func__)
#define log_func_line(fmt,...) RLOGD("%s at %d: " fmt, __func__, __LINE__, ## __VA_ARGS__)

#if RILC_LOG
    #define startRequest
    #define closeRequest
    #define printRequest(token, req)
    #define startResponse
    #define closeResponse
    #define printResponse
    #define clearPrintBuf
    #define removeLastChar
    #define appendPrintBuf(x...)
#else
    #define startRequest           sprintf(printBuf, "(")
    #define closeRequest           sprintf(printBuf, "%s)", printBuf)
    #define printRequest(token, req)           \
            RLOGD("[%04d]> %s %s", token, requestToString(req), printBuf)

    #define startResponse           sprintf(printBuf, "%s {", printBuf)
    #define closeResponse           sprintf(printBuf, "%s}", printBuf)
    #define printResponse           RLOGD("%s", printBuf)

    #define clearPrintBuf           printBuf[0] = 0
    #define removeLastChar          printBuf[strlen(printBuf)-1] = 0
    #define appendPrintBuf(x...)    sprintf(printBuf, x)
#endif

enum WakeType {DONT_WAKE, WAKE_PARTIAL};

typedef struct {
    int requestNumber;
    void (*dispatchFunction) (Parcel &p, struct RequestInfo *pRI);
    int(*responseFunction) (Parcel &p, void *response, size_t responselen);
} CommandInfo;

typedef struct {
    int requestNumber;
    int (*responseFunction) (Parcel &p, void *response, size_t responselen);
    WakeType wakeType;
} UnsolResponseInfo;

typedef struct RequestInfo {
    int32_t token;      //this is not RIL_Token
    CommandInfo *pCI;
    struct RequestInfo *p_next;
    char cancelled;
    char local;         // responses to local commands do not go back to command process
    RIL_SOCKET_ID socket_id;
} RequestInfo;

typedef struct UserCallbackInfo {
    RIL_TimedCallback p_callback;
    void *userParam;
    struct ril_event event;
    struct UserCallbackInfo *p_next;
} UserCallbackInfo;

typedef struct SocketListenParam {
    RIL_SOCKET_ID socket_id;
    int fdListen;
    int fdCommand;
    char* processName;
    struct ril_event* commands_event;
    struct ril_event* listen_event;
    void (*processCommandsCallback)(int fd, short flags, void *param);
    RecordStream *p_rs;
} SocketListenParam;

extern "C" const char * requestToString(int request);
extern "C" const char * failCauseToString(RIL_Errno);
extern "C" const char * callStateToString(RIL_CallState);
extern "C" const char * radioStateToString(RIL_RadioState);
extern "C" const char * rilSocketIdToString(RIL_SOCKET_ID socket_id);

/*******************************************************************/
static char * RIL_getRilSocketName();
extern "C" void RIL_setRilSocketName(char * s);
static char *strdupReadString(Parcel &p);
static status_t readStringFromParcelInplace(Parcel &p, char *str, size_t maxLen);
static void writeStringToParcel(Parcel &p, const char *s);
static void invalidCommandBlock (RequestInfo *pRI);

/*******************************************************************/
static int sendResponse (Parcel &p, RIL_SOCKET_ID socket_id);

static void dispatchVoid (Parcel &p, RequestInfo *pRI);
static void dispatchString (Parcel &p, RequestInfo *pRI);
static void dispatchStrings (Parcel &p, RequestInfo *pRI);
static void dispatchInts (Parcel &p, RequestInfo *pRI);
static void dispatchDial (Parcel &p, RequestInfo *pRI);
static void dispatchSIM_IO (Parcel &p, RequestInfo *pRI);
static void dispatchSIM_APDU (Parcel &p, RequestInfo *pRI);
static void dispatchCallForward(Parcel &p, RequestInfo *pRI);
static void dispatchRaw(Parcel &p, RequestInfo *pRI);
static void dispatchSmsWrite (Parcel &p, RequestInfo *pRI);
static void dispatchDataCall (Parcel &p, RequestInfo *pRI);
static void dispatchVoiceRadioTech (Parcel &p, RequestInfo *pRI);
static void dispatchSetInitialAttachApn (Parcel &p, RequestInfo *pRI);
static void dispatchCdmaSubscriptionSource (Parcel &p, RequestInfo *pRI);

static void dispatchCdmaSms(Parcel &p, RequestInfo *pRI);
static void dispatchImsSms(Parcel &p, RequestInfo *pRI);
static void dispatchImsCdmaSms(Parcel &p, RequestInfo *pRI, uint8_t retry, int32_t messageRef);
static void dispatchImsGsmSms(Parcel &p, RequestInfo *pRI, uint8_t retry, int32_t messageRef);
static void dispatchCdmaSmsAck(Parcel &p, RequestInfo *pRI);
static void dispatchGsmBrSmsCnf(Parcel &p, RequestInfo *pRI);
static void dispatchCdmaBrSmsCnf(Parcel &p, RequestInfo *pRI);
static void dispatchRilCdmaSmsWriteArgs(Parcel &p, RequestInfo *pRI);
static void dispatchNVReadItem(Parcel &p, RequestInfo *pRI);
static void dispatchNVWriteItem(Parcel &p, RequestInfo *pRI);
static void dispatchUiccSubscripton(Parcel &p, RequestInfo *pRI);
static void dispatchSimAuthentication(Parcel &p, RequestInfo *pRI);
static void dispatchDataProfile(Parcel &p, RequestInfo *pRI);
static void dispatchRadioCapability(Parcel &p, RequestInfo *pRI);
static int responseInts(Parcel &p, void *response, size_t responselen);
static int responseStrings(Parcel &p, void *response, size_t responselen);
static int responseString(Parcel &p, void *response, size_t responselen);
static int responseVoid(Parcel &p, void *response, size_t responselen);
static int responseCallList(Parcel &p, void *response, size_t responselen);
static int responseSMS(Parcel &p, void *response, size_t responselen);
static int responseSIM_IO(Parcel &p, void *response, size_t responselen);
static int responseCallForwards(Parcel &p, void *response, size_t responselen);
static int responseDataCallList(Parcel &p, void *response, size_t responselen);
static int responseSetupDataCall(Parcel &p, void *response, size_t responselen);
static int responseRaw(Parcel &p, void *response, size_t responselen);
static int responseSsn(Parcel &p, void *response, size_t responselen);
static int responseSimStatus(Parcel &p, void *response, size_t responselen);
static int responseGsmBrSmsCnf(Parcel &p, void *response, size_t responselen);
static int responseCdmaBrSmsCnf(Parcel &p, void *response, size_t responselen);
static int responseCdmaSms(Parcel &p, void *response, size_t responselen);
static int responseCellList(Parcel &p, void *response, size_t responselen);
static int responseCdmaInformationRecords(Parcel &p,void *response, size_t responselen);
static int responseRilSignalStrength(Parcel &p,void *response, size_t responselen);
static int responseCallRing(Parcel &p, void *response, size_t responselen);
static int responseCdmaSignalInfoRecord(Parcel &p,void *response, size_t responselen);
static int responseCdmaCallWaiting(Parcel &p,void *response, size_t responselen);
static int responseSimRefresh(Parcel &p, void *response, size_t responselen);
static int responseCellInfoList(Parcel &p, void *response, size_t responselen);
static int responseHardwareConfig(Parcel &p, void *response, size_t responselen);
static int responseDcRtInfo(Parcel &p, void *response, size_t responselen);
static int responseRadioCapability(Parcel &p, void *response, size_t responselen);
static int responseSSData(Parcel &p, void *response, size_t responselen);

///////////////////////
// OEM
static int responseModifyCall(Parcel &p, void *response, size_t responselen);
static int responseCBMessage(Parcel &p, void *response, size_t responselen);
static int responseSSReleaseComplete(Parcel &p, void *response, size_t responselen);
static int responseSimIccIdNoti(Parcel &p, void *response, size_t responselen);
static int responseCBConfig(Parcel &p, void *response, size_t responselen);
static int responsePBE(Parcel &p, void *response, size_t responselen);
static int responseLockInfo(Parcel &p, void *response, size_t responselen);
static int responsePreferredNetworkList(Parcel &p, void *response, size_t responselen);

static void dispatchOEMDepersonalization(Parcel &p, RequestInfo* pRI);
static void dispatchCallModify(Parcel &p, RequestInfo* pRI);
static void dispatchPhoneEntry(Parcel &p, RequestInfo* pRI);
static void dispatchPreferredNetwork(Parcel &p, RequestInfo* pRI);
static void dispatchEncodedUSSD(Parcel &p, RequestInfo* pRI);
static void dispatchLockInfo(Parcel &p, RequestInfo* pRI);

char* serializeCallDetails(CallDetails *details);
void unserializeCallDetails( char *buffer, CallDetails *callDetails );
///////////////////////


static int decodeVoiceRadioTechnology (RIL_RadioState radioState);
static int decodeCdmaSubscriptionSource (RIL_RadioState radioState);
static RIL_RadioState processRadioState(RIL_RadioState newRadioState);

static bool isServiceTypeCfQuery(RIL_SsServiceType serType, RIL_SsRequestType reqType);

static UserCallbackInfo * internalRequestTimedCallback
    (RIL_TimedCallback callback, void *param,
        const struct timeval *relativeTime);

extern RIL_RadioFunctions s_callbacks;

}// namespace android

#ifdef RIL_SHLIB
#if defined(ANDROID_MULTI_SIM)
extern "C" void RIL_onUnsolicitedResponse(int unsolResponse, void *data,
                                size_t datalen, RIL_SOCKET_ID socket_id);
#else
extern "C" void RIL_onUnsolicitedResponse(int unsolResponse, void *data,
                                size_t datalen);
#endif
#endif

#if defined(ANDROID_MULTI_SIM)
#define RIL_UNSOL_RESPONSE(a, b, c, d) RIL_onUnsolicitedResponse((a), (b), (c), (d))
#define CALL_ONREQUEST(a, b, c, d, e) s_callbacks.onRequest((a), (b), (c), (d), (e))
#define CALL_ONSTATEREQUEST(a) s_callbacks.onStateRequest(a)
#else
#define RIL_UNSOL_RESPONSE(a, b, c, d) RIL_onUnsolicitedResponse((a), (b), (c))
#define CALL_ONREQUEST(a, b, c, d, e) s_callbacks.onRequest((a), (b), (c), (d))
#define CALL_ONSTATEREQUEST(a) s_callbacks.onStateRequest()
#endif

#endif // OEM_RIL_H
