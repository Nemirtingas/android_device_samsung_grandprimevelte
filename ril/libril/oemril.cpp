//#define DISABLE_OEM

namespace android {

void unserializeCallDetails( char *buffer, CallDetails *callDetails )
{
    char *str;
    int i;
    if( buffer && *buffer )
    {
        callDetails->num_strings = 1;

        for( i = 0; buffer[i] != 0; ++i )
        {
            if( buffer[i] == '|' )
                ++callDetails->num_strings;
        }

        callDetails->getCsvFromExtras = (char**)malloc(sizeof(char*)*callDetails->num_strings);
        for( i = 0; ; callDetails->getCsvFromExtras[i++] = str )
        {
            str = strsep(&buffer, "|");
            if( str == NULL )
                break;
        }
        callDetails->num_strings = i;
    }
    else
    {
        callDetails->num_strings = 0;
    }
}

char* serializeCallDetails(CallDetails *details)
{
    char *buffer;
    size_t data_len = 0;
    if( details->num_strings <= 0 )
        return NULL;

    buffer = (char*)malloc(1000 * details->num_strings);
    memset(buffer, 0, 1000*details->num_strings);
    for( int i = 0; i < details->num_strings; ++i )
    {
        data_len += sprintf(buffer + data_len, "%s|", details->getCsvFromExtras[i]);
    }
    if( data_len > 0 && buffer[data_len-1] == '|' )
    {
        buffer[data_len-1] = 0;
    }
    return buffer;
}

static int responsePreferredNetworkList(Parcel &p, void *response, size_t responselen)
{
    log_func_entry;
#ifndef DISABLE_OEM
    int32_t num;

    if( response == NULL )
    {
        RLOGE("invalid response: NULL");
        return RIL_ERRNO_INVALID_RESPONSE;
    }
    if( responselen & 3 )
    {
        RLOGE("responseCBConfig: invalid response length was %d expected %d", responselen, 28);
        return RIL_ERRNO_INVALID_RESPONSE;
    }

    num = responselen >> 2;

    p.writeInt32(num);

    int32_t *p_buf = (int32_t*)response;

    if( num )
    {
        for( int i = 0; i < num; ++i )
        {
            p.writeInt32(p_buf[0]);
            writeStringToParcel(p, (char*)p_buf[1]);
            writeStringToParcel(p, (char*)p_buf[2]);
            p.writeInt32(p_buf[3]);
            p.writeInt32(p_buf[4]);
            p.writeInt32(p_buf[5]);
            p.writeInt32(p_buf[6]);
        }
    }
#endif
    return 0;
}

static int responsePBE(Parcel &p, void *response, size_t responselen)
{
    log_func_entry;
#ifndef DISABLE_OEM
    struct struc2
    {
        int x[3];
        int y[3];
        char *a[3];
        int32_t b[5];
        int32_t c[5];
        char *d[5];
        int32_t e;
        int32_t f;
    };
    struc2 *tt = (struc2*)response;

    if( response == NULL )
    {
        RLOGE("invalid response: NULL");
        return RIL_ERRNO_INVALID_RESPONSE;
    }
    if( responselen != 104 )
    {
        RLOGE("responseCBConfig: invalid response length was %d expected %d", responselen, 104);
        return RIL_ERRNO_INVALID_RESPONSE;
    }

    responseInts(p, tt->x, 3 * sizeof(int32_t));
    responseInts(p, tt->y, 3 * sizeof(int32_t));
    responseStrings(p, tt->a, 3 * sizeof(char*));
    responseInts(p, tt->b, 5 * sizeof(int32_t));
    responseInts(p, tt->c, 5 * sizeof(int32_t));
    responseStrings(p, tt->d, 5 * sizeof(int32_t));
    p.writeInt32(tt->e);
    p.writeInt32(tt->f);
#endif
    return 0;
}

static int responseLockInfo(Parcel &p, void *response, size_t responselen)
{
    log_func_entry;
#ifndef DISABLE_OEM
    if( response == NULL )
    {
        RLOGE("invalid response: NULL");
        return RIL_ERRNO_INVALID_RESPONSE;
    }
    if( responselen != 16 )
    {
        RLOGE("responseCBConfig: invalid response length was %d expected %d", responselen, 16);
        return RIL_ERRNO_INVALID_RESPONSE;
    }

    int32_t *p_buf = (int32_t*)response;

    p.writeInt32(p_buf[0]);
    p.writeInt32(p_buf[1]);
    p.writeInt32(p_buf[2]);
    p.writeInt32(p_buf[3]);
#endif
    return 0;
}

static int responseCBMessage(Parcel &p, void *response, size_t responselen)
{
    log_func_entry;
#ifndef DISABLE_OEM
    if( response == NULL )
    {
        RLOGE("invalid response: NULL");
        return RIL_ERRNO_INVALID_RESPONSE;
    }
    if( responselen != 500 )
    {
        RLOGE("responseCBConfig: invalid response length was %d expected %d", responselen, 500);
        return RIL_ERRNO_INVALID_RESPONSE;
    }

    int32_t *p_buf = (int32_t*)response;

    p.writeInt32(p_buf[0]);
    p.writeInt32(p_buf[1]);
    writeStringToParcel(p, (char*)p_buf[2]);
#endif
    return 0;
}

static int responseModifyCall(Parcel &p, void *response, size_t responselen)
{
    log_func_entry;
#ifndef DISABLE_OEM
    char *buffer;
    RIL_OEMCallArgs *args = (RIL_OEMCallArgs*)response;

    if( response == NULL )
    {
        RLOGE("invalid response: NULL");
        return RIL_ERRNO_INVALID_RESPONSE;
    }
    if( responselen != 8 )
    {
        RLOGE("responseCBConfig: invalid response length was %d expected %d", responselen, 20);
        return RIL_ERRNO_INVALID_RESPONSE;
    }

    p.writeInt32((int)args->x);
    p.writeInt32(args->callDetails->call_type);
    p.writeInt32(args->callDetails->call_domain);

    buffer = serializeCallDetails(args->callDetails);
    if( buffer == NULL )
        writeStringToParcel(p, "");
    else
    {
        writeStringToParcel(p, buffer);
        free(buffer);
    }
#endif
    return 0;
}

static int responseCBConfig(Parcel &p, void *response, size_t responselen)
{
    log_func_entry;
#ifndef DISABLE_OEM
    if( response == NULL )
    {
        RLOGE("invalid response: NULL");
        return RIL_ERRNO_INVALID_RESPONSE;
    }
    if( responselen != 20 )
    {
        RLOGE("responseCBConfig: invalid response length was %d expected %d", responselen, 20);
        return RIL_ERRNO_INVALID_RESPONSE;
    }

    int32_t *p_buf = (int32_t*)response;

    p.writeInt32(p_buf[0]);
    p.writeInt32(p_buf[1]);
    p.writeInt32(p_buf[2]);
    p.writeInt32(p_buf[3]);
    p.writeInt32(p_buf[4]);
#endif
    return 0;
}

static int responseSSReleaseComplete(Parcel &p, void *response, size_t responselen)
{
    log_func_entry;
#ifndef DISABLE_OEM
    if( response == NULL )
    {
        RLOGE("invalid response: NULL");
        return RIL_ERRNO_INVALID_RESPONSE;
    }

    int32_t *p_buf = (int32_t*)response;

    p.writeInt32(p_buf[0]);
    p.writeInt32(p_buf[1]);
    p.writeInt32(p_buf[2]);
    p.writeInt32(p_buf[3]);
    writeStringToParcel(p, (char*)p_buf[4]);
#endif
    return 0;
}

static int responseSimIccIdNoti(Parcel &p, void *response, size_t responselen)
{
    log_func_entry;
#ifndef DISABLE_OEM
    if (response == NULL && responselen != 0) {
        RLOGE("invalid response: NULL");
        return RIL_ERRNO_INVALID_RESPONSE;
    }

    if( responselen != 8 )
    {
        RLOGE("invalid response length %d, expected %d", responselen, 8);
        return RIL_ERRNO_INVALID_RESPONSE;
    }

    const char **p_buf = (const char**)response;

    writeStringToParcel(p, p_buf[1]);
#endif
    return 0;
}

static void dispatchOEMDepersonalization(Parcel &p, RequestInfo* pRI)
{
    log_func_entry;
#ifndef DISABLE_OEM
    int32_t args[2];
    int32_t t;
    status_t status;

    status = p.readInt32(&t);
    args[0] = t;

    args[1] = (int32_t)strdupReadString(p);
    if( status != NO_ERROR )
    {
        invalidCommandBlock(pRI);
    }
    else
    {
        CALL_ONREQUEST(pRI->pCI->requestNumber, &args, sizeof(args), pRI, pRI->socket_id);
    }
    memsetString((char*)args[1]);
    free((char*)args[1]);
#endif
}

static void dispatchCallModify(Parcel &p, RequestInfo* pRI)
{
    log_func_entry;
#ifndef DISABLE_OEM
    RIL_OEMCallArgs args;
    int32_t t;
    char *buffer;
    status_t status;

    p.readInt32(&t);
    args.x = (int32_t*)t;

    p.readInt32(&t);
    args.callDetails->call_type = t;
    status = p.readInt32(&t);
    args.callDetails->call_domain = t;

    if( status != NO_ERROR )
    {
        invalidCommandBlock(pRI);
    }
    else
    {
        buffer = strdupReadString(p);

        args.callDetails = (CallDetails*)malloc(sizeof(CallDetails));
        memset(args.callDetails, 0, sizeof(CallDetails));

        unserializeCallDetails(buffer, args.callDetails);

        CALL_ONREQUEST(pRI->pCI->requestNumber, &args, sizeof(args), pRI, pRI->socket_id);

        free(buffer);
        free(args.callDetails->getCsvFromExtras);
        free(args.callDetails);
    }
#endif
}

static void dispatchPhoneEntry(Parcel &p, RequestInfo* pRI)
{
    log_func_entry;
#ifndef DISABLE_OEM
    int32_t args[17];
    int32_t t;
    status_t status;

    p.readInt32(&args[0]);
    p.readInt32(&args[1]);
    p.readInt32(&args[2]);

    p.readInt32(&t);
    if( t == -1 )
    {
        args[3] = 0;
        p.readInplace(0);
    }
    else
    {
        args[3] = (int32_t)p.readInplace(t);
    }
    p.readInt32(&args[5]);
    p.readInt32(&args[4]);

    args[6] = (int32_t)strdupReadString(p);
    p.readInt32(&t);
    if( t == -1 )
    {
        args[7] = 0;
        p.readInplace(0);
    }
    else
    {
        args[7] = (int32_t)p.readInplace(t);
    }
    p.readInt32(&args[8]);
    args[9] = (int32_t)strdupReadString(p);
    args[10] = (int32_t)strdupReadString(p);
    args[11] = (int32_t)strdupReadString(p);
    args[12] = (int32_t)strdupReadString(p);
    p.readInt32(&t);
    if( t == -1 )
    {
        args[13] = 0;
        p.readInplace(0);
    }
    else
    {
        args[13] = (int32_t)p.readInplace(t);
    }
    p.readInt32(&args[14]);
    status = p.readInt32(&args[15]);
    args[16] = (int32_t)strdupReadString(p);
    if( status != NO_ERROR )
    {
        invalidCommandBlock(pRI);
    }
    else
    {
        CALL_ONREQUEST(pRI->pCI->requestNumber, args, sizeof(args), pRI, pRI->socket_id);
        memsetString((char*)args[6]);
        memsetString((char*)args[9]);
        memsetString((char*)args[10]);
        memsetString((char*)args[11]);
        memsetString((char*)args[12]);
        memsetString((char*)args[16]);
        free((char*)args[6]);
        free((char*)args[9]);
        free((char*)args[10]);
        free((char*)args[11]);
        free((char*)args[12]);
        free((char*)args[16]);
    }
#endif
}

static void dispatchPreferredNetwork(Parcel &p, RequestInfo* pRI)
{
    log_func_entry;
#ifndef DISABLE_OEM
    int32_t args[7];
    int32_t t;
    status_t status;

    memset(args, 0, sizeof(args));

    p.readInt32(&t);
    args[0] = t;

    args[1] = (int32_t)strdupReadString(p);
    RLOGD("PreferredNetworkInfo.oper = %s", (char*)args[1]);
    args[2] = (int32_t)strdupReadString(p);
    RLOGD("PreferredNetworkInfo.plmn = %s", (char*)args[2]);

    p.readInt32(&t);
    args[3] = t;
    p.readInt32(&t);
    args[4] = t;
    p.readInt32(&t);
    args[5] = t;
    status = p.readInt32(&t);
    args[6] = t;
    if( status != NO_ERROR )
    {
        invalidCommandBlock(pRI);
    }
    else
    {
        CALL_ONREQUEST(pRI->pCI->requestNumber, args, sizeof(args), pRI, pRI->socket_id);
    }
    memsetString((char*)args[1]);
    memsetString((char*)args[2]);
    free((char*)args[1]);
    free((char*)args[2]);
    memset(args, 0, sizeof(args));
#endif
}

static void dispatchEncodedUSSD(Parcel &p, RequestInfo* pRI)
{
    log_func_entry;
#ifndef DISABLE_OEM
    int32_t args[3];
    int32_t t;

    if( p.readInt32(&t) != NO_ERROR )
    {
        invalidCommandBlock(pRI);
        return;
    }
    if( t == -1 ) t = 0;

    args[0] = (int32_t)p.readInplace(t);
    p.readInt32(&args[1]);

    if( p.readInt32(&args[2]) != NO_ERROR )
    {
        invalidCommandBlock(pRI);
    }
    else
    {
        CALL_ONREQUEST(pRI->pCI->requestNumber, args, sizeof(args), pRI, pRI->socket_id);
        args[0] = 0;
        args[1] = 0;
        args[2] = 0;
    }
#endif
}

static void dispatchLockInfo(Parcel &p, RequestInfo* pRI)
{
    log_func_entry;
#ifndef DISABLE_OEM
    int32_t args[4];
    int32_t t;
    status_t status;

    p.readInt32(&t);
    args[0] = t;
    status = p.readInt32(&t);
    args[1] = t;
    args[2] = 0;
    args[3] = 0;
    if( status != NO_ERROR )
    {
        invalidCommandBlock(pRI);
    }
    else
    {
        CALL_ONREQUEST(pRI->pCI->requestNumber, &args, sizeof(args), pRI, pRI->socket_id);
    }
#endif
}

}
