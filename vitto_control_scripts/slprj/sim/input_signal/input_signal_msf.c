#if !defined(S_FUNCTION_NAME)
#define S_FUNCTION_NAME                input_signal_msf
#endif

#define S_FUNCTION_LEVEL               2

#if !defined(RTW_GENERATED_S_FUNCTION)
#define RTW_GENERATED_S_FUNCTION
#endif

#include <stdio.h>
#include <math.h>
#include "simstruc.h"
#include "fixedpoint.h"
#define rt_logging_h
#include "input_signal_types.h"
#include "input_signal.h"
#include "input_signal_private.h"

MdlRefChildMdlRec childModels[1] = {
  "input_signal", "input_signal", 0, (NULL) };

static void mdlInitializeSizes(SimStruct *S)
{
  ssSetNumSFcnParams(S, 0);
  ssFxpSetU32BitRegionCompliant(S, 1);
  if (S->mdlInfo->genericFcn != (NULL)) {
    _GenericFcn fcn = S->mdlInfo->genericFcn;
    (fcn)(S, GEN_FCN_CHK_MODELREF_SOLVER_TYPE_EARLY, 1, (NULL));
  }

  ssSetRTWGeneratedSFcn(S, 2);
  ssSetNumContStates(S, 0);
  ssSetNumDiscStates(S, 0);
  if (!ssSetNumInputPorts(S, 6))
    return;
  if (!ssSetInputPortVectorDimension(S, 0, 1))
    return;
  ssSetInputPortDimensionsMode(S, 0, FIXED_DIMS_MODE);
  ssSetInputPortFrameData(S, 0, FRAME_NO);
  ssSetInputPortBusMode(S, 0, SL_NON_BUS_MODE)
    if (ssGetSimMode(S) != SS_SIMMODE_SIZES_CALL_ONLY)
  {
    ssSetInputPortDataType(S, 0, SS_DOUBLE);
  }

  ssSetInputPortDirectFeedThrough(S, 0, 1);
  ssSetInputPortRequiredContiguous(S, 0, 1);
  ssSetInputPortOptimOpts(S, 0, SS_NOT_REUSABLE_AND_LOCAL);
  ssSetInputPortOverWritable(S, 0, FALSE);
  ssSetInputPortSampleTime(S, 0, 0.0);
  ssSetInputPortOffsetTime(S, 0, 0.0);
  if (!ssSetInputPortVectorDimension(S, 1, 1))
    return;
  ssSetInputPortDimensionsMode(S, 1, FIXED_DIMS_MODE);
  ssSetInputPortFrameData(S, 1, FRAME_NO);
  ssSetInputPortBusMode(S, 1, SL_NON_BUS_MODE)
    if (ssGetSimMode(S) != SS_SIMMODE_SIZES_CALL_ONLY)
  {
    ssSetInputPortDataType(S, 1, SS_DOUBLE);
  }

  ssSetInputPortDirectFeedThrough(S, 1, 1);
  ssSetInputPortRequiredContiguous(S, 1, 1);
  ssSetInputPortOptimOpts(S, 1, SS_NOT_REUSABLE_AND_GLOBAL);
  ssSetInputPortOverWritable(S, 1, FALSE);
  ssSetInputPortSampleTime(S, 1, 0.0);
  ssSetInputPortOffsetTime(S, 1, 0.0);
  if (!ssSetInputPortVectorDimension(S, 2, 1))
    return;
  ssSetInputPortDimensionsMode(S, 2, FIXED_DIMS_MODE);
  ssSetInputPortFrameData(S, 2, FRAME_NO);
  ssSetInputPortBusMode(S, 2, SL_NON_BUS_MODE)
    if (ssGetSimMode(S) != SS_SIMMODE_SIZES_CALL_ONLY)
  {
    ssSetInputPortDataType(S, 2, SS_DOUBLE);
  }

  ssSetInputPortDirectFeedThrough(S, 2, 1);
  ssSetInputPortRequiredContiguous(S, 2, 1);
  ssSetInputPortOptimOpts(S, 2, SS_NOT_REUSABLE_AND_LOCAL);
  ssSetInputPortOverWritable(S, 2, FALSE);
  ssSetInputPortSampleTime(S, 2, 0.0);
  ssSetInputPortOffsetTime(S, 2, 0.0);
  if (!ssSetInputPortVectorDimension(S, 3, 1))
    return;
  ssSetInputPortDimensionsMode(S, 3, FIXED_DIMS_MODE);
  ssSetInputPortFrameData(S, 3, FRAME_NO);
  ssSetInputPortBusMode(S, 3, SL_NON_BUS_MODE)
    if (ssGetSimMode(S) != SS_SIMMODE_SIZES_CALL_ONLY)
  {
    ssSetInputPortDataType(S, 3, SS_DOUBLE);
  }

  ssSetInputPortDirectFeedThrough(S, 3, 1);
  ssSetInputPortRequiredContiguous(S, 3, 1);
  ssSetInputPortOptimOpts(S, 3, SS_NOT_REUSABLE_AND_LOCAL);
  ssSetInputPortOverWritable(S, 3, FALSE);
  ssSetInputPortSampleTime(S, 3, 0.0);
  ssSetInputPortOffsetTime(S, 3, 0.0);
  if (!ssSetInputPortVectorDimension(S, 4, 1))
    return;
  ssSetInputPortDimensionsMode(S, 4, FIXED_DIMS_MODE);
  ssSetInputPortFrameData(S, 4, FRAME_NO);
  ssSetInputPortBusMode(S, 4, SL_NON_BUS_MODE)
    if (ssGetSimMode(S) != SS_SIMMODE_SIZES_CALL_ONLY)
  {
    ssSetInputPortDataType(S, 4, SS_DOUBLE);
  }

  ssSetInputPortDirectFeedThrough(S, 4, 1);
  ssSetInputPortRequiredContiguous(S, 4, 1);
  ssSetInputPortOptimOpts(S, 4, SS_NOT_REUSABLE_AND_LOCAL);
  ssSetInputPortOverWritable(S, 4, FALSE);
  ssSetInputPortSampleTime(S, 4, 0.0);
  ssSetInputPortOffsetTime(S, 4, 0.0);
  if (!ssSetInputPortVectorDimension(S, 5, 1))
    return;
  ssSetInputPortDimensionsMode(S, 5, FIXED_DIMS_MODE);
  ssSetInputPortFrameData(S, 5, FRAME_NO);
  ssSetInputPortBusMode(S, 5, SL_NON_BUS_MODE)
    if (ssGetSimMode(S) != SS_SIMMODE_SIZES_CALL_ONLY)
  {
    ssSetInputPortDataType(S, 5, SS_DOUBLE);
  }

  ssSetInputPortDirectFeedThrough(S, 5, 1);
  ssSetInputPortRequiredContiguous(S, 5, 1);
  ssSetInputPortOptimOpts(S, 5, SS_NOT_REUSABLE_AND_GLOBAL);
  ssSetInputPortOverWritable(S, 5, FALSE);
  ssSetInputPortSampleTime(S, 5, 0.0);
  ssSetInputPortOffsetTime(S, 5, 0.0);
  if (!ssSetNumOutputPorts(S, 1))
    return;
  if (!ssSetOutputPortVectorDimension(S, 0, 1))
    return;
  ssSetOutputPortDimensionsMode(S, 0, FIXED_DIMS_MODE);
  ssSetOutputPortFrameData(S, 0, FRAME_NO);
  ssSetOutputPortBusMode(S, 0, SL_NON_BUS_MODE)
    if (ssGetSimMode(S) != SS_SIMMODE_SIZES_CALL_ONLY)
  {
    ssSetOutputPortDataType(S, 0, SS_DOUBLE);
  }

  ssSetOutputPortSampleTime(S, 0, 0.0);
  ssSetOutputPortOffsetTime(S, 0, 0.0);
  ssSetOutputPortDiscreteValuedOutput(S, 0, 0);
  ssSetOutputPortOkToMerge(S, 0, SS_OK_TO_MERGE);
  ssSetOutputPortOptimOpts(S, 0, SS_NOT_REUSABLE_AND_LOCAL);
  rt_InitInfAndNaN(sizeof(real_T));

  {
    real_T minValue = rtMinusInf;
    real_T maxValue = rtInf;
    ssSetModelRefInputSignalDesignMin(S,0,&minValue);
    ssSetModelRefInputSignalDesignMax(S,0,&maxValue);
  }

  {
    real_T minValue = rtMinusInf;
    real_T maxValue = rtInf;
    ssSetModelRefInputSignalDesignMin(S,1,&minValue);
    ssSetModelRefInputSignalDesignMax(S,1,&maxValue);
  }

  {
    real_T minValue = rtMinusInf;
    real_T maxValue = rtInf;
    ssSetModelRefInputSignalDesignMin(S,2,&minValue);
    ssSetModelRefInputSignalDesignMax(S,2,&maxValue);
  }

  {
    real_T minValue = rtMinusInf;
    real_T maxValue = rtInf;
    ssSetModelRefInputSignalDesignMin(S,3,&minValue);
    ssSetModelRefInputSignalDesignMax(S,3,&maxValue);
  }

  {
    real_T minValue = rtMinusInf;
    real_T maxValue = rtInf;
    ssSetModelRefInputSignalDesignMin(S,4,&minValue);
    ssSetModelRefInputSignalDesignMax(S,4,&maxValue);
  }

  {
    real_T minValue = rtMinusInf;
    real_T maxValue = rtInf;
    ssSetModelRefInputSignalDesignMin(S,5,&minValue);
    ssSetModelRefInputSignalDesignMax(S,5,&maxValue);
  }

  {
    real_T minValue = rtMinusInf;
    real_T maxValue = rtInf;
    ssSetModelRefOutputSignalDesignMin(S,0,&minValue);
    ssSetModelRefOutputSignalDesignMax(S,0,&maxValue);
  }

  {
    static ssRTWStorageType storageClass[7] = { SS_RTW_STORAGE_AUTO,
      SS_RTW_STORAGE_AUTO, SS_RTW_STORAGE_AUTO, SS_RTW_STORAGE_AUTO,
      SS_RTW_STORAGE_AUTO, SS_RTW_STORAGE_AUTO, SS_RTW_STORAGE_AUTO };

    ssSetModelRefPortRTWStorageClasses(S, storageClass);
  }

  ssSetNumSampleTimes(S, PORT_BASED_SAMPLE_TIMES);
  ssSetNumRWork(S, 0);
  ssSetNumIWork(S, 0);
  ssSetNumPWork(S, 0);
  ssSetNumModes(S, 0);
  ssSetNumZeroCrossingSignals(S, 2);
  ssSetZeroCrossingSignalType(S, 0, SS_SL_ZCS_TYPE_CONT);
  ssSetZeroCrossingDirection(S, 0,SS_ALL);
  ssSetZeroCrossingNeedsEvent(S, 0, 0);
  ssSetZeroCrossingSignalType(S, 1, SS_SL_ZCS_TYPE_CONT);
  ssSetZeroCrossingDirection(S, 1,SS_ALL);
  ssSetZeroCrossingNeedsEvent(S, 1, 0);
  ssSetOutputPortIsNonContinuous(S, 0, 0);
  ssSetOutputPortIsFedByBlockWithModesNoZCs(S, 0, 0);
  ssSetInputPortIsNotDerivPort(S, 0, 1);
  ssSetInputPortIsNotDerivPort(S, 1, 1);
  ssSetInputPortIsNotDerivPort(S, 2, 1);
  ssSetInputPortIsNotDerivPort(S, 3, 1);
  ssSetInputPortIsNotDerivPort(S, 4, 1);
  ssSetInputPortIsNotDerivPort(S, 5, 1);
  ssSetModelReferenceSampleTimeInheritanceRule(S,
    DISALLOW_SAMPLE_TIME_INHERITANCE);
  ssSetOptimizeModelRefInitCode(S, 0);
  ssSetModelReferenceNormalModeSupport(S, MDL_START_AND_MDL_PROCESS_PARAMS_OK);
  ssSetOptions(S, SS_OPTION_EXCEPTION_FREE_CODE |
               SS_OPTION_DISALLOW_CONSTANT_SAMPLE_TIME |
               SS_OPTION_SUPPORTS_ALIAS_DATA_TYPES |
               SS_OPTION_WORKS_WITH_CODE_REUSE |
               SS_OPTION_CALL_TERMINATE_ON_EXIT);
  if (S->mdlInfo->genericFcn != (NULL)) {
    ssRegModelRefChildModel(S,1,childModels);
  }

#if SS_SFCN_FOR_SIM

  if (S->mdlInfo->genericFcn != (NULL) &&
      ssGetSimMode(S) != SS_SIMMODE_SIZES_CALL_ONLY) {
    int_T retVal = 1;
    mr_input_signal_MdlInfoRegFcn(S, "input_signal", &retVal);
    if (!retVal)
      return;
  }

#endif

  if (!ssSetNumDWork(S, 1)) {
    return;
  }

#if SS_SFCN_FOR_SIM

  {
    int mdlrefDWTypeId;
    ssRegMdlRefDWorkType(S, &mdlrefDWTypeId);
    if (mdlrefDWTypeId == INVALID_DTYPE_ID )
      return;
    if (!ssSetDataTypeSize(S, mdlrefDWTypeId, sizeof
                           (rtMdlrefDWork_mr_input_signal)))
      return;
    ssSetDWorkDataType(S, 0, mdlrefDWTypeId);
    ssSetDWorkWidth(S, 0, 1);
  }

#endif

  ssSetNeedAbsoluteTime(S, 1);
}

