/*
 * File: _coder_sumab_api.h
 *
 * MATLAB Coder version            : 3.1
 * C/C++ source code generated on  : 30-Nov-2017 18:44:53
 */

#ifndef _CODER_SUMAB_API_H
#define _CODER_SUMAB_API_H

/* Include Files */
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include <stddef.h>
#include <stdlib.h>
#include "_coder_sumab_api.h"

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

/* Function Declarations */
extern real_T sumab(real_T a, real_T b);
extern void sumab_api(const mxArray * const prhs[2], const mxArray *plhs[1]);
extern void sumab_atexit(void);
extern void sumab_initialize(void);
extern void sumab_terminate(void);
extern void sumab_xil_terminate(void);

#endif

/*
 * File trailer for _coder_sumab_api.h
 *
 * [EOF]
 */
