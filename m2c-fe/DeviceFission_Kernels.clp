# 1 "DeviceFission_Kernels.cl"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "DeviceFission_Kernels.cl"
# 20 "DeviceFission_Kernels.cl"
__kernel
void
Add(__global int* input, __global int* output)
{
    size_t xPos = get_global_id(0);
    output[xPos] = input[xPos] + 1;
}

__kernel
void
Sub(__global int* input, __global int* output)
{
    size_t xPos = get_global_id(0);
    output[xPos] = input[xPos] - 1;
}
