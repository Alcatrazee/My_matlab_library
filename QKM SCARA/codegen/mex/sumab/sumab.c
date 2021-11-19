/*
 * sumab.c
 *
 * Code generation for function 'sumab'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "sumab.h"
#include "sumab_data.h"

/* Function Definitions */
real_T sumab(const emlrtStack *sp, real_T a, real_T b)
{
  (void)sp;
  covrtLogFcn(&emlrtCoverageInstance, 0U, 0);
  covrtLogBasicBlock(&emlrtCoverageInstance, 0U, 0);
  return a + b;
}

/* End of code generation (sumab.c) */
