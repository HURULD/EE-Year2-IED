/*************************************************************************
* Copyright 2012 Altera Corporation, San Jose, California, USA.          *
* All rights reserved. All use of this software and documentation is     *
* subject to the License Agreement located at the end of this file below.*
*************************************************************************/

#include <math.h>
#include "system.h"
#include "float2_gcc.h"

/* 
 * These pragmas override the -mcustom-<operation> GCC command-line
 * options and force GCC to use the software emulation implementation
 * of floating-point operations instead of the custom instructions.
 */
#pragma GCC target("no-custom-fabss")
#pragma GCC target("no-custom-fnegs")
#pragma GCC target("no-custom-fcmpnes")
#pragma GCC target("no-custom-fcmpeqs")
#pragma GCC target("no-custom-fcmpges")
#pragma GCC target("no-custom-fcmpgts")
#pragma GCC target("no-custom-fcmples")
#pragma GCC target("no-custom-fcmplts")
#pragma GCC target("no-custom-fixsi")
#pragma GCC target("no-custom-floatis")
#pragma GCC target("no-custom-fmuls")
#pragma GCC target("no-custom-fadds")
#pragma GCC target("no-custom-fsubs")
#pragma GCC target("no-custom-fdivs")

/*
 * Undefine macros in altera_nios_custom_instr_floating_point_2.h
 * that replace these function calls with custom instructions.
 */
#undef fminf
#undef fmaxf
#undef sqrtf
#undef lroundf

int 
show_gcc_inference()
{
    /* Values don't matter to demonstrate inference. */
    volatile float a = 1.0;
    volatile float b = 2.0;
    volatile int i = 100;
    volatile float fr = 1.0;
    volatile int ir = 1;

    fr += show_gcc_inference_fabss(a);
    fr += show_gcc_inference_fnegs(a);
    ir += show_gcc_inference_fcmpnes(a, b);
    ir += show_gcc_inference_fcmpeqs(a, b);
    ir += show_gcc_inference_fcmpges(a, b);
    ir += show_gcc_inference_fcmpgts(a, b);
    ir += show_gcc_inference_fcmples(a, b);
    ir += show_gcc_inference_fcmplts(a, b);
    fr += show_gcc_inference_fmaxs(a, b);
    fr += show_gcc_inference_fmins(a, b);
    ir += show_gcc_inference_round(a);
    ir += show_gcc_inference_fixsi(a);
    fr += show_gcc_inference_floatis(i);
    fr += show_gcc_inference_fsqrts(a);
    fr += show_gcc_inference_fmuls(a, b);
    fr += show_gcc_inference_fadds(a, b);
    fr += show_gcc_inference_fsubs(a, b);
    fr += show_gcc_inference_fdivs(a, b);

    return (int)fr + ir;
}
