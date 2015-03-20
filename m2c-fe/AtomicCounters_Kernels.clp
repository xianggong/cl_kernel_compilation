# 1 "AtomicCounters_Kernels.cl"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "AtomicCounters_Kernels.cl"
# 22 "AtomicCounters_Kernels.cl"
#pragma OPENCL EXTENSION cl_ext_atomic_counters_32 : enable

__kernel
void atomicCounters(
  volatile __global uint *input,
  uint value,
  counter32_t counter)
{

 size_t globalId = get_global_id(0);

 if(value == input[globalId])
  atomic_inc(counter);

}
# 45 "AtomicCounters_Kernels.cl"
#pragma OPENCL EXTENSION cl_khr_global_int32_base_atomics : enable
__kernel
void globalAtomics(
  volatile __global uint *input,
  uint value,
  __global uint* counter)
{
 size_t globalId = get_global_id(0);

 if(value == input[globalId])
  atomic_inc(&counter[0]);
}
