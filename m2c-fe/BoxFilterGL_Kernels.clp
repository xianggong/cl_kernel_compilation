# 1 "BoxFilterGL_Kernels.cl"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "BoxFilterGL_Kernels.cl"
# 32 "BoxFilterGL_Kernels.cl"
__kernel void box_filter(__global uint4* inputImage, __global uchar4* outputImage, int N)
{
 int x = get_global_id(0);
 int y = get_global_id(1);
 int width = get_global_size(0);
 int height = get_global_size(1);
 int k = (N - 1) / 2;

 if(x < k || y < k || x > width - k - 1 || y > height - k - 1)
 {
  outputImage[x + y * width] = (uchar4)(0);
  return;
 }


 int4 filterSize = (int4)(N * N);

 int2 posA = (int2)(x - k, y - k);
 int2 posB = (int2)(x + k, y - k);
 int2 posC = (int2)(x + k, y + k);
 int2 posD = (int2)(x - k, y + k);

 int4 sumA = (int4)(0);
 int4 sumB = (int4)(0);
 int4 sumC = (int4)(0);
 int4 sumD = (int4)(0);


 posA.x -= 1;
 posA.y -= 1;
 posB.y -= 1;
 posD.x -= 1;

 if(posA.x >= 0 && posA.y >= 0)
 {
  sumA = convert_int4(inputImage[posA.x + posA.y * width]);
 }
 if(posB.x >= 0 && posB.y >= 0)
 {
  sumB = convert_int4(inputImage[posB.x + posB.y * width]);
 }
 if(posD.x >= 0 && posD.y >= 0)
 {
  sumD = convert_int4(inputImage[posD.x + posD.y * width]);
 }
 sumC = convert_int4(inputImage[posC.x + posC.y * width]);

 outputImage[x + y * width] = convert_uchar4((sumA + sumC - sumB - sumD) / filterSize);

}

__kernel void horizontalSAT0(__global uchar4* input,
        __global uint4* output,
        int i, int r, int width)
{
 int x = get_global_id(0);
 int y = get_global_id(1);
 int pos = x + y * width;





 int c = pow((float)r, (float)i);

 uint4 sum = 0;

 for(int j = 0; j < r; j++)
 {
  if((x - (j * c)) < 0)
  {
   output[pos] = sum;
   return;
  }

  sum += convert_uint4(input[pos - (j * c)]);
 }

 output[pos] = sum;
}

__kernel void horizontalSAT(__global uint4* input,
          __global uint4* output,
       int i, int r, int width)
{
 int x = get_global_id(0);
 int y = get_global_id(1);
 int pos = x + y * width;

 int c = pow((float)r, (float)i);

 uint4 sum = 0;

 for(int j = 0; j < r; j++)
 {
  if(x - (j * c) < 0)
  {
   output[pos] = sum;
   return;
  }
  sum += input[pos - (j * c)];
 }

 output[pos] = sum;
}


__kernel void verticalSAT(__global uint4* input,
                 __global uint4* output,
                 int i, int r, int width)
{
 int x = get_global_id(0);
 int y = get_global_id(1);

 int c = pow((float)r, (float)i);

 uint4 sum = (uint4)(0);

 for(int j = 0; j < r; j++)
 {
  if(y - (j * c) < 0)
  {
   output[x + y * width] = sum;
   return;
  }

  sum += input[x + width * (y - (j * c))];
 }

 output[x + y * width] = sum;
}
# 171 "BoxFilterGL_Kernels.cl"
__kernel void box_filter_horizontal(__global uchar4* inputImage, __global uchar4* outputImage, int filterWidth)
{
 int x = get_global_id(0);
    int y = get_global_id(1);

 int width = get_global_size(0);
 int height = get_global_size(1);

 int pos = x + y * width;
 int k = (filterWidth - 1)/2;


 if(x < k || x >= (width - k))
 {
  outputImage[pos] = (uchar4)(0);
  return;
 }

 int4 size = (int4)(filterWidth);

 int4 sum = 0;

 for(int X = -k; X < k; X=X+2)
 {
  sum += convert_int4(inputImage[pos + X]);
  sum += convert_int4(inputImage[pos + X + 1]);
 }
 sum += convert_int4(inputImage[pos + k]);
 outputImage[pos] = convert_uchar4(sum / size);
}


__kernel void box_filter_vertical(__global uchar4* inputImage, __global uchar4* outputImage, int filterWidth)
{
 int x = get_global_id(0);
     int y = get_global_id(1);

 int width = get_global_size(0);
 int height = get_global_size(1);

 int pos = x + y * width;
 int k = (filterWidth - 1)/2;


 if(y < k || y >= (height - k))
 {
  outputImage[pos] = (uchar4)(0);
  return;
 }

 int4 size = (int4)(filterWidth);

 int4 sum = 0;

 for(int Y = -k; Y < k; Y=Y+2)
 {
  sum += convert_int4(inputImage[pos + Y * width]);
  sum += convert_int4(inputImage[pos + (Y + 1) * width]);
 }
 sum += convert_int4(inputImage[pos + k * width]);
 outputImage[pos] = convert_uchar4(sum / size);
}


__kernel void box_filter_horizontal_local(__global uchar4* inputImage, __global uchar4* outputImage, int filterWidth, __local uchar4 *lds)
{
 int x = get_global_id(0);
     int y = get_global_id(1);

 int width = get_global_size(0);
 int height = get_global_size(1);

 int pos = x + y * width;
 int k = (filterWidth - 1)/2;


 int lid = get_local_id(0);
 int gidX = get_group_id(0);
 int gidY = get_group_id(1);

 int gSizeX = get_local_size(0);
 int gSizeY = get_local_size(1);

 int firstElement = gSizeX * gidX + width * gidY * gSizeY;


 if(lid < k)
 {
  lds[lid] = inputImage[firstElement - k + lid];
  lds[256 + k + lid] = inputImage[firstElement + lid + 256];
 }


 lds[lid + k] = inputImage[firstElement + lid];

 barrier(CLK_LOCAL_MEM_FENCE);


 if(x < k || x >= (width - k))
  return;

 int4 size = (int4)(filterWidth);

 int4 sum = 0;

 for(int X = -k; X <= k; X++)
 {
  sum += convert_int4(lds[lid + X + k]);
 }
 outputImage[pos] = convert_uchar4(sum / size);
}
