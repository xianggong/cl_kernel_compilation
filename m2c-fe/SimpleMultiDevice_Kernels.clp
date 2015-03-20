# 1 "SimpleMultiDevice_Kernels.cl"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "SimpleMultiDevice_Kernels.cl"
# 18 "SimpleMultiDevice_Kernels.cl"
__kernel void multiDeviceKernel(__global float *input,
                                __global float *output)
{
    uint tid = get_global_id(0);

    float a = mad(input[tid], input[tid], 1);
    float b = mad(input[tid], input[tid], 2);

    for(int i = 0; i < KERNEL_ITERATIONS; i++)
    {
        a = hypot(a, b);
        b = hypot(a, b);
     }

    output[tid] = (a + b);
}
