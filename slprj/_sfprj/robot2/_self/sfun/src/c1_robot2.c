/* Include files */

#include "robot2_sfun.h"
#include "c1_robot2.h"
#include "mwmathutil.h"
#define CHARTINSTANCE_CHARTNUMBER      (chartInstance->chartNumber)
#define CHARTINSTANCE_INSTANCENUMBER   (chartInstance->instanceNumber)
#include "robot2_sfun_debug_macros.h"
#define _SF_MEX_LISTEN_FOR_CTRL_C(S)   sf_mex_listen_for_ctrl_c_with_debugger(S, sfGlobalDebugInstanceStruct);

static void chart_debug_initialization(SimStruct *S, unsigned int
  fullDebuggerInitialization);
static void chart_debug_initialize_data_addresses(SimStruct *S);
static const mxArray* sf_opaque_get_hover_data_for_msg(void *chartInstance,
  int32_T msgSSID);

/* Type Definitions */

/* Named Constants */
#define CALL_EVENT                     (-1)

/* Variable Declarations */

/* Variable Definitions */
static real_T _sfTime_;
static const char * c1_debug_family_names[12] = { "transfer_matrix",
  "inverse_model", "result", "nargin", "nargout", "Des_vxr", "Des_vyr",
  "Des_thetar", "L", "V1", "V2", "V3" };

/* Function Declarations */
static void initialize_c1_robot2(SFc1_robot2InstanceStruct *chartInstance);
static void initialize_params_c1_robot2(SFc1_robot2InstanceStruct *chartInstance);
static void enable_c1_robot2(SFc1_robot2InstanceStruct *chartInstance);
static void disable_c1_robot2(SFc1_robot2InstanceStruct *chartInstance);
static void c1_update_debugger_state_c1_robot2(SFc1_robot2InstanceStruct
  *chartInstance);
static const mxArray *get_sim_state_c1_robot2(SFc1_robot2InstanceStruct
  *chartInstance);
static void set_sim_state_c1_robot2(SFc1_robot2InstanceStruct *chartInstance,
  const mxArray *c1_st);
static void finalize_c1_robot2(SFc1_robot2InstanceStruct *chartInstance);
static void sf_gateway_c1_robot2(SFc1_robot2InstanceStruct *chartInstance);
static void mdl_start_c1_robot2(SFc1_robot2InstanceStruct *chartInstance);
static void c1_chartstep_c1_robot2(SFc1_robot2InstanceStruct *chartInstance);
static void initSimStructsc1_robot2(SFc1_robot2InstanceStruct *chartInstance);
static void init_script_number_translation(uint32_T c1_machineNumber, uint32_T
  c1_chartNumber, uint32_T c1_instanceNumber);
static const mxArray *c1_sf_marshallOut(void *chartInstanceVoid, void *c1_inData);
static real_T c1_emlrt_marshallIn(SFc1_robot2InstanceStruct *chartInstance,
  const mxArray *c1_b_V3, const char_T *c1_identifier);
static real_T c1_b_emlrt_marshallIn(SFc1_robot2InstanceStruct *chartInstance,
  const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId);
static void c1_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData);
static const mxArray *c1_b_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData);
static void c1_c_emlrt_marshallIn(SFc1_robot2InstanceStruct *chartInstance,
  const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId, real_T c1_y[3]);
static void c1_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData);
static const mxArray *c1_c_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData);
static void c1_d_emlrt_marshallIn(SFc1_robot2InstanceStruct *chartInstance,
  const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId, real_T c1_y[9]);
static void c1_c_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData);
static void c1_inv3x3(SFc1_robot2InstanceStruct *chartInstance, real_T c1_x[9],
                      real_T c1_y[9]);
static real_T c1_abs(SFc1_robot2InstanceStruct *chartInstance, real_T c1_x);
static real_T c1_norm(SFc1_robot2InstanceStruct *chartInstance, real_T c1_x[9]);
static void c1_warning(SFc1_robot2InstanceStruct *chartInstance);
static void c1_b_warning(SFc1_robot2InstanceStruct *chartInstance, char_T
  c1_varargin_1[14]);
static void c1_scalarEg(SFc1_robot2InstanceStruct *chartInstance);
static void c1_b_scalarEg(SFc1_robot2InstanceStruct *chartInstance);
static void c1_e_emlrt_marshallIn(SFc1_robot2InstanceStruct *chartInstance,
  const mxArray *c1_sprintf, const char_T *c1_identifier, char_T c1_y[14]);
static void c1_f_emlrt_marshallIn(SFc1_robot2InstanceStruct *chartInstance,
  const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId, char_T c1_y[14]);
static const mxArray *c1_d_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData);
static int32_T c1_g_emlrt_marshallIn(SFc1_robot2InstanceStruct *chartInstance,
  const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId);
static void c1_d_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData);
static uint8_T c1_h_emlrt_marshallIn(SFc1_robot2InstanceStruct *chartInstance,
  const mxArray *c1_b_is_active_c1_robot2, const char_T *c1_identifier);
static uint8_T c1_i_emlrt_marshallIn(SFc1_robot2InstanceStruct *chartInstance,
  const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId);
static void init_dsm_address_info(SFc1_robot2InstanceStruct *chartInstance);
static void init_simulink_io_address(SFc1_robot2InstanceStruct *chartInstance);

/* Function Definitions */
static void initialize_c1_robot2(SFc1_robot2InstanceStruct *chartInstance)
{
  if (sf_is_first_init_cond(chartInstance->S)) {
    initSimStructsc1_robot2(chartInstance);
    chart_debug_initialize_data_addresses(chartInstance->S);
  }

  chartInstance->c1_sfEvent = CALL_EVENT;
  _sfTime_ = sf_get_time(chartInstance->S);
  chartInstance->c1_is_active_c1_robot2 = 0U;
}

