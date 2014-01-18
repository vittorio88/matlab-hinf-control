#include "input_signal.h"
#include "rtw_capi.h"
#include "input_signal_private.h"

static rtwCAPI_Signals rtBlockSignals[] = {

  {
    0, 0, (NULL), (NULL), 0, 0, 0, 0, 0
  }
};

static rtwCAPI_LoggingBusElement rtBusElements[] = {
  { 0, rtwCAPI_signal }
};

static rtwCAPI_LoggingBusSignals rtBusSignals[] = {

  { (NULL), (NULL), 0, 0, (NULL) }
};

static rtwCAPI_States rtBlockStates[] = {

  {
    0, -1, (NULL), (NULL), (NULL), 0, 0, 0, 0, 0, 0
  }
};

static rtwCAPI_DataTypeMap rtDataTypeMap[] = {

  {
    "", "", 0, 0, 0, 0, 0, 0
  }
};

static rtwCAPI_ElementMap rtElementMap[] = {

  { (NULL), 0, 0, 0, 0 },
};

static rtwCAPI_DimensionMap rtDimensionMap[] = {

  {
    rtwCAPI_SCALAR, 0, 0, 0
  }
};

static uint_T rtDimensionArray[] = { 0 };

static rtwCAPI_FixPtMap rtFixPtMap[] = {

  { (NULL), (NULL), rtwCAPI_FIX_RESERVED, 0, 0, 0 },
};

static rtwCAPI_SampleTimeMap rtSampleTimeMap[] = {

  {
    (NULL), (NULL), 0, 0
  }
};

static int_T rtContextSystems[4];
static rtwCAPI_LoggingMetaInfo loggingMetaInfo[] = {
  { 0, 0, "", 0 }
};

static rtwCAPI_ModelMapLoggingStaticInfo mmiStaticInfoLogging = {
  4, rtContextSystems, loggingMetaInfo, 0, rtBusSignals
};

static rtwCAPI_ModelMappingStaticInfo mmiStatic = {

  { rtBlockSignals, 0 },

  { (NULL), 0,
    (NULL), 0 },

  { rtBlockStates, 0 },

  { rtDataTypeMap, rtDimensionMap, rtFixPtMap,
    rtElementMap, rtSampleTimeMap, rtDimensionArray },
  "float", &mmiStaticInfoLogging
};

static void input_signal_InitializeSystemRan(sysRanDType *systemRan[],
  rtDW_mr_input_signal *localDW,
  int_T systemTid[], void *rootSysRanPtr, int rootTid)
{
  systemRan[0] = (sysRanDType *) rootSysRanPtr;
  systemRan[1] = (NULL);
  systemRan[2] = (NULL);
  systemRan[3] = (NULL);
  systemTid[1] = input_signal_GlobalTID[0];
  systemTid[2] = input_signal_GlobalTID[0];
  systemTid[3] = input_signal_GlobalTID[0];
  systemTid[0] = rootTid;
  rtContextSystems[0] = 0;
  rtContextSystems[1] = 0;
  rtContextSystems[2] = 0;
  rtContextSystems[3] = 0;
}

void input_signal_InitializeDataMapInfo(RT_MODEL_input_signal *input_signal_M,
  rtDW_mr_input_signal *localDW, void *sysRanPtr, int contextTid)
{
  rtwCAPI_SetVersion(input_signal_M->DataMapInfo.mmi, 1);
  rtwCAPI_SetStaticMap(input_signal_M->DataMapInfo.mmi, &mmiStatic);
  rtwCAPI_SetLoggingStaticMap(input_signal_M->DataMapInfo.mmi,
    &mmiStaticInfoLogging);
  rtwCAPI_SetPath(input_signal_M->DataMapInfo.mmi, (NULL));
  rtwCAPI_SetFullPath(input_signal_M->DataMapInfo.mmi, (NULL));
  rtwCAPI_SetInstanceLoggingInfo(input_signal_M->DataMapInfo.mmi,
    &input_signal_M->DataMapInfo.mmiLogInstanceInfo);
  rtwCAPI_SetChildMMIArray(input_signal_M->DataMapInfo.mmi, (NULL));
  rtwCAPI_SetChildMMIArrayLen(input_signal_M->DataMapInfo.mmi, 0);
  input_signal_InitializeSystemRan(input_signal_M->DataMapInfo.systemRan,
    localDW,
    input_signal_M->DataMapInfo.systemTid, sysRanPtr, contextTid);
  rtwCAPI_SetSystemRan(input_signal_M->DataMapInfo.mmi,
                       input_signal_M->DataMapInfo.systemRan);
  rtwCAPI_SetSystemTid(input_signal_M->DataMapInfo.mmi,
                       input_signal_M->DataMapInfo.systemTid);
  rtwCAPI_SetGlobalTIDMap(input_signal_M->DataMapInfo.mmi,
    &input_signal_GlobalTID[0]);
}
