# 1 "LUDecomposition_Kernels.cl"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "LUDecomposition_Kernels.cl"
# 20 "LUDecomposition_Kernels.cl"
#pragma OPENCL EXTENSION cl_amd_fp64 : enable
# 32 "LUDecomposition_Kernels.cl"
__kernel void kernelLUDecompose(__global double4* LMatrix,
                           __global double4* inplaceMatrix,
                            int d,
                            __local double* ratio)
{

    int y = get_global_id(1);
    int x = get_global_id(0);
    int lidx = get_local_id(0);
    int lidy = get_local_id(1);

    int xdimension = get_global_size(0) + d / 4;
    int D = d % 4;

    if(get_local_id(0) == 0)
    {


        (D == 0) ? (ratio[lidy] = inplaceMatrix[ y * xdimension + d / 4].s0 / inplaceMatrix[ d * xdimension + d / 4].s0):1;
        (D == 1) ? (ratio[lidy] = inplaceMatrix[ y * xdimension + d / 4].s1 / inplaceMatrix[ d * xdimension + d / 4].s1):1;
        (D == 2) ? (ratio[lidy] = inplaceMatrix[ y * xdimension + d / 4].s2 / inplaceMatrix[ d * xdimension + d / 4].s2):1;
        (D == 3) ? (ratio[lidy] = inplaceMatrix[ y * xdimension + d / 4].s3 / inplaceMatrix[ d * xdimension + d / 4].s3):1;
    }

    barrier(CLK_LOCAL_MEM_FENCE);


    if(y >= d + 1 && ((x + 1) * 4) > d)
    {
        double4 result;


        {
            result.s0 = inplaceMatrix[y * xdimension + x].s0 - ratio[lidy] * inplaceMatrix[ d * xdimension + x].s0;
            result.s1 = inplaceMatrix[y * xdimension + x].s1 - ratio[lidy] * inplaceMatrix[ d * xdimension + x].s1;
            result.s2 = inplaceMatrix[y * xdimension + x].s2 - ratio[lidy] * inplaceMatrix[ d * xdimension + x].s2;
            result.s3 = inplaceMatrix[y * xdimension + x].s3 - ratio[lidy] * inplaceMatrix[ d * xdimension + x].s3;
        }


        if(x == d / 4)
        {
            (D == 0) ? (LMatrix[y * xdimension + x].s0 = ratio[lidy]) : (inplaceMatrix[y * xdimension + x].s0 = result.s0);
            (D == 1) ? (LMatrix[y * xdimension + x].s1 = ratio[lidy]) : (inplaceMatrix[y * xdimension + x].s1 = result.s1);
            (D == 2) ? (LMatrix[y * xdimension + x].s2 = ratio[lidy]) : (inplaceMatrix[y * xdimension + x].s2 = result.s2);
            (D == 3) ? (LMatrix[y * xdimension + x].s3 = ratio[lidy]) : (inplaceMatrix[y * xdimension + x].s3 = result.s3);
        }
        else
        {
            inplaceMatrix[y * xdimension + x].s0 = result.s0;
            inplaceMatrix[y * xdimension + x].s1 = result.s1;
            inplaceMatrix[y * xdimension + x].s2 = result.s2;
            inplaceMatrix[y * xdimension + x].s3 = result.s3;
        }
    }
}
# 99 "LUDecomposition_Kernels.cl"
__kernel void kernelLUCombine(__global double* LMatrix,
                         __global double* inplaceMatrix)
{
    int i = get_global_id(1);
    int j = get_global_id(0);
    int gidx = get_group_id(0);
    int gidy = get_group_id(1);
    int dimension = get_global_size(0);
    if(i>j )
    {
        int dimension = get_global_size(0);
        inplaceMatrix[i * dimension + j] = LMatrix[i * dimension + j];
    }
}