static void initialize_params_c1_robot2(SFc1_robot2InstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void enable_c1_robot2(SFc1_robot2InstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void disable_c1_robot2(SFc1_robot2InstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void c1_update_debugger_state_c1_robot2(SFc1_robot2InstanceStruct
  *chartInstance)
{
  (void)chartInstance;
}

static const mxArray *get_sim_state_c1_robot2(SFc1_robot2InstanceStruct
  *chartInstance)
{
  const mxArray *c1_st;
  const mxArray *c1_y = NULL;
  real_T c1_hoistedGlobal;
  real_T c1_u;
  const mxArray *c1_b_y = NULL;
  real_T c1_b_hoistedGlobal;
  real_T c1_b_u;
  const mxArray *c1_c_y = NULL;
  real_T c1_c_hoistedGlobal;
  real_T c1_c_u;
  const mxArray *c1_d_y = NULL;
  uint8_T c1_d_hoistedGlobal;
  uint8_T c1_d_u;
  const mxArray *c1_e_y = NULL;
  c1_st = NULL;
  c1_st = NULL;
  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_createcellmatrix(4, 1), false);
  c1_hoistedGlobal = *chartInstance->c1_V1;
  c1_u = c1_hoistedGlobal;
  c1_b_y = NULL;
  sf_mex_assign(&c1_b_y, sf_mex_create("y", &c1_u, 0, 0U, 0U, 0U, 0), false);
  sf_mex_setcell(c1_y, 0, c1_b_y);
  c1_b_hoistedGlobal = *chartInstance->c1_V2;
  c1_b_u = c1_b_hoistedGlobal;
  c1_c_y = NULL;
  sf_mex_assign(&c1_c_y, sf_mex_create("y", &c1_b_u, 0, 0U, 0U, 0U, 0), false);
  sf_mex_setcell(c1_y, 1, c1_c_y);
  c1_c_hoistedGlobal = *chartInstance->c1_V3;
  c1_c_u = c1_c_hoistedGlobal;
  c1_d_y = NULL;
  sf_mex_assign(&c1_d_y, sf_mex_create("y", &c1_c_u, 0, 0U, 0U, 0U, 0), false);
  sf_mex_setcell(c1_y, 2, c1_d_y);
  c1_d_hoistedGlobal = chartInstance->c1_is_active_c1_robot2;
  c1_d_u = c1_d_hoistedGlobal;
  c1_e_y = NULL;
  sf_mex_assign(&c1_e_y, sf_mex_create("y", &c1_d_u, 3, 0U, 0U, 0U, 0), false);
  sf_mex_setcell(c1_y, 3, c1_e_y);
  sf_mex_assign(&c1_st, c1_y, false);
  return c1_st;
}

static void set_sim_state_c1_robot2(SFc1_robot2InstanceStruct *chartInstance,
  const mxArray *c1_st)
{
  const mxArray *c1_u;
  chartInstance->c1_doneDoubleBufferReInit = true;
  c1_u = sf_mex_dup(c1_st);
  *chartInstance->c1_V1 = c1_emlrt_marshallIn(chartInstance, sf_mex_dup
    (sf_mex_getcell("V1", c1_u, 0)), "V1");
  *chartInstance->c1_V2 = c1_emlrt_marshallIn(chartInstance, sf_mex_dup
    (sf_mex_getcell("V2", c1_u, 1)), "V2");
  *chartInstance->c1_V3 = c1_emlrt_marshallIn(chartInstance, sf_mex_dup
    (sf_mex_getcell("V3", c1_u, 2)), "V3");
  chartInstance->c1_is_active_c1_robot2 = c1_h_emlrt_marshallIn(chartInstance,
    sf_mex_dup(sf_mex_getcell("is_active_c1_robot2", c1_u, 3)),
    "is_active_c1_robot2");
  sf_mex_destroy(&c1_u);
  c1_update_debugger_state_c1_robot2(chartInstance);
  sf_mex_destroy(&c1_st);
}

static void finalize_c1_robot2(SFc1_robot2InstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void sf_gateway_c1_robot2(SFc1_robot2InstanceStruct *chartInstance)
{
  _SFD_SYMBOL_SCOPE_PUSH(0U, 0U);
  _sfTime_ = sf_get_time(chartInstance->S);
  _SFD_CC_CALL(CHART_ENTER_SFUNCTION_TAG, 0U, chartInstance->c1_sfEvent);
  _SFD_DATA_RANGE_CHECK(*chartInstance->c1_L, 3U, 1U, 0U,
                        chartInstance->c1_sfEvent, false);
  _SFD_DATA_RANGE_CHECK(*chartInstance->c1_Des_thetar, 2U, 1U, 0U,
                        chartInstance->c1_sfEvent, false);
  _SFD_DATA_RANGE_CHECK(*chartInstance->c1_Des_vyr, 1U, 1U, 0U,
                        chartInstance->c1_sfEvent, false);
  _SFD_DATA_RANGE_CHECK(*chartInstance->c1_Des_vxr, 0U, 1U, 0U,
                        chartInstance->c1_sfEvent, false);
  chartInstance->c1_sfEvent = CALL_EVENT;
  c1_chartstep_c1_robot2(chartInstance);
  _SFD_SYMBOL_SCOPE_POP();
  _SFD_CHECK_FOR_STATE_INCONSISTENCY(_robot2MachineNumber_,
    chartInstance->chartNumber, chartInstance->instanceNumber);
  _SFD_DATA_RANGE_CHECK(*chartInstance->c1_V1, 4U, 1U, 0U,
                        chartInstance->c1_sfEvent, false);
  _SFD_DATA_RANGE_CHECK(*chartInstance->c1_V2, 5U, 1U, 0U,
                        chartInstance->c1_sfEvent, false);
  _SFD_DATA_RANGE_CHECK(*chartInstance->c1_V3, 6U, 1U, 0U,
                        chartInstance->c1_sfEvent, false);
}

static void mdl_start_c1_robot2(SFc1_robot2InstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void c1_chartstep_c1_robot2(SFc1_robot2InstanceStruct *chartInstance)
{
  real_T c1_hoistedGlobal;
  real_T c1_b_hoistedGlobal;
  real_T c1_c_hoistedGlobal;
  real_T c1_d_hoistedGlobal;
  real_T c1_b_Des_vxr;
  real_T c1_b_Des_vyr;
  real_T c1_b_Des_thetar;
  real_T c1_b_L;
  uint32_T c1_debug_family_var_map[12];
  real_T c1_transfer_matrix[9];
  real_T c1_inverse_model[9];
  real_T c1_result[3];
  real_T c1_nargin = 4.0;
  real_T c1_nargout = 3.0;
  real_T c1_b_V1;
  real_T c1_b_V2;
  real_T c1_b_V3;
  real_T c1_B;
  real_T c1_y;
  real_T c1_b_y;
  real_T c1_c_y;
  real_T c1_b_B;
  real_T c1_d_y;
  real_T c1_e_y;
  real_T c1_f_y;
  real_T c1_c_B;
  real_T c1_g_y;
  real_T c1_h_y;
  real_T c1_i_y;
  int32_T c1_i0;
  int32_T c1_i1;
  int32_T c1_i2;
  static real_T c1_dv0[3] = { 0.86602540378443871, -0.86602540378443871,
    -1.8369701987210297E-16 };

  int32_T c1_i3;
  static real_T c1_dv1[3] = { 0.49999999999999994, 0.49999999999999994, -1.0 };

  int32_T c1_i4;
  int32_T c1_i5;
  real_T c1_x[9];
  real_T c1_b_x[9];
  real_T c1_dv2[9];
  int32_T c1_i6;
  int32_T c1_i7;
  real_T c1_n1x;
  real_T c1_xinv[9];
  real_T c1_n1xinv;
  real_T c1_rc;
  real_T c1_c_x;
  boolean_T c1_b;
  int32_T c1_i8;
  real_T c1_d_x;
  const mxArray *c1_j_y = NULL;
  static char_T c1_rfmt[6] = { '%', '1', '4', '.', '6', 'e' };

  real_T c1_c_Des_vxr[3];
  real_T c1_u;
  const mxArray *c1_k_y = NULL;
  int32_T c1_i9;
  char_T c1_str[14];
  int32_T c1_i10;
  real_T c1_b_b[3];
  int32_T c1_i11;
  int32_T c1_i12;
  int32_T c1_i13;
  real_T c1_C[3];
  int32_T c1_i14;
  int32_T c1_i15;
  int32_T c1_i16;
  boolean_T guard1 = false;
  boolean_T guard2 = false;
  boolean_T guard3 = false;
  _SFD_CC_CALL(CHART_ENTER_DURING_FUNCTION_TAG, 0U, chartInstance->c1_sfEvent);
  c1_hoistedGlobal = *chartInstance->c1_Des_vxr;
  c1_b_hoistedGlobal = *chartInstance->c1_Des_vyr;
  c1_c_hoistedGlobal = *chartInstance->c1_Des_thetar;
  c1_d_hoistedGlobal = *chartInstance->c1_L;
  c1_b_Des_vxr = c1_hoistedGlobal;
  c1_b_Des_vyr = c1_b_hoistedGlobal;
  c1_b_Des_thetar = c1_c_hoistedGlobal;
  c1_b_L = c1_d_hoistedGlobal;
  _SFD_SYMBOL_SCOPE_PUSH_EML(0U, 12U, 12U, c1_debug_family_names,
    c1_debug_family_var_map);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c1_transfer_matrix, 0U,
    c1_c_sf_marshallOut, c1_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c1_inverse_model, 1U, c1_c_sf_marshallOut,
    c1_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c1_result, 2U, c1_b_sf_marshallOut,
    c1_b_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c1_nargin, 3U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c1_nargout, 4U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c1_b_Des_vxr, 5U, c1_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c1_b_Des_vyr, 6U, c1_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c1_b_Des_thetar, 7U, c1_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c1_b_L, 8U, c1_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c1_b_V1, 9U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c1_b_V2, 10U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c1_b_V3, 11U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  CV_EML_FCN(0, 0);
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 3);
  c1_B = 3.0 * c1_b_L;
  c1_y = c1_B;
  c1_b_y = c1_y;
  c1_c_y = 1.0 / c1_b_y;
  c1_b_B = 3.0 * c1_b_L;
  c1_d_y = c1_b_B;
  c1_e_y = c1_d_y;
  c1_f_y = 1.0 / c1_e_y;
  c1_c_B = 3.0 * c1_b_L;
  c1_g_y = c1_c_B;
  c1_h_y = c1_g_y;
  c1_i_y = 1.0 / c1_h_y;
  c1_i0 = 0;
  for (c1_i1 = 0; c1_i1 < 3; c1_i1++) {
    c1_transfer_matrix[c1_i0] = c1_dv0[c1_i1];
    c1_i0 += 3;
  }

  c1_i2 = 0;
  for (c1_i3 = 0; c1_i3 < 3; c1_i3++) {
    c1_transfer_matrix[c1_i2 + 1] = c1_dv1[c1_i3];
    c1_i2 += 3;
  }

  c1_transfer_matrix[2] = c1_c_y;
  c1_transfer_matrix[5] = c1_f_y;
  c1_transfer_matrix[8] = c1_i_y;
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 7);
  for (c1_i4 = 0; c1_i4 < 9; c1_i4++) {
    c1_x[c1_i4] = c1_transfer_matrix[c1_i4];
  }

  for (c1_i5 = 0; c1_i5 < 9; c1_i5++) {
    c1_b_x[c1_i5] = c1_x[c1_i5];
  }

  c1_inv3x3(chartInstance, c1_b_x, c1_dv2);
  for (c1_i6 = 0; c1_i6 < 9; c1_i6++) {
    c1_inverse_model[c1_i6] = c1_dv2[c1_i6];
  }

  for (c1_i7 = 0; c1_i7 < 9; c1_i7++) {
    c1_xinv[c1_i7] = c1_inverse_model[c1_i7];
  }

  c1_n1x = c1_norm(chartInstance, c1_x);
  c1_n1xinv = c1_norm(chartInstance, c1_xinv);
  c1_rc = 1.0 / (c1_n1x * c1_n1xinv);
  guard1 = false;
  guard2 = false;
  if (c1_n1x == 0.0) {
    guard2 = true;
  } else if (c1_n1xinv == 0.0) {
    guard2 = true;
  } else if (c1_rc == 0.0) {
    guard1 = true;
  } else {
    c1_c_x = c1_rc;
    c1_b = muDoubleScalarIsNaN(c1_c_x);
    guard3 = false;
    if (c1_b) {
      guard3 = true;
    } else {
      if (c1_rc < 2.2204460492503131E-16) {
        guard3 = true;
      }
    }

    if (guard3 == true) {
      c1_d_x = c1_rc;
      c1_j_y = NULL;
      sf_mex_assign(&c1_j_y, sf_mex_create("y", c1_rfmt, 10, 0U, 1U, 0U, 2, 1, 6),
                    false);
      c1_u = c1_d_x;
      c1_k_y = NULL;
      sf_mex_assign(&c1_k_y, sf_mex_create("y", &c1_u, 0, 0U, 0U, 0U, 0), false);
      c1_e_emlrt_marshallIn(chartInstance, sf_mex_call_debug
                            (sfGlobalDebugInstanceStruct, "sprintf", 1U, 2U, 14,
        c1_j_y, 14, c1_k_y), "sprintf", c1_str);
      c1_b_warning(chartInstance, c1_str);
    }
  }

  if (guard2 == true) {
    guard1 = true;
  }

  if (guard1 == true) {
    c1_warning(chartInstance);
  }

  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 10);
  for (c1_i8 = 0; c1_i8 < 9; c1_i8++) {
    c1_x[c1_i8] = c1_inverse_model[c1_i8];
  }

  c1_c_Des_vxr[0] = c1_b_Des_vxr;
  c1_c_Des_vxr[1] = c1_b_Des_vyr;
  c1_c_Des_vxr[2] = c1_b_Des_thetar;
  for (c1_i9 = 0; c1_i9 < 3; c1_i9++) {
    c1_b_b[c1_i9] = c1_c_Des_vxr[c1_i9];
  }

  for (c1_i10 = 0; c1_i10 < 3; c1_i10++) {
    c1_result[c1_i10] = 0.0;
  }

  for (c1_i11 = 0; c1_i11 < 3; c1_i11++) {
    c1_result[c1_i11] = 0.0;
  }

  for (c1_i12 = 0; c1_i12 < 3; c1_i12++) {
    c1_C[c1_i12] = c1_result[c1_i12];
  }

  for (c1_i13 = 0; c1_i13 < 3; c1_i13++) {
    c1_result[c1_i13] = c1_C[c1_i13];
  }

  for (c1_i14 = 0; c1_i14 < 3; c1_i14++) {
    c1_result[c1_i14] = 0.0;
    c1_i15 = 0;
    for (c1_i16 = 0; c1_i16 < 3; c1_i16++) {
      c1_result[c1_i14] += c1_x[c1_i15 + c1_i14] * c1_b_b[c1_i16];
      c1_i15 += 3;
    }
  }

  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 12);
  c1_b_V1 = c1_result[0];
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 13);
  c1_b_V2 = c1_result[1];
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 14);
  c1_b_V3 = c1_result[2];
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, -14);
  _SFD_SYMBOL_SCOPE_POP();
  *chartInstance->c1_V1 = c1_b_V1;
  *chartInstance->c1_V2 = c1_b_V2;
  *chartInstance->c1_V3 = c1_b_V3;
  _SFD_CC_CALL(EXIT_OUT_OF_FUNCTION_TAG, 0U, chartInstance->c1_sfEvent);
}