static void mdlInitializeSampleTimes(SimStruct *S)
{
}

#define MDL_SET_INPUT_PORT_SAMPLE_TIME
#if defined(MATLAB_MEX_FILE)

static void mdlSetInputPortSampleTime(SimStruct *S,int_T portIdx,real_T
  sampleTime,real_T offsetTime)
{
  int i;
  for (i = 0 ; i < 6; ++i) {
    ssSetInputPortSampleTime(S,i,sampleTime);
    ssSetInputPortOffsetTime(S,i,offsetTime);
  }

  for (i = 0 ; i < 1; ++i) {
    if (ssGetOutputPortSampleTime(S,i) == rtInf &&
        ssGetOutputPortOffsetTime(S,i) == 0.0) {
      continue;
    }

    ssSetOutputPortSampleTime(S,i,sampleTime);
    ssSetOutputPortOffsetTime(S,i,offsetTime);
  }
}

#endif

#define MDL_SET_OUTPUT_PORT_SAMPLE_TIME
#if defined(MATLAB_MEX_FILE)

static void mdlSetOutputPortSampleTime(SimStruct *S,int_T portIdx,real_T
  sampleTime,real_T offsetTime)
{
  int i;
  for (i = 0 ; i < 6; ++i) {
    ssSetInputPortSampleTime(S,i,sampleTime);
    ssSetInputPortOffsetTime(S,i,offsetTime);
  }

  for (i = 0 ; i < 1; ++i) {
    if (ssGetOutputPortSampleTime(S,i) == rtInf &&
        ssGetOutputPortOffsetTime(S,i) == 0.0) {
      continue;
    }

    ssSetOutputPortSampleTime(S,i,sampleTime);
    ssSetOutputPortOffsetTime(S,i,offsetTime);
  }
}

