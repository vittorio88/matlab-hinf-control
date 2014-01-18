#ifndef RTW_HEADER_input_signal_private_h_
#define RTW_HEADER_input_signal_private_h_
#include "rtwtypes.h"

#ifndef rtmIsFirstInitCond
# define rtmIsFirstInitCond(rtm)       ssIsFirstInitCond((rtm)->_mdlRefSfcnS)
#endif

#ifndef rtmIsMajorTimeStep
# define rtmIsMajorTimeStep(rtm)       ssIsMajorTimeStep((rtm)->_mdlRefSfcnS)
#endif

#ifndef rtmIsMinorTimeStep
# define rtmIsMinorTimeStep(rtm)       ssIsMinorTimeStep((rtm)->_mdlRefSfcnS)
#endif

#ifndef rtmIsSampleHit
# define rtmIsSampleHit(rtm, sti, tid) ( (ssGetSampleHitPtr((rtm)->_mdlRefSfcnS))[input_signal_GlobalTID[sti]] == 1 )
#endif

#ifndef __RTWTYPES_H__
#error This file requires rtwtypes.h to be included
#else
#ifdef TMWTYPES_PREVIOUSLY_INCLUDED
#error This file requires rtwtypes.h to be included before tmwtypes.h
#else

#ifndef RTWTYPES_ID_C08S16I32L32N32F1
#error This code was generated with a different "rtwtypes.h" than the file included
#endif
#endif
#endif

#ifndef rtmGetDataMapInfo
# define rtmGetDataMapInfo(rtm)        ((rtm)->DataMapInfo)
#endif

#ifndef rtmSetDataMapInfo
# define rtmSetDataMapInfo(rtm, val)   ((rtm)->DataMapInfo = (val))
#endif

#ifndef rtmGetClockTick0
# define rtmGetClockTick0(rtm)         ( *((ssGetTimingBridge((rtm)->_mdlRefSfcnS)->clockTick[input_signal_GlobalTID[0]])) )
#endif

#ifndef rtmGetClockTickH0
# define rtmGetClockTickH0(rtm)        ( *(ssGetTimingBridge((rtm)->_mdlRefSfcnS)->clockTickH[input_signal_GlobalTID[0]]) )
#endif

#ifndef rtmGetLogOutput
# define rtmGetLogOutput(rtm)          ssGetLogOutput((rtm)->_mdlRefSfcnS)
#endif

#ifndef rtmGetT
# define rtmGetT(rtm)                  (ssGetT((rtm)->_mdlRefSfcnS))
#endif

#ifndef rtmGetTFinal
# define rtmGetTFinal(rtm)             (ssGetTFinal((rtm)->_mdlRefSfcnS))
#endif

#ifndef rtmGetTStart
# define rtmGetTStart(rtm)             (ssGetTStart((rtm)->_mdlRefSfcnS))
#endif

#ifndef rtmGetTaskTime
# define rtmGetTaskTime(rtm, sti)      (ssGetTPtr((rtm)->_mdlRefSfcnS))[input_signal_GlobalTID[sti]]
#endif

#ifndef rtmGetTimeOfLastOutput
# define rtmGetTimeOfLastOutput(rtm)   (ssGetTimeOfLastOutput((rtm)->_mdlRefSfcnS))
#endif

extern int_T input_signal_GlobalTID[1];

#endif
