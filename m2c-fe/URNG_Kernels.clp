# 1 "URNG_Kernels.cl"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "URNG_Kernels.cl"
# 35 "URNG_Kernels.cl"
float ran1(int idum, __local int *iv)
{
    int j;
    int k;
    int iy = 0;
    int tid = get_local_id(0) + get_local_id(1) * get_local_size(0);

    for(j = 16; j >=0; j--)
    {
        k = idum / 127773;
        idum = 16807 * (idum - k * 127773) - 2836 * k;

        if(idum < 0)
            idum += 2147483647;

        if(j < 16)
            iv[16* tid + j] = idum;
    }
    iy = iv[16* tid];

    k = idum / 127773;
    idum = 16807 * (idum - k * 127773) - 2836 * k;

    if(idum < 0)
        idum += 2147483647;

    j = iy / (1 + (2147483647 - 1)/ 16);
    iy = iv[16 * tid + j];
    return ((1.0f/2147483647) * iy);
}



__kernel void noise_uniform(__global uchar4* inputImage, __global uchar4* outputImage, int factor)
{
 int pos = get_global_id(0) + get_global_id(1) * get_global_size(0);

 float4 temp = convert_float4(inputImage[pos]);


 float avg = (temp.x + temp.y + temp.z + temp.y) / 4;



 __local int iv[16 * 64];


 float dev = ran1(-avg, iv);
 dev = (dev - 0.55f) * factor;


 outputImage[pos] = convert_uchar4_sat(temp + (float4)(dev));


}
