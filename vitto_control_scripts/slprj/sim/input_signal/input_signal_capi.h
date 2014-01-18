#ifndef _RTW_HEADER_input_signal_capi_h_
#define _RTW_HEADER_input_signal_capi_h_
#include "input_signal.h"

extern void input_signal_InitializeDataMapInfo(RT_MODEL_input_signal
  *input_signal_M
  , rtDW_mr_input_signal *localDW, void *sysRanPtr, int contextTid);

#endif

