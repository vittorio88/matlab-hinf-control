#include "input_signal_capi.h"
#include "input_signal.h"
#include "input_signal_private.h"

int_T input_signal_GlobalTID[1];
static RegMdlInfo rtMdlInfo_input_signal[40] = {
  { "rtMdlrefDWork_mr_input_signal", MDL_INFO_NAME_MDLREF_DWORK, 0, -1, (void *)
    "input_signal" },

  { "rtZCSV_mr_input_signal", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, -1, (void *)
    "input_signal" },

  { "rtXdis_mr_input_signal", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, -1, (void *)
    "input_signal" },

  { "rtXdot_mr_input_signal", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, -1, (void *)
    "input_signal" },

  { "rtX_mr_input_signal", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, -1, (void *)
    "input_signal" },

  { "rtRTM_mr_input_signal", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, -1, (void *)
    "input_signal" },

  { "rtZCE_mr_input_signal", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, -1, (void *)
    "input_signal" },

  { "rtC_mr_input_signal", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, -1, (void *)
    "input_signal" },

  { "rtP_mr_input_signal", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, -1, (void *)
    "input_signal" },

  { "rtDW_mr_input_signal", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, -1, (void *)
    "input_signal" },

  { "rtB_mr_input_signal", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, -1, (void *)
    "input_signal" },

  { "mr_input_signal_ZCSV", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, -1, (void *)
    "input_signal" },

  { "mr_input_signal_Xdis", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, -1, (void *)
    "input_signal" },

  { "mr_input_signal_Xdot", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, -1, (void *)
    "input_signal" },

  { "mr_input_signal_X", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, -1, (void *)
    "input_signal" },

  { "mr_input_signal_RTM", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, -1, (void *)
    "input_signal" },

  { "mr_input_signal_ZCE", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, -1, (void *)
    "input_signal" },

  { "mr_input_signal_C", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, -1, (void *)
    "input_signal" },

  { "mr_input_signal_P", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, -1, (void *)
    "input_signal" },

  { "mr_input_signal_DW", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, -1, (void *)
    "input_signal" },

  { "mr_input_signal_B", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, -1, (void *)
    "input_signal" },

  { "mr_input_signal_rty_Outsignal", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, -1,
    (void *) "input_signal" },

  { "mr_input_signal_rtu_onoff", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, -1, (void *)
    "input_signal" },

  { "mr_input_signal_rtu_tforgain", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, -1,
    (void *) "input_signal" },

  { "mr_input_signal_rtu_sinefrequency", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, -1,
    (void *) "input_signal" },

  { "mr_input_signal_rtu_signaltypeoffpolyorsine",
    MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, -1, (void *) "input_signal" },

  { "mr_input_signal_rtu_order", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, -1, (void *)
    "input_signal" },

  { "mr_input_signal_rtu_coeff", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, -1, (void *)
    "input_signal" },

  { "mr_input_signal_Term", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, -1, (void *)
    "input_signal" },

  { "mr_input_signal_ZC", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, -1, (void *)
    "input_signal" },

  { "mr_input_signal_initialize", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, -1, (void
    *) "input_signal" },

  { "mr_input_signal_Start", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, -1, (void *)
    "input_signal" },

  { "mr_input_signal", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, 0, (void *)
    "input_signal" },

  { "input_signal", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, 0, (NULL) },

  { "RT_MODEL_input_signal", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, -1, (void *)
    "input_signal" },

  { "input_signal_GlobalTID", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, -1, (void *)
    "input_signal" },

  { "input_signal_ConstP", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, -1, (void *)
    "input_signal" },

  { "ConstParam_input_signal", MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT, 0, -1, (void *)
    "input_signal" },

  { "input_signal.h", MDL_INFO_MODEL_FILENAME, 0, 0, (NULL) },

  { "input_signal.c", MDL_INFO_MODEL_FILENAME, 0, 0, (NULL) } };

void mr_input_signal_ZC(const real_T *rtu_order, const real_T *rtu_onoff,
  rtZCSV_mr_input_signal *localZCSV)
{
  localZCSV->SteporRamp_SwitchCond_ZC = (*rtu_order);
  localZCSV->OnOffSwitch_SwitchCond_ZC = (*rtu_onoff) - 1.0;
}