static void initSimStructsc1_robot2(SFc1_robot2InstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void init_script_number_translation(uint32_T c1_machineNumber, uint32_T
  c1_chartNumber, uint32_T c1_instanceNumber)
{
  (void)c1_machineNumber;
  (void)c1_chartNumber;
  (void)c1_instanceNumber;
}

static const mxArray *c1_sf_marshallOut(void *chartInstanceVoid, void *c1_inData)
{
  const mxArray *c1_mxArrayOutData = NULL;
  real_T c1_u;
  const mxArray *c1_y = NULL;
  SFc1_robot2InstanceStruct *chartInstance;
  chartInstance = (SFc1_robot2InstanceStruct *)chartInstanceVoid;
  c1_mxArrayOutData = NULL;
  c1_u = *(real_T *)c1_inData;
  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_create("y", &c1_u, 0, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c1_mxArrayOutData, c1_y, false);
  return c1_mxArrayOutData;
}

static real_T c1_emlrt_marshallIn(SFc1_robot2InstanceStruct *chartInstance,
  const mxArray *c1_b_V3, const char_T *c1_identifier)
{
  real_T c1_y;
  emlrtMsgIdentifier c1_thisId;
  c1_thisId.fIdentifier = c1_identifier;
  c1_thisId.fParent = NULL;
  c1_thisId.bParentIsCell = false;
  c1_y = c1_b_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_b_V3), &c1_thisId);
  sf_mex_destroy(&c1_b_V3);
  return c1_y;
}

static real_T c1_b_emlrt_marshallIn(SFc1_robot2InstanceStruct *chartInstance,
  const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId)
{
  real_T c1_y;
  real_T c1_d0;
  (void)chartInstance;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_u), &c1_d0, 1, 0, 0U, 0, 0U, 0);
  c1_y = c1_d0;
  sf_mex_destroy(&c1_u);
  return c1_y;
}

static void c1_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData)
{
  const mxArray *c1_b_V3;
  const char_T *c1_identifier;
  emlrtMsgIdentifier c1_thisId;
  real_T c1_y;
  SFc1_robot2InstanceStruct *chartInstance;
  chartInstance = (SFc1_robot2InstanceStruct *)chartInstanceVoid;
  c1_b_V3 = sf_mex_dup(c1_mxArrayInData);
  c1_identifier = c1_varName;
  c1_thisId.fIdentifier = c1_identifier;
  c1_thisId.fParent = NULL;
  c1_thisId.bParentIsCell = false;
  c1_y = c1_b_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_b_V3), &c1_thisId);
  sf_mex_destroy(&c1_b_V3);
  *(real_T *)c1_outData = c1_y;
  sf_mex_destroy(&c1_mxArrayInData);
}

static const mxArray *c1_b_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData)
{
  const mxArray *c1_mxArrayOutData = NULL;
  int32_T c1_i17;
  const mxArray *c1_y = NULL;
  real_T c1_u[3];
  SFc1_robot2InstanceStruct *chartInstance;
  chartInstance = (SFc1_robot2InstanceStruct *)chartInstanceVoid;
  c1_mxArrayOutData = NULL;
  for (c1_i17 = 0; c1_i17 < 3; c1_i17++) {
    c1_u[c1_i17] = (*(real_T (*)[3])c1_inData)[c1_i17];
  }

  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_create("y", c1_u, 0, 0U, 1U, 0U, 1, 3), false);
  sf_mex_assign(&c1_mxArrayOutData, c1_y, false);
  return c1_mxArrayOutData;
}

static void c1_c_emlrt_marshallIn(SFc1_robot2InstanceStruct *chartInstance,
  const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId, real_T c1_y[3])
{
  real_T c1_dv3[3];
  int32_T c1_i18;
  (void)chartInstance;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_u), c1_dv3, 1, 0, 0U, 1, 0U, 1, 3);
  for (c1_i18 = 0; c1_i18 < 3; c1_i18++) {
    c1_y[c1_i18] = c1_dv3[c1_i18];
  }

  sf_mex_destroy(&c1_u);
}

static void c1_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData)
{
  const mxArray *c1_result;
  const char_T *c1_identifier;
  emlrtMsgIdentifier c1_thisId;
  real_T c1_y[3];
  int32_T c1_i19;
  SFc1_robot2InstanceStruct *chartInstance;
  chartInstance = (SFc1_robot2InstanceStruct *)chartInstanceVoid;
  c1_result = sf_mex_dup(c1_mxArrayInData);
  c1_identifier = c1_varName;
  c1_thisId.fIdentifier = c1_identifier;
  c1_thisId.fParent = NULL;
  c1_thisId.bParentIsCell = false;
  c1_c_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_result), &c1_thisId, c1_y);
  sf_mex_destroy(&c1_result);
  for (c1_i19 = 0; c1_i19 < 3; c1_i19++) {
    (*(real_T (*)[3])c1_outData)[c1_i19] = c1_y[c1_i19];
  }

  sf_mex_destroy(&c1_mxArrayInData);
}

