# 1 "DeviceFission11Ext_Kernels.cl"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "DeviceFission11Ext_Kernels.cl"
# 20 "DeviceFission11Ext_Kernels.cl"
__kernel
void
copy(__global float* input, __global float* output)
{
    size_t xPos = get_global_id(0);
    output[xPos] = input[xPos];
}
