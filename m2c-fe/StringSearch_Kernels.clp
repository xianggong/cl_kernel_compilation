# 1 "StringSearch_Kernels.cl"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "StringSearch_Kernels.cl"
# 26 "StringSearch_Kernels.cl"
int compare(__global const uchar* text, __local const uchar* pattern, uint length)
{
    for(uint l=0; l<length; ++l)
    {



        if ((('A' <= (text[l]) && (text[l]) <= 'Z') ? ((text[l] - 'A') + 'a') : (text[l])) != pattern[l]) return 0;

    }
    return 1;
}
# 51 "StringSearch_Kernels.cl"
__kernel void
    StringSearchNaive (
      __global uchar* text,
      const uint textLength,
      __global const uchar* pattern,
      const uint patternLength,
      __global int* resultBuffer,
      __global int* resultCountPerWG,
      const uint maxSearchLength,
      __local uchar* localPattern)
{
    __local volatile uint groupSuccessCounter;

    int localIdx = get_local_id(0);
    int localSize = get_local_size(0);
    int groupIdx = get_group_id(0);


    uint lastSearchIdx = textLength - patternLength + 1;


    uint beginSearchIdx = groupIdx * maxSearchLength;
    uint endSearchIdx = beginSearchIdx + maxSearchLength;
    if(beginSearchIdx > lastSearchIdx) return;
    if(endSearchIdx > lastSearchIdx) endSearchIdx = lastSearchIdx;


    for(int idx = localIdx; idx < patternLength; idx+=localSize)
    {



        localPattern[idx] = (('A' <= (pattern[idx]) && (pattern[idx]) <= 'Z') ? ((pattern[idx] - 'A') + 'a') : (pattern[idx]));

    }

    if(localIdx == 0) groupSuccessCounter = 0;
    barrier(CLK_LOCAL_MEM_FENCE);


    for(uint stringPos=beginSearchIdx+localIdx; stringPos<endSearchIdx; stringPos+=localSize)
    {
        if (compare(text+stringPos, localPattern, patternLength) == 1)
        {
            int count = atomic_inc(&groupSuccessCounter);
            resultBuffer[beginSearchIdx+count] = stringPos;
        }
    }

    barrier(CLK_LOCAL_MEM_FENCE);
    if(localIdx == 0) resultCountPerWG[groupIdx] = groupSuccessCounter;
}
# 118 "StringSearch_Kernels.cl"
__kernel void
    StringSearchLoadBalance (
      __global uchar* text,
      const uint textLength,
      __global const uchar* pattern,
      const uint patternLength,
      __global int* resultBuffer,
      __global int* resultCountPerWG,
      const uint maxSearchLength,
      __local uchar* localPattern,
      __local int* stack1



      )
{
    int localIdx = get_local_id(0);
    int localSize = get_local_size(0);
    int groupIdx = get_group_id(0);

    __local uint stack1Counter;
    __local uint stack2Counter;
    __local uint groupSuccessCounter;


    if(localIdx == 0)
    {
        groupSuccessCounter = 0;
        stack1Counter = 0;
        stack2Counter = 0;
    }


    uint lastSearchIdx = textLength - patternLength + 1;
    uint stackSize = 0;


    uint beginSearchIdx = groupIdx * maxSearchLength;
    uint endSearchIdx = beginSearchIdx + maxSearchLength;
    if(beginSearchIdx > lastSearchIdx) return;
    if(endSearchIdx > lastSearchIdx) endSearchIdx = lastSearchIdx;
    uint searchLength = endSearchIdx - beginSearchIdx;


    for(uint idx = localIdx; idx < patternLength; idx+=localSize)
    {



        localPattern[idx] = (('A' <= (pattern[idx]) && (pattern[idx]) <= 'Z') ? ((pattern[idx] - 'A') + 'a') : (pattern[idx]));

    }

    barrier(CLK_LOCAL_MEM_FENCE);

    uchar first = localPattern[0];
    uchar second = localPattern[1];
    int stringPos = localIdx;
    int stackPos = 0;
    int revStackPos = 0;

    while (true)
    {


        if(stringPos < searchLength)
        {




            if ((first == (('A' <= (text[beginSearchIdx+stringPos]) && (text[beginSearchIdx+stringPos]) <= 'Z') ? ((text[beginSearchIdx+stringPos] - 'A') + 'a') : (text[beginSearchIdx+stringPos]))) && (second == (('A' <= (text[beginSearchIdx+stringPos+1]) && (text[beginSearchIdx+stringPos+1]) <= 'Z') ? ((text[beginSearchIdx+stringPos+1] - 'A') + 'a') : (text[beginSearchIdx+stringPos+1]))))

            {
                stackPos = atomic_inc(&stack1Counter);
                stack1[stackPos] = stringPos;
            }
        }

        stringPos += localSize;

        barrier(CLK_LOCAL_MEM_FENCE);
            stackSize = stack1Counter;
        barrier(CLK_LOCAL_MEM_FENCE);


        if((stackSize < localSize) && ((((stringPos)/localSize)*localSize) < searchLength)) continue;
# 251 "StringSearch_Kernels.cl"
        if(localIdx < stackSize)
        {





            revStackPos = atomic_dec(&stack1Counter);
            int pos = stack1[--revStackPos];
            if (compare(text+beginSearchIdx+pos+2, localPattern+2, patternLength-2) == 1)

            {

                int count = atomic_inc(&groupSuccessCounter);
                resultBuffer[beginSearchIdx+count] = beginSearchIdx+pos;
            }
        }

        barrier(CLK_LOCAL_MEM_FENCE);
        if((((stringPos/localSize)*localSize) >= searchLength) && (stack1Counter <= 0) && (stack2Counter <= 0)) break;
    }

    if(localIdx == 0) resultCountPerWG[groupIdx] = groupSuccessCounter;
}