static const mxArray *c1_c_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData)
{
  const mxArray *c1_mxArrayOutData = NULL;
  int32_T c1_i20;
  int32_T c1_i21;
  const mxArray *c1_y = NULL;
  int32_T c1_i22;
  real_T c1_u[9];
  SFc1_robot2InstanceStruct *chartInstance;
  chartInstance = (SFc1_robot2InstanceStruct *)chartInstanceVoid;
  c1_mxArrayOutData = NULL;
  c1_i20 = 0;
  for (c1_i21 = 0; c1_i21 < 3; c1_i21++) {
    for (c1_i22 = 0; c1_i22 < 3; c1_i22++) {
      c1_u[c1_i22 + c1_i20] = (*(real_T (*)[9])c1_inData)[c1_i22 + c1_i20];
    }

    c1_i20 += 3;
  }

  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_create("y", c1_u, 0, 0U, 1U, 0U, 2, 3, 3), false);
  sf_mex_assign(&c1_mxArrayOutData, c1_y, false);
  return c1_mxArrayOutData;
}

static void c1_d_emlrt_marshallIn(SFc1_robot2InstanceStruct *chartInstance,
  const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId, real_T c1_y[9])
{
  real_T c1_dv4[9];
  int32_T c1_i23;
  (void)chartInstance;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_u), c1_dv4, 1, 0, 0U, 1, 0U, 2, 3, 3);
  for (c1_i23 = 0; c1_i23 < 9; c1_i23++) {
    c1_y[c1_i23] = c1_dv4[c1_i23];
  }

  sf_mex_destroy(&c1_u);
}

static void c1_c_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData)
{
  const mxArray *c1_inverse_model;
  const char_T *c1_identifier;
  emlrtMsgIdentifier c1_thisId;
  real_T c1_y[9];
  int32_T c1_i24;
  int32_T c1_i25;
  int32_T c1_i26;
  SFc1_robot2InstanceStruct *chartInstance;
  chartInstance = (SFc1_robot2InstanceStruct *)chartInstanceVoid;
  c1_inverse_model = sf_mex_dup(c1_mxArrayInData);
  c1_identifier = c1_varName;
  c1_thisId.fIdentifier = c1_identifier;
  c1_thisId.fParent = NULL;
  c1_thisId.bParentIsCell = false;
  c1_d_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_inverse_model), &c1_thisId,
                        c1_y);
  sf_mex_destroy(&c1_inverse_model);
  c1_i24 = 0;
  for (c1_i25 = 0; c1_i25 < 3; c1_i25++) {
    for (c1_i26 = 0; c1_i26 < 3; c1_i26++) {
      (*(real_T (*)[9])c1_outData)[c1_i26 + c1_i24] = c1_y[c1_i26 + c1_i24];
    }

    c1_i24 += 3;
  }

  sf_mex_destroy(&c1_mxArrayInData);
}

const mxArray *sf_c1_robot2_get_eml_resolved_functions_info(void)
{
  const mxArray *c1_nameCaptureInfo = NULL;
  c1_nameCaptureInfo = NULL;
  sf_mex_assign(&c1_nameCaptureInfo, sf_mex_create("nameCaptureInfo", NULL, 0,
    0U, 1U, 0U, 2, 0, 1), false);
  return c1_nameCaptureInfo;
}

static void c1_inv3x3(SFc1_robot2InstanceStruct *chartInstance, real_T c1_x[9],
                      real_T c1_y[9])
{
  int32_T c1_p1;
  int32_T c1_p2;
  int32_T c1_p3;
  real_T c1_absx11;
  real_T c1_absx21;
  real_T c1_absx31;
  real_T c1_t1;
  real_T c1_b_x;
  real_T c1_b_y;
  real_T c1_z;
  real_T c1_c_x;
  real_T c1_c_y;
  real_T c1_b_z;
  int32_T c1_itmp;
  real_T c1_d_x;
  real_T c1_d_y;
  real_T c1_c_z;
  real_T c1_e_x;
  real_T c1_e_y;
  real_T c1_t3;
  real_T c1_f_x;
  real_T c1_f_y;
  real_T c1_t2;
  int32_T c1_a;
  int32_T c1_c;
  real_T c1_g_x;
  real_T c1_g_y;
  real_T c1_d_z;
  int32_T c1_b_a;
  int32_T c1_b_c;
  int32_T c1_c_a;
  int32_T c1_c_c;
  real_T c1_h_x;
  real_T c1_h_y;
  real_T c1_i_x;
  real_T c1_i_y;
  int32_T c1_d_a;
  int32_T c1_d_c;
  real_T c1_j_x;
  real_T c1_j_y;
  real_T c1_e_z;
  int32_T c1_e_a;
  int32_T c1_e_c;
  int32_T c1_f_a;
  int32_T c1_f_c;
  real_T c1_k_y;
  real_T c1_k_x;
  real_T c1_l_y;
  int32_T c1_g_a;
  int32_T c1_g_c;
  real_T c1_l_x;
  real_T c1_m_y;
  real_T c1_f_z;
  int32_T c1_h_a;
  int32_T c1_h_c;
  int32_T c1_i_a;
  int32_T c1_i_c;
  boolean_T guard1 = false;
  c1_p1 = 0;
  c1_p2 = 3;
  c1_p3 = 6;
  c1_absx11 = c1_abs(chartInstance, c1_x[0]);
  c1_absx21 = c1_abs(chartInstance, c1_x[1]);
  c1_absx31 = c1_abs(chartInstance, c1_x[2]);
  guard1 = false;
  if (c1_absx21 > c1_absx11) {
    if (c1_absx21 > c1_absx31) {
      c1_p1 = 3;
      c1_p2 = 0;
      c1_t1 = c1_x[0];
      c1_x[0] = c1_x[1];
      c1_x[1] = c1_t1;
      c1_t1 = c1_x[3];
      c1_x[3] = c1_x[4];
      c1_x[4] = c1_t1;
      c1_t1 = c1_x[6];
      c1_x[6] = c1_x[7];
      c1_x[7] = c1_t1;
    } else {
      guard1 = true;
    }
  } else {
    guard1 = true;
  }

  if (guard1 == true) {
    if (c1_absx31 > c1_absx11) {
      c1_p1 = 6;
      c1_p3 = 0;
      c1_t1 = c1_x[0];
      c1_x[0] = c1_x[2];
      c1_x[2] = c1_t1;
      c1_t1 = c1_x[3];
      c1_x[3] = c1_x[5];
      c1_x[5] = c1_t1;
      c1_t1 = c1_x[6];
      c1_x[6] = c1_x[8];
      c1_x[8] = c1_t1;
    }
  }

  c1_b_x = c1_x[1];
  c1_b_y = c1_x[0];
  c1_z = c1_b_x / c1_b_y;
  c1_x[1] = c1_z;
  c1_c_x = c1_x[2];
  c1_c_y = c1_x[0];
  c1_b_z = c1_c_x / c1_c_y;
  c1_x[2] = c1_b_z;
  c1_x[4] -= c1_x[1] * c1_x[3];
  c1_x[5] -= c1_x[2] * c1_x[3];
  c1_x[7] -= c1_x[1] * c1_x[6];
  c1_x[8] -= c1_x[2] * c1_x[6];
  if (c1_abs(chartInstance, c1_x[5]) > c1_abs(chartInstance, c1_x[4])) {
    c1_itmp = c1_p2;
    c1_p2 = c1_p3;
    c1_p3 = c1_itmp;
    c1_t1 = c1_x[1];
    c1_x[1] = c1_x[2];
    c1_x[2] = c1_t1;
    c1_t1 = c1_x[4];
    c1_x[4] = c1_x[5];
    c1_x[5] = c1_t1;
    c1_t1 = c1_x[7];
    c1_x[7] = c1_x[8];
    c1_x[8] = c1_t1;
  }

  c1_d_x = c1_x[5];
  c1_d_y = c1_x[4];
  c1_c_z = c1_d_x / c1_d_y;
  c1_x[5] = c1_c_z;
  c1_x[8] -= c1_x[5] * c1_x[7];
  c1_e_x = c1_x[5] * c1_x[1] - c1_x[2];
  c1_e_y = c1_x[8];
  c1_t3 = c1_e_x / c1_e_y;
  c1_f_x = -(c1_x[1] + c1_x[7] * c1_t3);
  c1_f_y = c1_x[4];
  c1_t2 = c1_f_x / c1_f_y;
  c1_a = c1_p1 + 1;
  c1_c = c1_a - 1;
  c1_g_x = (1.0 - c1_x[3] * c1_t2) - c1_x[6] * c1_t3;
  c1_g_y = c1_x[0];
  c1_d_z = c1_g_x / c1_g_y;
  c1_y[c1_c] = c1_d_z;
  c1_b_a = c1_p1 + 2;
  c1_b_c = c1_b_a - 1;
  c1_y[c1_b_c] = c1_t2;
  c1_c_a = c1_p1 + 3;
  c1_c_c = c1_c_a - 1;
  c1_y[c1_c_c] = c1_t3;
  c1_h_x = -c1_x[5];
  c1_h_y = c1_x[8];
  c1_t3 = c1_h_x / c1_h_y;
  c1_i_x = 1.0 - c1_x[7] * c1_t3;
  c1_i_y = c1_x[4];
  c1_t2 = c1_i_x / c1_i_y;
  c1_d_a = c1_p2 + 1;
  c1_d_c = c1_d_a - 1;
  c1_j_x = -(c1_x[3] * c1_t2 + c1_x[6] * c1_t3);
  c1_j_y = c1_x[0];
  c1_e_z = c1_j_x / c1_j_y;
  c1_y[c1_d_c] = c1_e_z;
  c1_e_a = c1_p2 + 2;
  c1_e_c = c1_e_a - 1;
  c1_y[c1_e_c] = c1_t2;
  c1_f_a = c1_p2 + 3;
  c1_f_c = c1_f_a - 1;
  c1_y[c1_f_c] = c1_t3;
  c1_k_y = c1_x[8];
  c1_t3 = 1.0 / c1_k_y;
  c1_k_x = -c1_x[7] * c1_t3;
  c1_l_y = c1_x[4];
  c1_t2 = c1_k_x / c1_l_y;
  c1_g_a = c1_p3 + 1;
  c1_g_c = c1_g_a - 1;
  c1_l_x = -(c1_x[3] * c1_t2 + c1_x[6] * c1_t3);
  c1_m_y = c1_x[0];
  c1_f_z = c1_l_x / c1_m_y;
  c1_y[c1_g_c] = c1_f_z;
  c1_h_a = c1_p3 + 2;
  c1_h_c = c1_h_a - 1;
  c1_y[c1_h_c] = c1_t2;
  c1_i_a = c1_p3 + 3;
  c1_i_c = c1_i_a - 1;
  c1_y[c1_i_c] = c1_t3;
}

