# 1 "DCT_Kernels.cl"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "DCT_Kernels.cl"
# 27 "DCT_Kernels.cl"
uint
getIdx(uint blockIdx, uint blockIdy, uint localIdx, uint localIdy, uint blockWidth, uint globalWidth)
{
    uint globalIdx = blockIdx * blockWidth + localIdx;
    uint globalIdy = blockIdy * blockWidth + localIdy;

    return (globalIdy * globalWidth + globalIdx);
}
# 47 "DCT_Kernels.cl"
__kernel
void DCT(__global float * output,
         __global float * input,
         __global float * dct8x8,
   __global float * dct8x8_trans,
         __local float * inter,
         const uint width,
         const uint blockWidth,
         const uint inverse)

{

    uint globalIdx = get_global_id(0);
    uint globalIdy = get_global_id(1);


    uint groupIdx = get_group_id(0);
    uint groupIdy = get_group_id(1);


    uint i = get_local_id(0);
    uint j = get_local_id(1);

    uint idx = globalIdy * width + globalIdx;


    float acc = 0.0f;


    for(uint k=0; k < blockWidth; k++)
    {
        uint index1 = j*blockWidth +k;
        uint index2 = getIdx(groupIdx, groupIdy, i, k, blockWidth, width);

   if (inverse)
   acc += dct8x8[index1]*input[index2];
   else
   acc += dct8x8_trans[index1]*input[index2];
    }
    inter[j*blockWidth + i] = acc;





    barrier(CLK_LOCAL_MEM_FENCE);


    acc = 0.0f;


    for(uint k=0; k < blockWidth; k++)
    {
        uint index1 = j* blockWidth + k;
        uint index2 = k*blockWidth + i;

  if (inverse)
   acc += inter[index1]*dct8x8_trans[index2];
  else
   acc += inter[index1]*dct8x8[index2];
    }
    output[idx] = acc;
}
