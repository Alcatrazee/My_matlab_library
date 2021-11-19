/*
 * sumab_terminate.c
 *
 * Code generation for function 'sumab_terminate'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "sumab.h"
#include "sumab_terminate.h"
#include "_coder_sumab_mex.h"
#include "sumab_data.h"

/* Function Definitions */
void sumab_atexit(void)
{
  emlrtStack st = { NULL, NULL, NULL };

  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtEnterRtStackR2012b(&st);

  /* Free instance data */
  covrtFreeInstanceData(&emlrtCoverageInstance);
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

void sumab_terminate(void)
{
  emlrtStack st = { NULL, NULL, NULL };

  st.tls = emlrtRootTLSGlobal;
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (sumab_terminate.c) */
