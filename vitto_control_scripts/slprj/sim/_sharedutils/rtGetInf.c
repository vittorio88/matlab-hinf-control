/*
 * rtGetInf.c
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
 *      Real-Time Workshop function to intialize non-finite, Inf
 */
#include "rtGetInf.h"
#define NumBitsPerChar                 8

real_T rtGetInf(void)
{
  size_t bitsPerReal = sizeof(real_T) * (NumBitsPerChar);
  real_T inf = 0.0;
  if (bitsPerReal == 32) {
    inf = rtGetInfF();
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

    tmpVal.bitVal.words.wordH = 0x7FF00000;
    tmpVal.bitVal.words.wordL = 0x00000000;
    inf = tmpVal.fltVal;
  }

  return inf;
}

real32_T rtGetInfF(void)
{
  typedef struct {
    union {
      real32_T wordLreal;
      uint32_T wordLuint;
    } wordL;
  } IEEESingle;

  IEEESingle infF;
  infF.wordL.wordLuint = 0x7F800000;
  return infF.wordL.wordLreal;
}

real_T rtGetMinusInf(void)
{
  size_t bitsPerReal = sizeof(real_T) * (NumBitsPerChar);
  real_T minf = 0.0;
  if (bitsPerReal == 32) {
    minf = rtGetMinusInfF();
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

    tmpVal.bitVal.words.wordH = 0xFFF00000;
    tmpVal.bitVal.words.wordL = 0x00000000;
    minf = tmpVal.fltVal;
  }

  return minf;
}

real32_T rtGetMinusInfF(void)
{
  typedef struct {
    union {
      real32_T wordLreal;
      uint32_T wordLuint;
    } wordL;
  } IEEESingle;

  IEEESingle minfF;
  minfF.wordL.wordLuint = 0xFF800000;
  return minfF.wordL.wordLreal;
}

/* end rtGetInf.c */