void mr_input_signal(const real_T *rtu_coeff, const real_T *rtu_order, const
                     real_T *rtu_signaltypeoffpolyorsine, const real_T
                     *rtu_sinefrequency, const real_T *rtu_tforgain, const
                     real_T *rtu_onoff, real_T *rty_Outsignal,
                     RT_MODEL_input_signal *input_signal_M, rtB_mr_input_signal *
                     localB, rtDW_mr_input_signal *localDW)
{
  {
    real_T B_2_2_0;
    localB->B_2_1_0 = rtmGetTaskTime(input_signal_M, 0);
    if (rtmIsMajorTimeStep(input_signal_M)) {
      localDW->SteporRamp_Mode = ((*rtu_order) != 0.0);
    }

    if (localDW->SteporRamp_Mode) {
      B_2_2_0 = localB->B_2_1_0;
    } else {
      B_2_2_0 = 1.0;
    }

    if (rtmIsMajorTimeStep(input_signal_M)) {
      localDW->OnOffSwitch_Mode = ((*rtu_onoff) >= 1.0);
    }

    if (localDW->OnOffSwitch_Mode) {
      if (rtmIsMajorTimeStep(input_signal_M)) {
        switch ((int32_T)(*rtu_signaltypeoffpolyorsine)) {
         case 0:
          B_2_2_0 = 0.0;
          break;

         case 1:
          break;

         default:
          B_2_2_0 = muDoubleScalarSin((*rtu_sinefrequency) * localB->B_2_1_0);
          break;
        }
      } else {
        switch (rt_SATURATE((int32_T)(*rtu_signaltypeoffpolyorsine), 0, 2)) {
         case 0:
          B_2_2_0 = 0.0;
          break;

         case 1:
          break;

         default:
          B_2_2_0 = muDoubleScalarSin((*rtu_sinefrequency) * localB->B_2_1_0);
          break;
        }
      }

      localB->B_1_3_0 = (*rtu_coeff) * B_2_2_0 * (*rtu_tforgain);
      (*rty_Outsignal) = localB->B_1_3_0;
    } else {
      (*rty_Outsignal) = 0.0;
    }
  }
}

void mr_input_signal_initialize(SimStruct * _mdlRefSfcnS, int_T mdlref_TID0,
  RT_MODEL_input_signal *input_signal_M, rtB_mr_input_signal *localB,
  rtDW_mr_input_signal *localDW, void *sysRanPtr, int contextTid,
  rtwCAPI_ModelMappingInfo *rt_ParentMMI, const char_T *rt_ChildPath, int_T
  rt_ChildMMIIdx, int_T rt_CSTATEIdx)
{
  rt_InitInfAndNaN(sizeof(real_T));
  (void) memset((void *)input_signal_M,0,
                sizeof(RT_MODEL_input_signal));
  input_signal_GlobalTID[0] = mdlref_TID0;
  input_signal_M->_mdlRefSfcnS = (_mdlRefSfcnS);

  {
    localB->B_2_1_0 = 0.0;
    localB->B_1_3_0 = 0.0;
  }

  (void) memset((void *)localDW, 0,
                sizeof(rtDW_mr_input_signal));
  input_signal_InitializeDataMapInfo(input_signal_M, localDW, sysRanPtr,
    contextTid);
  if ((rt_ParentMMI != (NULL)) && (rt_ChildPath != (NULL))) {
    rtwCAPI_SetChildMMI(*rt_ParentMMI, rt_ChildMMIIdx,
                        &(input_signal_M->DataMapInfo.mmi));
    rtwCAPI_SetPath(input_signal_M->DataMapInfo.mmi, rt_ChildPath);
    rtwCAPI_MMISetContStateStartIndex(input_signal_M->DataMapInfo.mmi,
      rt_CSTATEIdx);
  }
}

void mr_input_signal_MdlInfoRegFcn(SimStruct* mdlRefSfcnS, char_T *modelName,
  int_T *retVal)
{
  *retVal = 0;
  *retVal = 0;
  ssRegModelRefMdlInfo(mdlRefSfcnS, modelName, rtMdlInfo_input_signal, 40);
  *retVal = 1;
}
