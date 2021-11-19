/*
 * sumab_initialize.c
 *
 * Code generation for function 'sumab_initialize'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "sumab.h"
#include "sumab_initialize.h"
#include "_coder_sumab_mex.h"
#include "sumab_data.h"

/* Function Declarations */
static void sumab_once(void);

/* Function Definitions */
static void sumab_once(void)
{
  /* Allocate instance data */
  covrtAllocateInstanceData(&emlrtCoverageInstance);

  /* Initialize Coverage Information */
  covrtScriptInit(&emlrtCoverageInstance,
                  "E:\\matlab program\\QKM SCARA\\sumab.m", 0, 1, 1, 0, 0, 0, 0,
                  0, 0, 0, 0);

  /* Initialize Function Information */
  covrtFcnInit(&emlrtCoverageInstance, 0, 0, "sumab", 0, -1, 34);

  /* Initialize Basic Block Information */
  covrtBasicBlockInit(&emlrtCoverageInstance, 0, 0, 26, -1, 33);

  /* Initialize If Information */
  /* Initialize MCDC Information */
  /* Initialize For Information */
  /* Initialize While Information */
  /* Initialize Switch Information */
  /* Start callback for coverage engine */
  covrtScriptStart(&emlrtCoverageInstance, 0U);
}

void sumab_initialize(void)
{
  emlrtStack st = { NULL, NULL, NULL };

  mexFunctionCreateRootTLS();
  emlrtBreakCheckR2012bFlagVar = emlrtGetBreakCheckFlagAddressR2012b();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, 0);
  emlrtEnterRtStackR2012b(&st);
  if (emlrtFirstTimeR2012b(emlrtRootTLSGlobal)) {
    sumab_once();
  }
}

/* End of code generation (sumab_initialize.c) */