static real_T c1_abs(SFc1_robot2InstanceStruct *chartInstance, real_T c1_x)
{
  real_T c1_b_x;
  real_T c1_c_x;
  (void)chartInstance;
  c1_b_x = c1_x;
  c1_c_x = c1_b_x;
  return muDoubleScalarAbs(c1_c_x);
}

static real_T c1_norm(SFc1_robot2InstanceStruct *chartInstance, real_T c1_x[9])
{
  real_T c1_y;
  int32_T c1_j;
  real_T c1_b_j;
  real_T c1_s;
  int32_T c1_i;
  real_T c1_b_x;
  real_T c1_b_i;
  boolean_T c1_b;
  boolean_T exitg1;
  c1_y = 0.0;
  c1_j = 0;
  exitg1 = false;
  while ((exitg1 == false) && (c1_j < 3)) {
    c1_b_j = 1.0 + (real_T)c1_j;
    c1_s = 0.0;
    for (c1_i = 0; c1_i < 3; c1_i++) {
      c1_b_i = 1.0 + (real_T)c1_i;
      c1_s += c1_abs(chartInstance, c1_x[((int32_T)c1_b_i + 3 * ((int32_T)c1_b_j
        - 1)) - 1]);
    }

    c1_b_x = c1_s;
    c1_b = muDoubleScalarIsNaN(c1_b_x);
    if (c1_b) {
      c1_y = rtNaN;
      exitg1 = true;
    } else {
      if (c1_s > c1_y) {
        c1_y = c1_s;
      }

      c1_j++;
    }
  }

  return c1_y;
}

static void c1_warning(SFc1_robot2InstanceStruct *chartInstance)
{
  const mxArray *c1_y = NULL;
  static char_T c1_u[7] = { 'w', 'a', 'r', 'n', 'i', 'n', 'g' };

  const mxArray *c1_b_y = NULL;
  static char_T c1_b_u[7] = { 'm', 'e', 's', 's', 'a', 'g', 'e' };

  const mxArray *c1_c_y = NULL;
  static char_T c1_msgID[27] = { 'C', 'o', 'd', 'e', 'r', ':', 'M', 'A', 'T',
    'L', 'A', 'B', ':', 's', 'i', 'n', 'g', 'u', 'l', 'a', 'r', 'M', 'a', 't',
    'r', 'i', 'x' };

  (void)chartInstance;
  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_create("y", c1_u, 10, 0U, 1U, 0U, 2, 1, 7), false);
  c1_b_y = NULL;
  sf_mex_assign(&c1_b_y, sf_mex_create("y", c1_b_u, 10, 0U, 1U, 0U, 2, 1, 7),
                false);
  c1_c_y = NULL;
  sf_mex_assign(&c1_c_y, sf_mex_create("y", c1_msgID, 10, 0U, 1U, 0U, 2, 1, 27),
                false);
  sf_mex_call_debug(sfGlobalDebugInstanceStruct, "feval", 0U, 2U, 14, c1_y, 14,
                    sf_mex_call_debug(sfGlobalDebugInstanceStruct, "feval", 1U,
    2U, 14, c1_b_y, 14, c1_c_y));
}

static void c1_b_warning(SFc1_robot2InstanceStruct *chartInstance, char_T
  c1_varargin_1[14])
{
  const mxArray *c1_y = NULL;
  static char_T c1_u[7] = { 'w', 'a', 'r', 'n', 'i', 'n', 'g' };

  const mxArray *c1_b_y = NULL;
  static char_T c1_b_u[7] = { 'm', 'e', 's', 's', 'a', 'g', 'e' };

  const mxArray *c1_c_y = NULL;
  static char_T c1_msgID[33] = { 'C', 'o', 'd', 'e', 'r', ':', 'M', 'A', 'T',
    'L', 'A', 'B', ':', 'i', 'l', 'l', 'C', 'o', 'n', 'd', 'i', 't', 'i', 'o',
    'n', 'e', 'd', 'M', 'a', 't', 'r', 'i', 'x' };

  const mxArray *c1_d_y = NULL;
  (void)chartInstance;
  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_create("y", c1_u, 10, 0U, 1U, 0U, 2, 1, 7), false);
  c1_b_y = NULL;
  sf_mex_assign(&c1_b_y, sf_mex_create("y", c1_b_u, 10, 0U, 1U, 0U, 2, 1, 7),
                false);
  c1_c_y = NULL;
  sf_mex_assign(&c1_c_y, sf_mex_create("y", c1_msgID, 10, 0U, 1U, 0U, 2, 1, 33),
                false);
  c1_d_y = NULL;
  sf_mex_assign(&c1_d_y, sf_mex_create("y", c1_varargin_1, 10, 0U, 1U, 0U, 2, 1,
    14), false);
  sf_mex_call_debug(sfGlobalDebugInstanceStruct, "feval", 0U, 2U, 14, c1_y, 14,
                    sf_mex_call_debug(sfGlobalDebugInstanceStruct, "feval", 1U,
    3U, 14, c1_b_y, 14, c1_c_y, 14, c1_d_y));
}

static void c1_scalarEg(SFc1_robot2InstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void c1_b_scalarEg(SFc1_robot2InstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void c1_e_emlrt_marshallIn(SFc1_robot2InstanceStruct *chartInstance,
  const mxArray *c1_sprintf, const char_T *c1_identifier, char_T c1_y[14])
{
  emlrtMsgIdentifier c1_thisId;
  c1_thisId.fIdentifier = c1_identifier;
  c1_thisId.fParent = NULL;
  c1_thisId.bParentIsCell = false;
  c1_f_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_sprintf), &c1_thisId, c1_y);
  sf_mex_destroy(&c1_sprintf);
}

static void c1_f_emlrt_marshallIn(SFc1_robot2InstanceStruct *chartInstance,
  const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId, char_T c1_y[14])
{
  char_T c1_cv0[14];
  int32_T c1_i27;
  (void)chartInstance;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_u), c1_cv0, 1, 10, 0U, 1, 0U, 2, 1,
                14);
  for (c1_i27 = 0; c1_i27 < 14; c1_i27++) {
    c1_y[c1_i27] = c1_cv0[c1_i27];
  }

  sf_mex_destroy(&c1_u);
}

static const mxArray *c1_d_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData)
{
  const mxArray *c1_mxArrayOutData = NULL;
  int32_T c1_u;
  const mxArray *c1_y = NULL;
  SFc1_robot2InstanceStruct *chartInstance;
  chartInstance = (SFc1_robot2InstanceStruct *)chartInstanceVoid;
  c1_mxArrayOutData = NULL;
  c1_u = *(int32_T *)c1_inData;
  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_create("y", &c1_u, 6, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c1_mxArrayOutData, c1_y, false);
  return c1_mxArrayOutData;
}

