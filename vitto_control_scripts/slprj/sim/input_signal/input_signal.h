#ifndef RTW_HEADER_input_signal_h_
#define RTW_HEADER_input_signal_h_
#include "rtw_modelmap.h"
#ifndef input_signal_COMMON_INCLUDES_
# define input_signal_COMMON_INCLUDES_
#include <stddef.h>
#include <string.h>
#include "rtwtypes.h"
#include "simstruc.h"
#include "fixedpoint.h"
#include "mwmathutil.h"
#include "rt_SATURATE.h"
#include "rt_nonfinite.h"
#endif

#include "input_signal_types.h"

typedef struct {
  real_T B_2_1_0;
  real_T B_1_3_0;
} rtB_mr_input_signal;

typedef struct {
  boolean_T SteporRamp_Mode;
  boolean_T OnOffSwitch_Mode;
} rtDW_mr_input_signal;

typedef struct {
  real_T SteporRamp_SwitchCond_ZC;
  real_T OnOffSwitch_SwitchCond_ZC;
} rtZCSV_mr_input_signal;

typedef struct {
  ZCSigState SteporRamp_SwitchCond_ZCE;
  ZCSigState OnOffSwitch_SwitchCond_ZCE;
} rtZCE_mr_input_signal;

struct RT_MODEL_input_signal {
  struct SimStruct_tag *_mdlRefSfcnS;
  struct {
    rtwCAPI_ModelMappingInfo mmi;
    rtwCAPI_ModelMapLoggingInstanceInfo mmiLogInstanceInfo;
    sysRanDType* systemRan[4];
    int_T systemTid[4];
  } DataMapInfo;
};

typedef struct {
  rtB_mr_input_signal rtb;
  rtDW_mr_input_signal rtdw;
  RT_MODEL_input_signal rtm;
  rtZCE_mr_input_signal rtzce;
} rtMdlrefDWork_mr_input_signal;

extern void mr_input_signal_initialize(SimStruct * _mdlRefSfcnS, int_T
  mdlref_TID0, RT_MODEL_input_signal *input_signal_M, rtB_mr_input_signal
  *localB, rtDW_mr_input_signal *localDW, void *sysRanPtr, int contextTid,
  rtwCAPI_ModelMappingInfo *rt_ParentMMI, const char_T *rt_ChildPath, int_T
  rt_ChildMMIIdx, int_T rt_CSTATEIdx);
extern void mr_input_signal_MdlInfoRegFcn(SimStruct* mdlRefSfcnS, char_T
  *modelName, int_T *retVal);
extern void mr_input_signal_ZC(const real_T *rtu_order, const real_T *rtu_onoff,
  rtZCSV_mr_input_signal *localZCSV);
extern void mr_input_signal(const real_T *rtu_coeff, const real_T *rtu_order,
  const real_T *rtu_signaltypeoffpolyorsine, const real_T *rtu_sinefrequency,
  const real_T *rtu_tforgain, const real_T *rtu_onoff, real_T *rty_Outsignal,
  RT_MODEL_input_signal *rtm, rtB_mr_input_signal *localB, rtDW_mr_input_signal *
  localDW);

#endif
