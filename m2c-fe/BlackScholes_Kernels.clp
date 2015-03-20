# 1 "BlackScholes_Kernels.cl"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "BlackScholes_Kernels.cl"
# 42 "BlackScholes_Kernels.cl"
void phi(float4 X, float4* phi)
{
    float4 y;
    float4 absX;
    float4 t;
    float4 result;

    const float4 c1 = (float4)0.319381530f;
    const float4 c2 = (float4)-0.356563782f;
    const float4 c3 = (float4)1.781477937f;
    const float4 c4 = (float4)-1.821255978f;
    const float4 c5 = (float4)1.330274429f;

    const float4 zero = (float4)0.0f;
    const float4 one = (float4)1.0f;
    const float4 two = (float4)2.0f;
    const float4 temp4 = (float4)0.2316419f;

    const float4 oneBySqrt2pi = (float4)0.398942280f;

    absX = fabs(X);
    t = one/(one + temp4 * absX);

    y = one - oneBySqrt2pi * exp(-X*X/two) * t
        * (c1 + t
              * (c2 + t
                    * (c3 + t
                          * (c4 + t * c5))));

    result = (X < zero)? (one - y) : y;

    *phi = result;
}
# 87 "BlackScholes_Kernels.cl"
__kernel
void
blackScholes(const __global float4 *randArray,
             int width,
             __global float4 *call,
             __global float4 *put)
{
    float4 d1, d2;
    float4 phiD1, phiD2;
    float4 sigmaSqrtT;
    float4 KexpMinusRT;

    size_t xPos = get_global_id(0);
    size_t yPos = get_global_id(1);
    float4 two = (float4)2.0f;
    float4 inRand = randArray[yPos * width + xPos];
    float4 S = 10.0f * inRand + 100.0f * (1.0f - inRand);
    float4 K = 10.0f * inRand + 100.0f * (1.0f - inRand);
    float4 T = 1.0f * inRand + 10.0f * (1.0f - inRand);
    float4 R = 0.01f * inRand + 0.05f * (1.0f - inRand);
    float4 sigmaVal = 0.01f * inRand + 0.10f * (1.0f - inRand);


    sigmaSqrtT = sigmaVal * sqrt(T);

    d1 = (log(S/K) + (R + sigmaVal * sigmaVal / two)* T)/ sigmaSqrtT;
    d2 = d1 - sigmaSqrtT;

    KexpMinusRT = K * exp(-R * T);
    phi(d1, &phiD1);
    phi(d2, &phiD2);
    call[yPos * width + xPos] = S * phiD1 - KexpMinusRT * phiD2;
    phi(-d1, &phiD1);
    phi(-d2, &phiD2);
    put[yPos * width + xPos] = KexpMinusRT * phiD2 - S * phiD1;
}

void phi_scalar(float X, float* phi)
{
    float y;
    float absX;
    float t;
    float result;

    const float c1 = (float)0.319381530f;
    const float c2 = (float)-0.356563782f;
    const float c3 = (float)1.781477937f;
    const float c4 = (float)-1.821255978f;
    const float c5 = (float)1.330274429f;

    const float zero = (float)0.0f;
    const float one = (float)1.0f;
    const float two = (float)2.0f;
    const float temp4 = (float)0.2316419f;

    const float oneBySqrt2pi = (float)0.398942280f;

    absX = fabs(X);
    t = one/(one + temp4 * absX);

    y = one - oneBySqrt2pi * exp(-X*X/two) * t
        * (c1 + t
              * (c2 + t
                    * (c3 + t
                          * (c4 + t * c5))));

    result = (X < zero)? (one - y) : y;

    *phi = result;
}
# 169 "BlackScholes_Kernels.cl"
__kernel
void
blackScholes_scalar(const __global float *randArray,
             int width,
             __global float *call,
             __global float *put)
{
    float d1, d2;
    float phiD1, phiD2;
    float sigmaSqrtT;
    float KexpMinusRT;

    size_t xPos = get_global_id(0);
    size_t yPos = get_global_id(1);
    float two = (float)2.0f;
    float inRand = randArray[yPos * width + xPos];
    float S = 10.0f * inRand + 100.0f * (1.0f - inRand);
    float K = 10.0f * inRand + 100.0f * (1.0f - inRand);
    float T = 1.0f * inRand + 10.0f * (1.0f - inRand);
    float R = 0.01f * inRand + 0.05f * (1.0f - inRand);
    float sigmaVal = 0.01f * inRand + 0.10f * (1.0f - inRand);


    sigmaSqrtT = sigmaVal * sqrt(T);

    d1 = (log(S/K) + (R + sigmaVal * sigmaVal / two)* T)/ sigmaSqrtT;
    d2 = d1 - sigmaSqrtT;

    KexpMinusRT = K * exp(-R * T);
    phi_scalar(d1, &phiD1);
    phi_scalar(d2, &phiD2);
    call[yPos * width + xPos] = S * phiD1 - KexpMinusRT * phiD2;
    phi_scalar(-d1, &phiD1);
    phi_scalar(-d2, &phiD2);
    put[yPos * width + xPos] = KexpMinusRT * phiD2 - S * phiD1;
}