static int32_T c1_g_emlrt_marshallIn(SFc1_robot2InstanceStruct *chartInstance,
  const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId)
{
  int32_T c1_y;
  int32_T c1_i28;
  (void)chartInstance;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_u), &c1_i28, 1, 6, 0U, 0, 0U, 0);
  c1_y = c1_i28;
  sf_mex_destroy(&c1_u);
  return c1_y;
}

static void c1_d_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData)
{
  const mxArray *c1_b_sfEvent;
  const char_T *c1_identifier;
  emlrtMsgIdentifier c1_thisId;
  int32_T c1_y;
  SFc1_robot2InstanceStruct *chartInstance;
  chartInstance = (SFc1_robot2InstanceStruct *)chartInstanceVoid;
  c1_b_sfEvent = sf_mex_dup(c1_mxArrayInData);
  c1_identifier = c1_varName;
  c1_thisId.fIdentifier = c1_identifier;
  c1_thisId.fParent = NULL;
  c1_thisId.bParentIsCell = false;
  c1_y = c1_g_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_b_sfEvent),
    &c1_thisId);
  sf_mex_destroy(&c1_b_sfEvent);
  *(int32_T *)c1_outData = c1_y;
  sf_mex_destroy(&c1_mxArrayInData);
}

static uint8_T c1_h_emlrt_marshallIn(SFc1_robot2InstanceStruct *chartInstance,
  const mxArray *c1_b_is_active_c1_robot2, const char_T *c1_identifier)
{
  uint8_T c1_y;
  emlrtMsgIdentifier c1_thisId;
  c1_thisId.fIdentifier = c1_identifier;
  c1_thisId.fParent = NULL;
  c1_thisId.bParentIsCell = false;
  c1_y = c1_i_emlrt_marshallIn(chartInstance, sf_mex_dup
    (c1_b_is_active_c1_robot2), &c1_thisId);
  sf_mex_destroy(&c1_b_is_active_c1_robot2);
  return c1_y;
}

static uint8_T c1_i_emlrt_marshallIn(SFc1_robot2InstanceStruct *chartInstance,
  const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId)
{
  uint8_T c1_y;
  uint8_T c1_u0;
  (void)chartInstance;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_u), &c1_u0, 1, 3, 0U, 0, 0U, 0);
  c1_y = c1_u0;
  sf_mex_destroy(&c1_u);
  return c1_y;
}

static void init_dsm_address_info(SFc1_robot2InstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void init_simulink_io_address(SFc1_robot2InstanceStruct *chartInstance)
{
  chartInstance->c1_Des_vxr = (real_T *)ssGetInputPortSignal_wrapper
    (chartInstance->S, 0);
  chartInstance->c1_V1 = (real_T *)ssGetOutputPortSignal_wrapper
    (chartInstance->S, 1);
  chartInstance->c1_Des_vyr = (real_T *)ssGetInputPortSignal_wrapper
    (chartInstance->S, 1);
  chartInstance->c1_Des_thetar = (real_T *)ssGetInputPortSignal_wrapper
    (chartInstance->S, 2);
  chartInstance->c1_V2 = (real_T *)ssGetOutputPortSignal_wrapper
    (chartInstance->S, 2);
  chartInstance->c1_V3 = (real_T *)ssGetOutputPortSignal_wrapper
    (chartInstance->S, 3);
  chartInstance->c1_L = (real_T *)ssGetInputPortSignal_wrapper(chartInstance->S,
    3);
}

/* SFunction Glue Code */
#ifdef utFree
#undef utFree
#endif

#ifdef utMalloc
#undef utMalloc
#endif

#ifdef __cplusplus

extern "C" void *utMalloc(size_t size);
extern "C" void utFree(void*);

#else

extern void *utMalloc(size_t size);
extern void utFree(void*);

#endif

void sf_c1_robot2_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(147200067U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(3447612535U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(3771421222U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(18771463U);
}

mxArray* sf_c1_robot2_get_post_codegen_info(void);
mxArray *sf_c1_robot2_get_autoinheritance_info(void)
{
  const char *autoinheritanceFields[] = { "checksum", "inputs", "parameters",
    "outputs", "locals", "postCodegenInfo" };

  mxArray *mxAutoinheritanceInfo = mxCreateStructMatrix(1, 1, sizeof
    (autoinheritanceFields)/sizeof(autoinheritanceFields[0]),
    autoinheritanceFields);

  {
    mxArray *mxChecksum = mxCreateString("SeS6a4geAa1EaaVjTRu1HE");
    mxSetField(mxAutoinheritanceInfo,0,"checksum",mxChecksum);
  }

  {
    const char *dataFields[] = { "size", "type", "complexity" };

    mxArray *mxData = mxCreateStructMatrix(1,4,3,dataFields);

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,0,mxREAL);
      double *pr = mxGetPr(mxSize);
      mxSetField(mxData,0,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt", "isFixedPointType" };

      mxArray *mxType = mxCreateStructMatrix(1,1,sizeof(typeFields)/sizeof
        (typeFields[0]),typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxType,0,"isFixedPointType",mxCreateDoubleScalar(0));
      mxSetField(mxData,0,"type",mxType);
    }

    mxSetField(mxData,0,"complexity",mxCreateDoubleScalar(0));

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,0,mxREAL);
      double *pr = mxGetPr(mxSize);
      mxSetField(mxData,1,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt", "isFixedPointType" };

      mxArray *mxType = mxCreateStructMatrix(1,1,sizeof(typeFields)/sizeof
        (typeFields[0]),typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxType,0,"isFixedPointType",mxCreateDoubleScalar(0));
      mxSetField(mxData,1,"type",mxType);
    }

    mxSetField(mxData,1,"complexity",mxCreateDoubleScalar(0));

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,0,mxREAL);
      double *pr = mxGetPr(mxSize);
      mxSetField(mxData,2,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt", "isFixedPointType" };

      mxArray *mxType = mxCreateStructMatrix(1,1,sizeof(typeFields)/sizeof
        (typeFields[0]),typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxType,0,"isFixedPointType",mxCreateDoubleScalar(0));
      mxSetField(mxData,2,"type",mxType);
    }

    mxSetField(mxData,2,"complexity",mxCreateDoubleScalar(0));

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,0,mxREAL);
      double *pr = mxGetPr(mxSize);
      mxSetField(mxData,3,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt", "isFixedPointType" };

      mxArray *mxType = mxCreateStructMatrix(1,1,sizeof(typeFields)/sizeof
        (typeFields[0]),typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxType,0,"isFixedPointType",mxCreateDoubleScalar(0));
      mxSetField(mxData,3,"type",mxType);
    }

    mxSetField(mxData,3,"complexity",mxCreateDoubleScalar(0));
    mxSetField(mxAutoinheritanceInfo,0,"inputs",mxData);
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"parameters",mxCreateDoubleMatrix(0,0,
                mxREAL));
  }

  {
    const char *dataFields[] = { "size", "type", "complexity" };

    mxArray *mxData = mxCreateStructMatrix(1,3,3,dataFields);

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,0,mxREAL);
      double *pr = mxGetPr(mxSize);
      mxSetField(mxData,0,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt", "isFixedPointType" };

      mxArray *mxType = mxCreateStructMatrix(1,1,sizeof(typeFields)/sizeof
        (typeFields[0]),typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxType,0,"isFixedPointType",mxCreateDoubleScalar(0));
      mxSetField(mxData,0,"type",mxType);
    }

    mxSetField(mxData,0,"complexity",mxCreateDoubleScalar(0));

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,0,mxREAL);
      double *pr = mxGetPr(mxSize);
      mxSetField(mxData,1,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt", "isFixedPointType" };

      mxArray *mxType = mxCreateStructMatrix(1,1,sizeof(typeFields)/sizeof
        (typeFields[0]),typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxType,0,"isFixedPointType",mxCreateDoubleScalar(0));
      mxSetField(mxData,1,"type",mxType);
    }

    mxSetField(mxData,1,"complexity",mxCreateDoubleScalar(0));

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,0,mxREAL);
      double *pr = mxGetPr(mxSize);
      mxSetField(mxData,2,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt", "isFixedPointType" };

      mxArray *mxType = mxCreateStructMatrix(1,1,sizeof(typeFields)/sizeof
        (typeFields[0]),typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxType,0,"isFixedPointType",mxCreateDoubleScalar(0));
      mxSetField(mxData,2,"type",mxType);
    }

    mxSetField(mxData,2,"complexity",mxCreateDoubleScalar(0));
    mxSetField(mxAutoinheritanceInfo,0,"outputs",mxData);
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"locals",mxCreateDoubleMatrix(0,0,mxREAL));
  }

  {
    mxArray* mxPostCodegenInfo = sf_c1_robot2_get_post_codegen_info();
    mxSetField(mxAutoinheritanceInfo,0,"postCodegenInfo",mxPostCodegenInfo);
  }

  return(mxAutoinheritanceInfo);
}

