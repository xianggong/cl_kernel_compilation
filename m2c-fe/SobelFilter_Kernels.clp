# 1 "SobelFilter_Kernels.cl"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "SobelFilter_Kernels.cl"
# 27 "SobelFilter_Kernels.cl"
__kernel void sobel_filter(__global uchar4* inputImage, __global uchar4* outputImage)
{
 uint x = get_global_id(0);
    uint y = get_global_id(1);

 uint width = get_global_size(0);
 uint height = get_global_size(1);

 float4 Gx = (float4)(0);
 float4 Gy = Gx;

 int c = x + y * width;



 if( x >= 1 && x < (width-1) && y >= 1 && y < height - 1)
 {
  float4 i00 = convert_float4(inputImage[c - 1 - width]);
  float4 i10 = convert_float4(inputImage[c - width]);
  float4 i20 = convert_float4(inputImage[c + 1 - width]);
  float4 i01 = convert_float4(inputImage[c - 1]);
  float4 i11 = convert_float4(inputImage[c]);
  float4 i21 = convert_float4(inputImage[c + 1]);
  float4 i02 = convert_float4(inputImage[c - 1 + width]);
  float4 i12 = convert_float4(inputImage[c + width]);
  float4 i22 = convert_float4(inputImage[c + 1 + width]);

  Gx = i00 + (float4)(2) * i10 + i20 - i02 - (float4)(2) * i12 - i22;

  Gy = i00 - i20 + (float4)(2)*i01 - (float4)(2)*i21 + i02 - i22;


  outputImage[c] = convert_uchar4(hypot(Gx, Gy)/(float4)(2));

 }

}
