/*************************************************************************
* Copyright 2012 Altera Corporation, San Jose, California, USA.          *
* All rights reserved. All use of this software and documentation is     *
* subject to the License Agreement located at the end of this file below.*
*************************************************************************/
/******************************************************************************
 *
 * Description
 * ************* 
 * This program just shows how GCC can infer the Floating Point Hardware 2
 * custom instruction operations.
 * Compile and look at the float2_gcc.objdump to see the
 * generated assembly code and inference of the custom instructions.
 */

#include <math.h>
#include "system.h"
#include "float2_gcc.h"
#include "opencv.h"

int
main(void)
{
    int ret = show_gcc_inference();

    /* Return value just to prevent compiler from optimizing out code. */
    return ret;   
}

/*
 * Show what the GCC compiler can infer.
 * The operation names match the -mcustom-<operation> names.
 *
 *   Operation      GCC Inference
 *   ============   ===================
 *   fabss          fabsf()
 *   fnegs          -
 *   fcmpnes        !=
 *   fcmpeqs        ==
 *   fcmpges        >=
 *   fcmpgts        >
 *   fcmples        <=
 *   fcmplts        <
 *   fmaxs          Can't infer, macro in altera_nios_custom_instr_floating_point_2.h used
 *   fmins          Can't infer, macro in altera_nios_custom_instr_floating_point_2.h used
 *   round          Can't infer, macro in altera_nios_custom_instr_floating_point_2.h used
 *   fixsi          cast
 *   floatis        cast
 *   fsqrts         Can't infer, macro in altera_nios_custom_instr_floating_point_2.h used
 *   fmuls          *
 *   fadds          +
 *   fsubs          -
 *   fdivs          /
 */

float show_gcc_inference_fabss(float a) { return fabsf(a); }
float show_gcc_inference_fnegs(float a) { return -a; }
int show_gcc_inference_fcmpnes(float a, float b) { return a != b; }
int show_gcc_inference_fcmpeqs(float a, float b) { return a == b; }
int show_gcc_inference_fcmpges(float a, float b) { return a >= b; }
int show_gcc_inference_fcmpgts(float a, float b) { return a > b; }
int show_gcc_inference_fcmples(float a, float b) { return a <= b; }
int show_gcc_inference_fcmplts(float a, float b) { return a < b; }
float show_gcc_inference_fmaxs(float a, float b) { return fmaxf(a, b); }
float show_gcc_inference_fmins(float a, float b) { return fminf(a, b); }
int show_gcc_inference_round(float a) { return lroundf(a); }
int show_gcc_inference_fixsi(float a) { return (int)a; }
float show_gcc_inference_floatis(int i) { return (float)i; }
float show_gcc_inference_fsqrts(float a) { return sqrtf(a); }
float show_gcc_inference_fmuls(float a, float b) { return a * b; }
float show_gcc_inference_fadds(float a, float b) { return a + b; }
float show_gcc_inference_fsubs(float a, float b) { return a - b; }
float show_gcc_inference_fdivs(float a, float b) { return a / b; }
