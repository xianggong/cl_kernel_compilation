# 1 "GaussianNoiseGL_Kernels2.cl"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "GaussianNoiseGL_Kernels2.cl"
# 36 "GaussianNoiseGL_Kernels2.cl"
float ran1(int idum, __local int *iv)
{
    int j;
    int k;
    int iy = 0;

    int tid = get_local_id(0);

    for(j = 4; j >=0; j--)
    {
        k = idum / 127773;
        idum = 16807 * (idum - k * 127773) - 2836 * k;

        if(idum < 0)
            idum += 2147483647;

        if(j < 4)
            iv[4* tid + j] = idum;
    }
    iy = iv[0];


    k = idum / 127773;
    idum = 16807 * (idum - k * 127773) - 2836 * k;

    if(idum < 0)
        idum += 2147483647;

    j = iy / (1 + (2147483647 - 1)/ 4);
    iy = iv[4 * tid + j];
    return ((1.0/2147483647) * iy);
}



float2 BoxMuller(float2 uniform)
{
    float r = sqrt(-2 * log(uniform.x));
    float theta = 2 * 3.14 * uniform.y;
    return (float2)(r * sin(theta), r * cos(theta));
}