mxArray *sf_c1_robot2_third_party_uses_info(void)
{
  mxArray * mxcell3p = mxCreateCellMatrix(1,0);
  return(mxcell3p);
}

mxArray *sf_c1_robot2_jit_fallback_info(void)
{
  const char *infoFields[] = { "fallbackType", "fallbackReason",
    "hiddenFallbackType", "hiddenFallbackReason", "incompatibleSymbol" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 5, infoFields);
  mxArray *fallbackType = mxCreateString("pre");
  mxArray *fallbackReason = mxCreateString("hasBreakpoints");
  mxArray *hiddenFallbackType = mxCreateString("none");
  mxArray *hiddenFallbackReason = mxCreateString("");
  mxArray *incompatibleSymbol = mxCreateString("");
  mxSetField(mxInfo, 0, infoFields[0], fallbackType);
  mxSetField(mxInfo, 0, infoFields[1], fallbackReason);
  mxSetField(mxInfo, 0, infoFields[2], hiddenFallbackType);
  mxSetField(mxInfo, 0, infoFields[3], hiddenFallbackReason);
  mxSetField(mxInfo, 0, infoFields[4], incompatibleSymbol);
  return mxInfo;
}

mxArray *sf_c1_robot2_updateBuildInfo_args_info(void)
{
  mxArray *mxBIArgs = mxCreateCellMatrix(1,0);
  return mxBIArgs;
}

mxArray* sf_c1_robot2_get_post_codegen_info(void)
{
  const char* fieldNames[] = { "exportedFunctionsUsedByThisChart",
    "exportedFunctionsChecksum" };

  mwSize dims[2] = { 1, 1 };

  mxArray* mxPostCodegenInfo = mxCreateStructArray(2, dims, sizeof(fieldNames)/
    sizeof(fieldNames[0]), fieldNames);

  {
    mxArray* mxExportedFunctionsChecksum = mxCreateString("");
    mwSize exp_dims[2] = { 0, 1 };

    mxArray* mxExportedFunctionsUsedByThisChart = mxCreateCellArray(2, exp_dims);
    mxSetField(mxPostCodegenInfo, 0, "exportedFunctionsUsedByThisChart",
               mxExportedFunctionsUsedByThisChart);
    mxSetField(mxPostCodegenInfo, 0, "exportedFunctionsChecksum",
               mxExportedFunctionsChecksum);
  }

  return mxPostCodegenInfo;
}

static const mxArray *sf_get_sim_state_info_c1_robot2(void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  const char *infoEncStr[] = {
    "100 S1x4'type','srcId','name','auxInfo'{{M[1],M[5],T\"V1\",},{M[1],M[8],T\"V2\",},{M[1],M[9],T\"V3\",},{M[8],M[0],T\"is_active_c1_robot2\",}}"
  };

  mxArray *mxVarInfo = sf_mex_decode_encoded_mx_struct_array(infoEncStr, 4, 10);
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c1_robot2_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static void chart_debug_initialization(SimStruct *S, unsigned int
  fullDebuggerInitialization)
{
  if (!sim_mode_is_rtw_gen(S)) {
    SFc1_robot2InstanceStruct *chartInstance = (SFc1_robot2InstanceStruct *)
      sf_get_chart_instance_ptr(S);
    if (ssIsFirstInitCond(S) && fullDebuggerInitialization==1) {
      /* do this only if simulation is starting */
      {
        unsigned int chartAlreadyPresent;
        chartAlreadyPresent = sf_debug_initialize_chart
          (sfGlobalDebugInstanceStruct,
           _robot2MachineNumber_,
           1,
           1,
           1,
           0,
           7,
           0,
           0,
           0,
           0,
           0,
           &chartInstance->chartNumber,
           &chartInstance->instanceNumber,
           (void *)S);

        /* Each instance must initialize its own list of scripts */
        init_script_number_translation(_robot2MachineNumber_,
          chartInstance->chartNumber,chartInstance->instanceNumber);
        if (chartAlreadyPresent==0) {
          /* this is the first instance */
          sf_debug_set_chart_disable_implicit_casting
            (sfGlobalDebugInstanceStruct,_robot2MachineNumber_,
             chartInstance->chartNumber,1);
          sf_debug_set_chart_event_thresholds(sfGlobalDebugInstanceStruct,
            _robot2MachineNumber_,
            chartInstance->chartNumber,
            0,
            0,
            0);
          _SFD_SET_DATA_PROPS(0,1,1,0,"Des_vxr");
          _SFD_SET_DATA_PROPS(1,1,1,0,"Des_vyr");
          _SFD_SET_DATA_PROPS(2,1,1,0,"Des_thetar");
          _SFD_SET_DATA_PROPS(3,1,1,0,"L");
          _SFD_SET_DATA_PROPS(4,2,0,1,"V1");
          _SFD_SET_DATA_PROPS(5,2,0,1,"V2");
          _SFD_SET_DATA_PROPS(6,2,0,1,"V3");
          _SFD_STATE_INFO(0,0,2);
          _SFD_CH_SUBSTATE_COUNT(0);
          _SFD_CH_SUBSTATE_DECOMP(0);
        }

        _SFD_CV_INIT_CHART(0,0,0,0);

        {
          _SFD_CV_INIT_STATE(0,0,0,0,0,0,NULL,NULL);
        }

        _SFD_CV_INIT_TRANS(0,0,NULL,NULL,0,NULL);

        /* Initialization of MATLAB Function Model Coverage */
        _SFD_CV_INIT_EML(0,1,1,0,0,0,0,0,0,0,0,0);
        _SFD_CV_INIT_EML_FCN(0,0,"eML_blk_kernel",0,-1,432);
        _SFD_SET_DATA_COMPILED_PROPS(0,SF_DOUBLE,0,NULL,0,0,0,0.0,1.0,0,0,
          (MexFcnForType)c1_sf_marshallOut,(MexInFcnForType)NULL);
        _SFD_SET_DATA_COMPILED_PROPS(1,SF_DOUBLE,0,NULL,0,0,0,0.0,1.0,0,0,
          (MexFcnForType)c1_sf_marshallOut,(MexInFcnForType)NULL);
        _SFD_SET_DATA_COMPILED_PROPS(2,SF_DOUBLE,0,NULL,0,0,0,0.0,1.0,0,0,
          (MexFcnForType)c1_sf_marshallOut,(MexInFcnForType)NULL);
        _SFD_SET_DATA_COMPILED_PROPS(3,SF_DOUBLE,0,NULL,0,0,0,0.0,1.0,0,0,
          (MexFcnForType)c1_sf_marshallOut,(MexInFcnForType)NULL);
        _SFD_SET_DATA_COMPILED_PROPS(4,SF_DOUBLE,0,NULL,0,0,0,0.0,1.0,0,0,
          (MexFcnForType)c1_sf_marshallOut,(MexInFcnForType)c1_sf_marshallIn);
        _SFD_SET_DATA_COMPILED_PROPS(5,SF_DOUBLE,0,NULL,0,0,0,0.0,1.0,0,0,
          (MexFcnForType)c1_sf_marshallOut,(MexInFcnForType)c1_sf_marshallIn);
        _SFD_SET_DATA_COMPILED_PROPS(6,SF_DOUBLE,0,NULL,0,0,0,0.0,1.0,0,0,
          (MexFcnForType)c1_sf_marshallOut,(MexInFcnForType)c1_sf_marshallIn);
      }
    } else {
      sf_debug_reset_current_state_configuration(sfGlobalDebugInstanceStruct,
        _robot2MachineNumber_,chartInstance->chartNumber,
        chartInstance->instanceNumber);
    }
  }
}

static void chart_debug_initialize_data_addresses(SimStruct *S)
{
  if (!sim_mode_is_rtw_gen(S)) {
    SFc1_robot2InstanceStruct *chartInstance = (SFc1_robot2InstanceStruct *)
      sf_get_chart_instance_ptr(S);
    if (ssIsFirstInitCond(S)) {
      /* do this only if simulation is starting and after we know the addresses of all data */
      {
        _SFD_SET_DATA_VALUE_PTR(0U, chartInstance->c1_Des_vxr);
        _SFD_SET_DATA_VALUE_PTR(4U, chartInstance->c1_V1);
        _SFD_SET_DATA_VALUE_PTR(1U, chartInstance->c1_Des_vyr);
        _SFD_SET_DATA_VALUE_PTR(2U, chartInstance->c1_Des_thetar);
        _SFD_SET_DATA_VALUE_PTR(5U, chartInstance->c1_V2);
        _SFD_SET_DATA_VALUE_PTR(6U, chartInstance->c1_V3);
        _SFD_SET_DATA_VALUE_PTR(3U, chartInstance->c1_L);
      }
    }
  }
}

static const char* sf_get_instance_specialization(void)
{
  return "sh4xOxcHVDn4GdBsjDAd5jD";
}

static void sf_opaque_initialize_c1_robot2(void *chartInstanceVar)
{
  chart_debug_initialization(((SFc1_robot2InstanceStruct*) chartInstanceVar)->S,
    0);
  initialize_params_c1_robot2((SFc1_robot2InstanceStruct*) chartInstanceVar);
  initialize_c1_robot2((SFc1_robot2InstanceStruct*) chartInstanceVar);
}

static void sf_opaque_enable_c1_robot2(void *chartInstanceVar)
{
  enable_c1_robot2((SFc1_robot2InstanceStruct*) chartInstanceVar);
}

static void sf_opaque_disable_c1_robot2(void *chartInstanceVar)
{
  disable_c1_robot2((SFc1_robot2InstanceStruct*) chartInstanceVar);
}

static void sf_opaque_gateway_c1_robot2(void *chartInstanceVar)
{
  sf_gateway_c1_robot2((SFc1_robot2InstanceStruct*) chartInstanceVar);
}

static const mxArray* sf_opaque_get_sim_state_c1_robot2(SimStruct* S)
{
  return get_sim_state_c1_robot2((SFc1_robot2InstanceStruct *)
    sf_get_chart_instance_ptr(S));     /* raw sim ctx */
}

static void sf_opaque_set_sim_state_c1_robot2(SimStruct* S, const mxArray *st)
{
  set_sim_state_c1_robot2((SFc1_robot2InstanceStruct*)sf_get_chart_instance_ptr
    (S), st);
}

static void sf_opaque_terminate_c1_robot2(void *chartInstanceVar)
{
  if (chartInstanceVar!=NULL) {
    SimStruct *S = ((SFc1_robot2InstanceStruct*) chartInstanceVar)->S;
    if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
      sf_clear_rtw_identifier(S);
      unload_robot2_optimization_info();
    }

    finalize_c1_robot2((SFc1_robot2InstanceStruct*) chartInstanceVar);
    utFree(chartInstanceVar);
    if (ssGetUserData(S)!= NULL) {
      sf_free_ChartRunTimeInfo(S);
    }

    ssSetUserData(S,NULL);
  }
}

