# 1 "MatrixMultiplicationCPPKernel_Kernels.cl"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "MatrixMultiplicationCPPKernel_Kernels.cl"
# 25 "MatrixMultiplicationCPPKernel_Kernels.cl"
template <class T>
kernel void mmmKernel(global T * matrixA,
       global T * matrixB,
       global T * matrixC,
       uint widthA,
       uint widthB)
{
 int2 pos = (int2)(get_global_id(0), get_global_id(1));


 T sum0 = (T)(0);
 T sum1 = (T)(0);
 T sum2 = (T)(0);
 T sum3 = (T)(0);


 widthB /= 4;

 for(int i = 0; i < widthA; i=i+4)
 {
  T tempA0 = matrixA[i/4 + (pos.y << 2) * (widthA / 4)];
  T tempA1 = matrixA[i/4 + ((pos.y << 2) + 1) * (widthA / 4)];
  T tempA2 = matrixA[i/4 + ((pos.y << 2) + 2) * (widthA / 4)];
  T tempA3 = matrixA[i/4 + ((pos.y << 2) + 3) * (widthA / 4)];


  T tempB0 = matrixB[pos.x + i * widthB];
  T tempB1 = matrixB[pos.x + (i + 1) * widthB];
  T tempB2 = matrixB[pos.x + (i + 2) * widthB];
  T tempB3 = matrixB[pos.x + (i + 3) * widthB];

  sum0.x += tempA0.x * tempB0.x + tempA0.y * tempB1.x + tempA0.z * tempB2.x + tempA0.w * tempB3.x;
  sum0.y += tempA0.x * tempB0.y + tempA0.y * tempB1.y + tempA0.z * tempB2.y + tempA0.w * tempB3.y;
  sum0.z += tempA0.x * tempB0.z + tempA0.y * tempB1.z + tempA0.z * tempB2.z + tempA0.w * tempB3.z;
  sum0.w += tempA0.x * tempB0.w + tempA0.y * tempB1.w + tempA0.z * tempB2.w + tempA0.w * tempB3.w;

  sum1.x += tempA1.x * tempB0.x + tempA1.y * tempB1.x + tempA1.z * tempB2.x + tempA1.w * tempB3.x;
  sum1.y += tempA1.x * tempB0.y + tempA1.y * tempB1.y + tempA1.z * tempB2.y + tempA1.w * tempB3.y;
  sum1.z += tempA1.x * tempB0.z + tempA1.y * tempB1.z + tempA1.z * tempB2.z + tempA1.w * tempB3.z;
  sum1.w += tempA1.x * tempB0.w + tempA1.y * tempB1.w + tempA1.z * tempB2.w + tempA1.w * tempB3.w;

  sum2.x += tempA2.x * tempB0.x + tempA2.y * tempB1.x + tempA2.z * tempB2.x + tempA2.w * tempB3.x;
  sum2.y += tempA2.x * tempB0.y + tempA2.y * tempB1.y + tempA2.z * tempB2.y + tempA2.w * tempB3.y;
  sum2.z += tempA2.x * tempB0.z + tempA2.y * tempB1.z + tempA2.z * tempB2.z + tempA2.w * tempB3.z;
  sum2.w += tempA2.x * tempB0.w + tempA2.y * tempB1.w + tempA2.z * tempB2.w + tempA2.w * tempB3.w;

  sum3.x += tempA3.x * tempB0.x + tempA3.y * tempB1.x + tempA3.z * tempB2.x + tempA3.w * tempB3.x;
  sum3.y += tempA3.x * tempB0.y + tempA3.y * tempB1.y + tempA3.z * tempB2.y + tempA3.w * tempB3.y;
  sum3.z += tempA3.x * tempB0.z + tempA3.y * tempB1.z + tempA3.z * tempB2.z + tempA3.w * tempB3.z;
  sum3.w += tempA3.x * tempB0.w + tempA3.y * tempB1.w + tempA3.z * tempB2.w + tempA3.w * tempB3.w;
 }
 matrixC[pos.x + ((pos.y << 2) + 0) * widthB] = sum0;
 matrixC[pos.x + ((pos.y << 2) + 1) * widthB] = sum1;
 matrixC[pos.x + ((pos.y << 2) + 2) * widthB] = sum2;
 matrixC[pos.x + ((pos.y << 2) + 3) * widthB] = sum3;
}

template __attribute__((mangled_name(mmmKernelFloat4)))
kernel void mmmKernel(__global float4 *matrixA,
       __global float4 *matrixB,
       __global float4* matrixC,
       uint widthA,
       uint widthB);
template __attribute__((mangled_name(mmmKernelInt4)))
kernel void mmmKernel(__global int4 *matrixA,
       __global int4 *matrixB,
       __global int4* matrixC,
       uint widthA,
       uint widthB);




template <class T>
kernel void mmmKernel_local(global T * matrixA,
       global T * matrixB,
       global T * matrixC,
       int widthA,
       __local T *blockA)

