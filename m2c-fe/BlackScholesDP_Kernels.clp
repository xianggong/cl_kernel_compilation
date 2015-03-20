# 1 "BlackScholesDP_Kernels.cl"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "BlackScholesDP_Kernels.cl"
# 29 "BlackScholesDP_Kernels.cl"
#pragma OPENCL EXTENSION cl_amd_fp64 : enable
# 48 "BlackScholesDP_Kernels.cl"
void phi(double4 X, double4* phi)
{
    double4 y;
    double4 absX;
    double4 t;
    double4 result;

    const double4 c1 = (double4)0.319381530;
    const double4 c2 = (double4)-0.356563782;
    const double4 c3 = (double4)1.781477937;
    const double4 c4 = (double4)-1.821255978;
    const double4 c5 = (double4)1.330274429;

    const double4 zero = (double4)0.0;
    const double4 one = (double4)1.0;
    const double4 two = (double4)2.0;
    const double4 temp4 = (double4)0.2316419;

    const double4 oneBySqrt2pi = (double4)0.398942280;

    absX = fabs(X);
    t = one / (one + temp4 * absX);

    y = one - oneBySqrt2pi * exp(-X * X / two) * t
        * (c1 + t
              * (c2 + t
                    * (c3 + t
                          * (c4 + t * c5))));

    result = (X < zero)? (one - y) : y;

    *phi = result;
}
# 93 "BlackScholesDP_Kernels.cl"
__kernel
void
blackScholes(const __global double4 *randArray,
             int width,
             __global double4 *call,
             __global double4 *put)
{
    double4 d1, d2;
    double4 phiD1, phiD2;
    double4 sigmaSqrtT;
    double4 KexpMinusRT;

    size_t xPos = get_global_id(0);
    size_t yPos = get_global_id(1);
    double4 two = (double4)2.0;
    double4 inRand = randArray[yPos * width + xPos];
    double4 S = 10.0 * inRand + 100.0 * (1.0 - inRand);
    double4 K = 10.0 * inRand + 100.0 * (1.0 - inRand);
    double4 T = 1.0 * inRand + 10.0 * (1.0 - inRand);
    double4 R = 0.01 * inRand + 0.05 * (1.0 - inRand);
    double4 sigmaVal = 0.01 * inRand + 0.10 * (1.0 - inRand);


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
