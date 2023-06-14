/*************************************************************************
* Copyright 2012 Altera Corporation, San Jose, California, USA.          *
* All rights reserved. All use of this software and documentation is     *
* subject to the License Agreement located at the end of this file below.*
*************************************************************************/

#ifndef _FLOAT2_GCC_H_
#define _FLOAT2_GCC_H_

int show_gcc_inference();
float show_gcc_inference_fabss(float a);
float show_gcc_inference_fnegs(float a);
int show_gcc_inference_fcmpnes(float a, float b);
int show_gcc_inference_fcmpeqs(float a, float b);
int show_gcc_inference_fcmpges(float a, float b);
int show_gcc_inference_fcmpgts(float a, float b);
int show_gcc_inference_fcmples(float a, float b);
int show_gcc_inference_fcmplts(float a, float b);
float show_gcc_inference_fmaxs(float a, float b);
float show_gcc_inference_fmins(float a, float b);
int show_gcc_inference_round(float a);
int show_gcc_inference_fixsi(float a);
float show_gcc_inference_floatis(int i);
float show_gcc_inference_fsqrts(float a);
float show_gcc_inference_fmuls(float a, float b);
float show_gcc_inference_fadds(float a, float b);
float show_gcc_inference_fsubs(float a, float b);
float show_gcc_inference_fdivs(float a, float b);

#endif /* _FLOAT2_GCC_H_ */