#endif

#define MDL_SET_WORK_WIDTHS

static void mdlSetWorkWidths(SimStruct *S)
{
  if (S->mdlInfo->genericFcn != (NULL)) {
    real_T stopTime = 10.0;
    int_T hwSettings[8];
    int_T opSettings[1];
    _GenericFcn fcn = S->mdlInfo->genericFcn;
    boolean_T hasDiscTs = 0;
    if (!(fcn)(S, GEN_FCN_CHK_MODELREF_SOLVER_TYPE, 1, &hasDiscTs))
      return;
    if (!(fcn)(S, GEN_FCN_CHK_MODELREF_SOLVER_NAME, 1, (void *)
               "VariableStepDiscrete"))
      return;
    if (!(fcn)(S, GEN_FCN_CHK_MODELREF_STOP_TIME, -1, &stopTime))
      return;
    hwSettings[0] = 8;
    hwSettings[1] = 16;
    hwSettings[2] = 32;
    hwSettings[3] = 32;
    hwSettings[4] = 2;
    hwSettings[5] = 0;
    hwSettings[6] = 32;
    hwSettings[7] = 1;
    if (!(fcn)(S, GEN_FCN_CHK_MODELREF_HARDWARE_SETTINGS, 8, hwSettings))
      return;
    opSettings[0] = 0;
    if (!(fcn)(S, GEN_FCN_CHK_MODELREF_OPTIM_SETTINGS, 1, opSettings))
      return;
    ssSetSignalSizesComputeType(S, SS_VARIABLE_SIZE_FROM_INPUT_VALUE_AND_SIZE);
  }
}

