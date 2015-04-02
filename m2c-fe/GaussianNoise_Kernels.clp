# 1 "GaussianNoise_Kernels.cl"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "GaussianNoise_Kernels.cl"
# 34 "GaussianNoise_Kernels.cl"
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


__kernel void gaussian_transform(__global uchar4* inputImage, __global uchar4 *outputImage, int factor)
{

 int pos = get_global_id(0) + 2 * get_global_size(0) * get_global_id(1);


 float4 texel0 = convert_float4(inputImage[pos]);
 float4 texel1 = convert_float4(inputImage[pos + get_global_size(0)]);


 float avg0 = (texel0.x + texel0.y + texel0.z + texel0.w) / 4;
 float avg1 = (texel1.x + texel1.y + texel1.z + texel1.w) / 4;

 __local int iv0[4 * 256];
 __local int iv1[4 * 256];


 float dev0 = ran1(-avg0, iv0);
 float dev1 = ran1(-avg1, iv1);


 float2 gaussian = BoxMuller((float2)(dev0, dev1));


 outputImage[pos] = convert_uchar4_sat(texel0 + (float4)(gaussian.x * factor));
 outputImage[pos + get_global_size(0)] = convert_uchar4_sat(texel1 + (float4)(gaussian.y * factor));

}
