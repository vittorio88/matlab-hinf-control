/*
 * rtGetNaN.c
 *
 * Real-Time Workshop code generation for Simulink model "input_signal.mdl".
 *
 * Model Version              : 1.11
 * Real-Time Workshop version : 7.4  (R2009b)  29-Jun-2009
 * C source code generated on : Sun Sep 01 18:40:04 2013
 *
 */

/*
 * Abstract:
 *      Real-Time Workshop function to intialize non-finite, NaN
 */
#include "rtGetNaN.h"
#define NumBitsPerChar                 8

real_T rtGetNaN(void)
{
  size_t bitsPerReal = sizeof(real_T) * (NumBitsPerChar);
  real_T nan = 0.0;
  if (bitsPerReal == 32) {
    nan = rtGetNaNF();
  } else {
    typedef struct {
      struct {
        uint32_T wordL;
        uint32_T wordH;
      } words;
    } LittleEndianIEEEDouble;

    union {
      LittleEndianIEEEDouble bitVal;
      real_T fltVal;
    } tmpVal;

    tmpVal.bitVal.words.wordH = 0xFFF80000;
    tmpVal.bitVal.words.wordL = 0x00000000;
    nan = tmpVal.fltVal;
  }

  return nan;
}

real32_T rtGetNaNF(void)
{
  typedef struct {
    union {
      real32_T wordLreal;
      uint32_T wordLuint;
    } wordL;
  } IEEESingle;

  IEEESingle nanF;
  nanF.wordL.wordLuint = 0xFFC00000;
  return nanF.wordL.wordLreal;
}

/* end rt_getNaN.c */
