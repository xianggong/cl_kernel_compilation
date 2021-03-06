# 1 "BinomialOptionMultiGPU_Kernels.cl"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "BinomialOptionMultiGPU_Kernels.cl"
# 35 "BinomialOptionMultiGPU_Kernels.cl"
__kernel
void
binomial_options(
    int numSteps,
    const __global float4* randArray,
    __global float4* output,
    __local float4* callA,
    __local float4* callB)
{

    unsigned int tid = get_local_id(0);
    unsigned int bid = get_group_id(0);

    float4 inRand = randArray[bid];

    float4 s = (1.0f - inRand) * 5.0f + inRand * 30.f;
    float4 x = (1.0f - inRand) * 1.0f + inRand * 100.f;
    float4 optionYears = (1.0f - inRand) * 0.25f + inRand * 10.f;
    float4 dt = optionYears * (1.0f / (float)numSteps);
    float4 vsdt = 0.30f * sqrt(dt);
    float4 rdt = 0.02f * dt;
    float4 r = exp(rdt);
    float4 rInv = 1.0f / r;
    float4 u = exp(vsdt);
    float4 d = 1.0f / u;
    float4 pu = (r - d)/(u - d);
    float4 pd = 1.0f - pu;
    float4 puByr = pu * rInv;
    float4 pdByr = pd * rInv;

    float4 profit = s * exp(vsdt * (2.0f * tid - (float)numSteps)) - x;
    callA[tid].x = profit.x > 0 ? profit.x : 0.0f;
    callA[tid].y = profit.y > 0 ? profit.y : 0.0f;
    callA[tid].z = profit.z > 0 ? profit.z: 0.0f;
    callA[tid].w = profit.w > 0 ? profit.w: 0.0f;

    barrier(CLK_LOCAL_MEM_FENCE);

    for(int j = numSteps; j > 0; j -= 2)
    {
        if(tid < j)
        {
            callB[tid] = puByr * callA[tid] + pdByr * callA[tid + 1];
        }
        barrier(CLK_LOCAL_MEM_FENCE);

        if(tid < j - 1)
        {
            callA[tid] = puByr * callB[tid] + pdByr * callB[tid + 1];
        }
        barrier(CLK_LOCAL_MEM_FENCE);
    }


    if(tid == 0) output[bid] = callA[0];
}