static void sf_opaque_init_subchart_simstructs(void *chartInstanceVar)
{
  initSimStructsc1_robot2((SFc1_robot2InstanceStruct*) chartInstanceVar);
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c1_robot2(SimStruct *S)
{
  int i;
  for (i=0;i<ssGetNumRunTimeParams(S);i++) {
    if (ssGetSFcnParamTunable(S,i)) {
      ssUpdateDlgParamAsRunTimeParam(S,i);
    }
  }

  if (sf_machine_global_initializer_called()) {
    initialize_params_c1_robot2((SFc1_robot2InstanceStruct*)
      sf_get_chart_instance_ptr(S));
  }
}

static void mdlSetWorkWidths_c1_robot2(SimStruct *S)
{
  /* Set overwritable ports for inplace optimization */
  ssMdlUpdateIsEmpty(S, 1);
  if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
    mxArray *infoStruct = load_robot2_optimization_info(sim_mode_is_rtw_gen(S),
      sim_mode_is_modelref_sim(S), sim_mode_is_external(S));
    int_T chartIsInlinable =
      (int_T)sf_is_chart_inlinable(sf_get_instance_specialization(),infoStruct,1);
    ssSetStateflowIsInlinable(S,chartIsInlinable);
    ssSetRTWCG(S,1);
    ssSetEnableFcnIsTrivial(S,1);
    ssSetDisableFcnIsTrivial(S,1);
    ssSetNotMultipleInlinable(S,sf_rtw_info_uint_prop
      (sf_get_instance_specialization(),infoStruct,1,
       "gatewayCannotBeInlinedMultipleTimes"));
    sf_set_chart_accesses_machine_info(S, sf_get_instance_specialization(),
      infoStruct, 1);
    sf_update_buildInfo(S, sf_get_instance_specialization(),infoStruct,1);
    if (chartIsInlinable) {
      ssSetInputPortOptimOpts(S, 0, SS_REUSABLE_AND_LOCAL);
      ssSetInputPortOptimOpts(S, 1, SS_REUSABLE_AND_LOCAL);
      ssSetInputPortOptimOpts(S, 2, SS_REUSABLE_AND_LOCAL);
      ssSetInputPortOptimOpts(S, 3, SS_REUSABLE_AND_LOCAL);
      sf_mark_chart_expressionable_inputs(S,sf_get_instance_specialization(),
        infoStruct,1,4);
      sf_mark_chart_reusable_outputs(S,sf_get_instance_specialization(),
        infoStruct,1,3);
    }

    {
      unsigned int outPortIdx;
      for (outPortIdx=1; outPortIdx<=3; ++outPortIdx) {
        ssSetOutputPortOptimizeInIR(S, outPortIdx, 1U);
      }
    }

    {
      unsigned int inPortIdx;
      for (inPortIdx=0; inPortIdx < 4; ++inPortIdx) {
        ssSetInputPortOptimizeInIR(S, inPortIdx, 1U);
      }
    }

    sf_set_rtw_dwork_info(S,sf_get_instance_specialization(),infoStruct,1);
    ssSetHasSubFunctions(S,!(chartIsInlinable));
  } else {
  }

  ssSetOptions(S,ssGetOptions(S)|SS_OPTION_WORKS_WITH_CODE_REUSE);
  ssSetChecksum0(S,(4200649915U));
  ssSetChecksum1(S,(2194310768U));
  ssSetChecksum2(S,(723435840U));
  ssSetChecksum3(S,(2991784951U));
  ssSetmdlDerivatives(S, NULL);
  ssSetExplicitFCSSCtrl(S,1);
  ssSetStateSemanticsClassicAndSynchronous(S, true);
  ssSupportsMultipleExecInstances(S,1);
}

static void mdlRTW_c1_robot2(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    ssWriteRTWStrParam(S, "StateflowChartType", "Embedded MATLAB");
  }
}

static void mdlStart_c1_robot2(SimStruct *S)
{
  SFc1_robot2InstanceStruct *chartInstance;
  chartInstance = (SFc1_robot2InstanceStruct *)utMalloc(sizeof
    (SFc1_robot2InstanceStruct));
  if (chartInstance==NULL) {
    sf_mex_error_message("Could not allocate memory for chart instance.");
  }

  memset(chartInstance, 0, sizeof(SFc1_robot2InstanceStruct));
  chartInstance->chartInfo.chartInstance = chartInstance;
  chartInstance->chartInfo.isEMLChart = 1;
  chartInstance->chartInfo.chartInitialized = 0;
  chartInstance->chartInfo.sFunctionGateway = sf_opaque_gateway_c1_robot2;
  chartInstance->chartInfo.initializeChart = sf_opaque_initialize_c1_robot2;
  chartInstance->chartInfo.terminateChart = sf_opaque_terminate_c1_robot2;
  chartInstance->chartInfo.enableChart = sf_opaque_enable_c1_robot2;
  chartInstance->chartInfo.disableChart = sf_opaque_disable_c1_robot2;
  chartInstance->chartInfo.getSimState = sf_opaque_get_sim_state_c1_robot2;
  chartInstance->chartInfo.setSimState = sf_opaque_set_sim_state_c1_robot2;
  chartInstance->chartInfo.getSimStateInfo = sf_get_sim_state_info_c1_robot2;
  chartInstance->chartInfo.zeroCrossings = NULL;
  chartInstance->chartInfo.outputs = NULL;
  chartInstance->chartInfo.derivatives = NULL;
  chartInstance->chartInfo.mdlRTW = mdlRTW_c1_robot2;
  chartInstance->chartInfo.mdlStart = mdlStart_c1_robot2;
  chartInstance->chartInfo.mdlSetWorkWidths = mdlSetWorkWidths_c1_robot2;
  chartInstance->chartInfo.callGetHoverDataForMsg = NULL;
  chartInstance->chartInfo.extModeExec = NULL;
  chartInstance->chartInfo.restoreLastMajorStepConfiguration = NULL;
  chartInstance->chartInfo.restoreBeforeLastMajorStepConfiguration = NULL;
  chartInstance->chartInfo.storeCurrentConfiguration = NULL;
  chartInstance->chartInfo.callAtomicSubchartUserFcn = NULL;
  chartInstance->chartInfo.callAtomicSubchartAutoFcn = NULL;
  chartInstance->chartInfo.debugInstance = sfGlobalDebugInstanceStruct;
  chartInstance->S = S;
  sf_init_ChartRunTimeInfo(S, &(chartInstance->chartInfo), false, 0);
  init_dsm_address_info(chartInstance);
  init_simulink_io_address(chartInstance);
  if (!sim_mode_is_rtw_gen(S)) {
  }

  chart_debug_initialization(S,1);
  mdl_start_c1_robot2(chartInstance);
}

void c1_robot2_method_dispatcher(SimStruct *S, int_T method, void *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_c1_robot2(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c1_robot2(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c1_robot2(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c1_robot2_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
