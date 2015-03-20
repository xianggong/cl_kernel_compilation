# 1 "MemoryOptimizations_Kernels.cl"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "MemoryOptimizations_Kernels.cl"
# 18 "MemoryOptimizations_Kernels.cl"
__kernel void copy1DFastPath(__global float *input, __global float *output)
{
 int gid = get_global_id(0);
 output[gid]=input[gid];
 return;
}

#pragma OPENCL EXTENSION cl_khr_global_int32_base_atomics : enable

__kernel void copy1DCompletePath(__global float *input, __global float *output)
{
 int gid = get_global_id(0);
 if(gid < 0)
  atom_add((__global int*)output, 1);
 output[gid]=input[gid];
 return;
}





__kernel void copy2Dfloat(__global float *A, __global float *C)
{
 int idx = get_global_id(0);
 int idy = get_global_id(1);
 C[(idy)* 1024 +(idx)] = A[(idy)* 1024 +(idx)];
}



__kernel void copy2Dfloat4(__global float4 *A, __global float4 *C)
{
 int idx = get_global_id(0);
 int idy = get_global_id(1);
 C[(idy)* 1024 +(idx)] = A[(idy)* 1024 +(idx)];
}

__kernel void copy1Dfloat4(__global float4 *input, __global float4 *output)
{
 int gid = get_global_id(0);
 output[gid]=input[gid];
 return;
}


__kernel void NoCoal(__global float* input, __global float* output)
{
 int gid = get_global_id(0) - 1;
 if((get_local_id(0) & 0xf) == 0)
  gid += 16;
 output[gid] = input[gid];
}


__kernel void Split(__global float* input, __global float* output)
{
 int gid = get_global_id(0);
 if((gid & 0x1) == 0)
 {
  gid = (gid & !63) + 62 - get_local_id(0);
 }
 output[gid] = input[gid];
}
# 93 "MemoryOptimizations_Kernels.cl"
__kernel void localBankConflicts( __local float* share, __global float* output)
{
 int gid = get_global_id(0);
 int lid = get_local_id(0);
 int resulta = 0;
 int resultb = 0;
 for(int i =0; i < 128; i+=2 )
 {
  resulta += share[lid * 32 + i];
  resultb += share[lid * 32 + i + 1];
 }
 output[gid] = resulta + resultb;
}





__kernel void noLocalBankConflicts( __local float* share, __global float* output)
{
 int gid = get_global_id(0);
 int lid = get_local_id(0);
 int resulta = 0;
 int resultb = 0;
 for(int i =0; i < 128; i+=2 )
 {
  resulta += share[i + lid];
  resultb += share[i + 1 + lid];
 }
 output[gid] = resulta + resultb;
}
