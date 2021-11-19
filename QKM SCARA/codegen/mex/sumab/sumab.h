/*
 * sumab.h
 *
 * Code generation for function 'sumab'
 *
 */

#ifndef SUMAB_H
#define SUMAB_H

/* Include files */
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include "covrt.h"
#include "rtwtypes.h"
#include "sumab_types.h"

/* Function Declarations */
extern real_T sumab(const emlrtStack *sp, real_T a, real_T b);

#ifdef __WATCOMC__

#pragma aux sumab value [8087];

#endif
#endif

/* End of code generation (sumab.h) */