#define MDL_START

static void mdlStart(SimStruct *S)
{
  rtMdlrefDWork_mr_input_signal *dw = (rtMdlrefDWork_mr_input_signal *)
    ssGetDWork(S, 0);
  void *sysRanPtr = (NULL);
  int sysTid = 0;
  ssGetContextSysRanBCPtr(S, &sysRanPtr);
  ssGetContextSysTid(S, &sysTid);

  {
    static const char* toFileNames[] = { "" };

    static const char* fromFileNames[] = { "" };

    if (!ssSetModelRefFromFiles(S, 0,fromFileNames))
      return;
    if (!ssSetModelRefToFiles(S, 0,toFileNames))
      return;
  }

  mr_input_signal_initialize(S, ssGetSampleTimeTaskID(S, 0), &(dw->rtm),
    &(dw->rtb), &(dw->rtdw), sysRanPtr, sysTid, (NULL), (NULL), 0, -1);
  ssSetModelMappingInfoPtr(S, &(dw->rtm.DataMapInfo.mmi));
  if (S->mdlInfo->genericFcn != (NULL)) {
    _GenericFcn fcn = S->mdlInfo->genericFcn;
    boolean_T hasDiscTs = 0;
    real_T startTime = 0.0;
    real_T lifeSpan = rtInf;
    ModelRefChildSolverInfo solverInfo = { 0, -1, (NULL), -1.0, 0.0001, 0.0,
      0.0001 };

    if (!(fcn)(S, GEN_FCN_CHK_MODELREF_LIFE_SPAN, -1, &lifeSpan))
      return;
    if (!(fcn)(S, GEN_FCN_CHK_MODELREF_START_TIME, -1, &startTime))
      return;
    if (!(fcn)(S, GEN_FCN_CHK_MODELREF_VSOLVER_OPTS, 0, &solverInfo))
      return;
  }
}

