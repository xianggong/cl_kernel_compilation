# 1 "RecursiveGaussian_Kernels.cl"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "RecursiveGaussian_Kernels.cl"
# 22 "RecursiveGaussian_Kernels.cl"
__kernel
void transpose_kernel(__global uchar4 *output,
                      __global uchar4 *input,
                      __local uchar4 *block,
                      const uint width,
                      const uint height,
                      const uint blockSize)
{
 uint globalIdx = get_global_id(0);
 uint globalIdy = get_global_id(1);

 uint localIdx = get_local_id(0);
 uint localIdy = get_local_id(1);


 block[localIdy * blockSize + localIdx] = input[globalIdy*width + globalIdx];


 barrier(CLK_LOCAL_MEM_FENCE);


 uint sourceIndex = localIdy * blockSize + localIdx;
 uint targetIndex = globalIdy + globalIdx * height;

 output[targetIndex] = block[sourceIndex];
}
# 60 "RecursiveGaussian_Kernels.cl"
__kernel void RecursiveGaussian_kernel(__global const uchar4* input, __global uchar4* output,
           const int width, const int height,
           const float a0, const float a1,
           const float a2, const float a3,
           const float b1, const float b2,
           const float coefp, const float coefn)
{

    unsigned int x = get_global_id(0);

    if (x >= width)
 return;


    float4 xp = (float4)0.0f;
    float4 yp = (float4)0.0f;
    float4 yb = (float4)0.0f;

    for (int y = 0; y < height; y++)
    {
   int pos = x + y * width;
        float4 xc = (float4)(input[pos].x, input[pos].y, input[pos].z, input[pos].w);
        float4 yc = (a0 * xc) + (a1 * xp) - (b1 * yp) - (b2 * yb);
   output[pos] = (uchar4)(yc.x, yc.y, yc.z, yc.w);
        xp = xc;
        yb = yp;
        yp = yc;

    }

     barrier(CLK_GLOBAL_MEM_FENCE);



    float4 xn = (float4)(0.0f);
    float4 xa = (float4)(0.0f);
    float4 yn = (float4)(0.0f);
    float4 ya = (float4)(0.0f);


    for (int y = height - 1; y > -1; y--)
    {
        int pos = x + y * width;
        float4 xc = (float4)(input[pos].x, input[pos].y, input[pos].z, input[pos].w);
        float4 yc = (a2 * xn) + (a3 * xa) - (b1 * yn) - (b2 * ya);
        xa = xn;
        xn = xc;
        ya = yn;
        yn = yc;
   float4 temp = (float4)(output[pos].x, output[pos].y, output[pos].z, output[pos].w) + yc;
   output[pos] = (uchar4)(temp.x, temp.y, temp.z, temp.w);

    }
}