{
 int blockPos = get_local_id(0) + get_local_size(0) * (get_local_id(1) << 2);


 int globalPos = get_global_id(0) + (get_global_id(1) << 2) * get_global_size(0);


 T sum0 = (T)(0);
 T sum1 = (T)(0);
 T sum2 = (T)(0);
 T sum3 = (T)(0);

 int temp = widthA / 4;


 for(int i = 0; i < (temp / get_local_size(0)); i++)
 {

  int globalPosA = i * get_local_size(0) + get_local_id(0) + (get_global_id(1) << 2) * temp;


  blockA[blockPos] = matrixA[globalPosA];
  blockA[blockPos + get_local_size(0)] = matrixA[globalPosA + temp];
  blockA[blockPos + 2 * get_local_size(0)] = matrixA[globalPosA + 2 * temp];
  blockA[blockPos + 3 * get_local_size(0)] = matrixA[globalPosA + 3 * temp];

  barrier(CLK_LOCAL_MEM_FENCE);


  int globalPosB = get_global_id(0) + ((i * get_local_size(0)) << 2) * get_global_size(0);


  for(int j = 0; j < get_local_size(0) * 4; j=j+4)
  {

   T tempA0 = blockA[(j >> 2) + get_local_id(1) * 4 * get_local_size(0)];
   T tempA1 = blockA[(j >> 2) + (get_local_id(1) * 4 + 1) * get_local_size(0)];
   T tempA2 = blockA[(j >> 2) + (get_local_id(1) * 4 + 2) * get_local_size(0)];
   T tempA3 = blockA[(j >> 2) + (get_local_id(1) * 4 + 3) * get_local_size(0)];


   T tempB0 = matrixB[globalPosB + j * get_global_size(0)];
   T tempB1 = matrixB[globalPosB + (j + 1) * get_global_size(0)];
   T tempB2 = matrixB[globalPosB + (j + 2) * get_global_size(0)];
   T tempB3 = matrixB[globalPosB + (j + 3) * get_global_size(0)];

   sum0.x += tempA0.x * tempB0.x + tempA0.y * tempB1.x + tempA0.z * tempB2.x + tempA0.w * tempB3.x;
   sum0.y += tempA0.x * tempB0.y + tempA0.y * tempB1.y + tempA0.z * tempB2.y + tempA0.w * tempB3.y;
   sum0.z += tempA0.x * tempB0.z + tempA0.y * tempB1.z + tempA0.z * tempB2.z + tempA0.w * tempB3.z;
   sum0.w += tempA0.x * tempB0.w + tempA0.y * tempB1.w + tempA0.z * tempB2.w + tempA0.w * tempB3.w;

   sum1.x += tempA1.x * tempB0.x + tempA1.y * tempB1.x + tempA1.z * tempB2.x + tempA1.w * tempB3.x;
   sum1.y += tempA1.x * tempB0.y + tempA1.y * tempB1.y + tempA1.z * tempB2.y + tempA1.w * tempB3.y;
   sum1.z += tempA1.x * tempB0.z + tempA1.y * tempB1.z + tempA1.z * tempB2.z + tempA1.w * tempB3.z;
   sum1.w += tempA1.x * tempB0.w + tempA1.y * tempB1.w + tempA1.z * tempB2.w + tempA1.w * tempB3.w;

   sum2.x += tempA2.x * tempB0.x + tempA2.y * tempB1.x + tempA2.z * tempB2.x + tempA2.w * tempB3.x;
   sum2.y += tempA2.x * tempB0.y + tempA2.y * tempB1.y + tempA2.z * tempB2.y + tempA2.w * tempB3.y;
   sum2.z += tempA2.x * tempB0.z + tempA2.y * tempB1.z + tempA2.z * tempB2.z + tempA2.w * tempB3.z;
   sum2.w += tempA2.x * tempB0.w + tempA2.y * tempB1.w + tempA2.z * tempB2.w + tempA2.w * tempB3.w;

   sum3.x += tempA3.x * tempB0.x + tempA3.y * tempB1.x + tempA3.z * tempB2.x + tempA3.w * tempB3.x;
   sum3.y += tempA3.x * tempB0.y + tempA3.y * tempB1.y + tempA3.z * tempB2.y + tempA3.w * tempB3.y;
   sum3.z += tempA3.x * tempB0.z + tempA3.y * tempB1.z + tempA3.z * tempB2.z + tempA3.w * tempB3.z;
   sum3.w += tempA3.x * tempB0.w + tempA3.y * tempB1.w + tempA3.z * tempB2.w + tempA3.w * tempB3.w;

  }
  barrier(CLK_LOCAL_MEM_FENCE);
 }

 matrixC[globalPos] = sum0;
 matrixC[globalPos + get_global_size(0)] = sum1;
 matrixC[globalPos + 2 * get_global_size(0)] = sum2;
 matrixC[globalPos + 3 * get_global_size(0)] = sum3;

}

template __attribute__((mangled_name(mmmKernel_localFloat4)))
kernel void mmmKernel_local(__global float4 *matrixA,
       __global float4 *matrixB,
       __global float4* matrixC,
       int widthA,
       __local float4 *blockA);
template __attribute__((mangled_name(mmmKernel_localInt4)))
kernel void mmmKernel_local(__global int4 *matrixA,
       __global int4 *matrixB,
       __global int4* matrixC,
       int widthA,
       __local int4 *blockA);