static void mdlOutputs(SimStruct *S, int_T tid)
{
  const real_T *InPort_0 = (real_T *) ssGetInputPortSignal(S, 0);
  const real_T *InPort_1 = (real_T *) ssGetInputPortSignal(S, 1);
  const real_T *InPort_2 = (real_T *) ssGetInputPortSignal(S, 2);
  const real_T *InPort_3 = (real_T *) ssGetInputPortSignal(S, 3);
  const real_T *InPort_4 = (real_T *) ssGetInputPortSignal(S, 4);
  const real_T *InPort_5 = (real_T *) ssGetInputPortSignal(S, 5);
  real_T *OutPort_0 = (real_T *) ssGetOutputPortSignal(S, 0);
  rtMdlrefDWork_mr_input_signal *dw = (rtMdlrefDWork_mr_input_signal *)
    ssGetDWork(S, 0);
  rtB_mr_input_signal *localB = &(dw->rtb);
  if (tid != CONSTANT_TID) {
    mr_input_signal(InPort_0, InPort_1, InPort_2, InPort_3, InPort_4, InPort_5,
                    OutPort_0, &(dw->rtm), &(dw->rtb), &(dw->rtdw));
  }
}

#define MDL_ZERO_CROSSINGS

static void mdlZeroCrossings(SimStruct *S)
{
  const real_T *InPort_1 = (real_T *) ssGetInputPortSignal(S, 1);
  const real_T *InPort_5 = (real_T *) ssGetInputPortSignal(S, 5);
  rtMdlrefDWork_mr_input_signal *dw = (rtMdlrefDWork_mr_input_signal *)
    ssGetDWork(S, 0);
  rtZCSV_mr_input_signal *rtzcsv = (rtZCSV_mr_input_signal *)ssGetNonsampledZCs
    (S);
  mr_input_signal_ZC(InPort_1, InPort_5, rtzcsv);
}

static void mdlTerminate(SimStruct *S)
{
  rtMdlrefDWork_mr_input_signal *dw = (rtMdlrefDWork_mr_input_signal *)
    ssGetDWork(S, 0);
}

#ifdef MATLAB_MEX_FILE
#include "simulink.c"
#include "fixedpoint.c"
#else
#include "cg_sfun.h"
#endif
