# 1 "ConcurrentKernel_Kernels.cl"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "ConcurrentKernel_Kernels.cl"
# 26 "ConcurrentKernel_Kernels.cl"
void work1(__global unsigned char* input,
           __global unsigned char* output,
           unsigned int bufferSize,
           int multiplier)
{
    int gSize = get_global_size(0);
    int gId = get_global_id(0);
    int lId = get_local_id(0);


    unsigned int tmp = 1;
    volatile int zero = 0;
    for(int i=1;i<5000;i++)
    {
        tmp += input[((i*1) % bufferSize)]
            + input[((i*2) % bufferSize)]
            + input[((i*3) % bufferSize)]
            + input[((i*4) % bufferSize)]
            + input[((i*5) % bufferSize)];
    }


    for(unsigned int i = gId; i < bufferSize; i += gSize)
    {
        output[i] = ((input[i] * multiplier) % 256) + (zero * tmp);
    }
}



void work2(__global unsigned char* input,
     __global unsigned char* output,
     unsigned int bufferSize,
     int multiplier,
     __local unsigned char *lds)
{
 int gSize = get_global_size(0);
    int gId = get_global_id(0);
    int lId = get_local_id(0);


 int tmp = 1;
 volatile int zero = 0;
 for(int i=1;i<10000;i++)
 {
  tmp += input[((i*2) % bufferSize)]
   - input[((i*4) % bufferSize)]
   + input[((i*6) % bufferSize)]
   - input[((i*8) % bufferSize)]
   + input[((i*10) % bufferSize)];
 }


 for(unsigned int i = gId; i < bufferSize; i += gSize)
 {
  lds[lId] = input[i];
  output[i] = ((lds[lId] * multiplier) % 256) + (zero * tmp);
 }
}

__kernel void K1(__global unsigned char* input,
                 __global unsigned char* output,
                 unsigned int bufferSize,
                 int multiplier)
{
 work1(input, output, bufferSize, multiplier);
}

__kernel void K2(__global unsigned char* input,
                 __global unsigned char* output,
                 unsigned int bufferSize,
                 int multiplier)
{
 __local unsigned char lds[(8 * 1024)];
    work2(input, output, bufferSize, multiplier, lds);
}

__kernel void K3(__global unsigned char* input,
                 __global unsigned char* output,
                 unsigned int bufferSize,
                 int multiplier)
{
    work1(input, output, bufferSize, multiplier);
}

__kernel void K4(__global unsigned char* input,
                 __global unsigned char* output,
                 unsigned int bufferSize,
                 int multiplier)
{
    __local unsigned char lds[(8 * 1024)];
    work2(input, output, bufferSize, multiplier, lds);
}

__kernel void K5(__global unsigned char* input,
                 __global unsigned char* output,
                 unsigned int bufferSize,
                 int multiplier)
{
    work1(input, output, bufferSize, multiplier);
}

__kernel void K6(__global unsigned char* input,
                 __global unsigned char* output,
                 unsigned int bufferSize,
                 int multiplier)
{
    __local unsigned char lds[(8 * 1024)];
    work2(input, output, bufferSize, multiplier, lds);
}

__kernel void K7(__global unsigned char* input,
                 __global unsigned char* output,
                 unsigned int bufferSize,
                 int multiplier)
{
    work1(input, output, bufferSize, multiplier);
}

__kernel void K8(__global unsigned char* input,
                 __global unsigned char* output,
                 unsigned int bufferSize,
                 int multiplier)
{
    __local unsigned char lds[(8 * 1024)];
    work2(input, output, bufferSize, multiplier, lds);
}

__kernel void K9(__global unsigned char* input,
                 __global unsigned char* output,
                 unsigned int bufferSize,
                 int multiplier)
{
    work1(input, output, bufferSize, multiplier);
}

__kernel void K10(__global unsigned char* input,
                  __global unsigned char* output,
                  unsigned int bufferSize,
                  int multiplier)
{
    __local unsigned char lds[(8 * 1024)];
    work2(input, output, bufferSize, multiplier, lds);
}
