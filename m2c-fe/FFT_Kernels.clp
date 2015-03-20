# 1 "FFT_Kernels.cl"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "FFT_Kernels.cl"
# 87 "FFT_Kernels.cl"
class FFT
{
private:
 __global float *gr;
 __global float *gi;
 __local float *lds;
 uint gid;
    uint me;
    uint dg;
public:
 FFT(){}
 ~FFT(){}
 void Init(__global float *real,__global float *imag,__local float *Localds);
 void passAll();

  float k_sincos(int i, float *cretp);
  float4 k_sincos4(int4 i, float4 *cretp);

  void kfft_pass1();

  void kfft_pass2();

  void kfft_pass3();

  void kfft_pass4();

  void kfft_pass5();
};
void FFT::Init(__global float *real,__global float *imag,__local float *Localds)
{
 gr = real;
 gi = imag;
 lds = Localds;
 gid = get_global_id(0);
    me = gid & 0x3fU;
    dg = (gid >> 6) * (1024+0);
    gr += dg;
    gi += dg;
}

void FFT::passAll()
{
 kfft_pass1();
 kfft_pass2();
 kfft_pass3();
 kfft_pass4();
 kfft_pass5();
}


  float FFT::k_sincos(int i, float *cretp)
 {
  if (i > 512)
  i -= 1024;

  float x = i * -0x1.921fb6p-8F;
  *cretp = native_cos(x);
  return native_sin(x);
 }
  float4 FFT::k_sincos4(int4 i, float4 *cretp)
 {
  i -= (i > 512) & 1024;
  float4 x = convert_float4(i) * -0x1.921fb6p-8F;
  *cretp = native_cos(x);
  return native_sin(x);
 }
  void FFT::kfft_pass1()
 {
  const __global float4 *gp;
    __local float *lp;


    gp = (const __global float4 *)(gr + (me << 2));
    float4 zr0 = gp[0*64];
    float4 zr1 = gp[1*64];
    float4 zr2 = gp[2*64];
    float4 zr3 = gp[3*64];

    gp = (const __global float4 *)(gi + (me << 2));
    float4 zi0 = gp[0*64];
    float4 zi1 = gp[1*64];
    float4 zi2 = gp[2*64];
    float4 zi3 = gp[3*64];

    do { float4 ar0 = zr0 + zr2; float4 ar2 = zr1 + zr3; float4 br0 = ar0 + ar2; float4 br1 = zr0 - zr2; float4 br2 = ar0 - ar2; float4 br3 = zr1 - zr3; float4 ai0 = zi0 + zi2; float4 ai2 = zi1 + zi3; float4 bi0 = ai0 + ai2; float4 bi1 = zi0 - zi2; float4 bi2 = ai0 - ai2; float4 bi3 = zi1 - zi3; zr0 = br0; zi0 = bi0; zr1 = br1 + bi3; zi1 = bi1 - br3; zr3 = br1 - bi3; zi3 = br3 + bi1; zr2 = br2; zi2 = bi2; } while (0);

    int4 tbase = (int)(me << 2) + (int4)(0, 1, 2, 3);
    do { float4 c1; float4 s1 = k_sincos4(tbase * 1, &c1); do { float4 __r = c1 * zr1 - s1 * zi1; zi1 = c1 * zi1 + s1 * zr1; zr1 = __r; } while (0); float4 c2; float4 s2 = k_sincos4(tbase * 2, &c2); do { float4 __r = c2 * zr2 - s2 * zi2; zi2 = c2 * zi2 + s2 * zr2; zr2 = __r; } while (0); float4 c3; float4 s3 = k_sincos4(tbase * 3, &c3); do { float4 __r = c3 * zr3 - s3 * zi3; zi3 = c3 * zi3 + s3 * zr3; zr3 = __r; } while (0); } while (0);



    lp = lds + ((me << 2) + (me >> 3));

    lp[0] = zr0.x;
    lp[1] = zr0.y;
    lp[2] = zr0.z;
    lp[3] = zr0.w;
    lp += 66*4;

    lp[0] = zr1.x;
    lp[1] = zr1.y;
    lp[2] = zr1.z;
    lp[3] = zr1.w;
    lp += 66*4;

    lp[0] = zr2.x;
    lp[1] = zr2.y;
    lp[2] = zr2.z;
    lp[3] = zr2.w;
    lp += 66*4;

    lp[0] = zr3.x;
    lp[1] = zr3.y;
    lp[2] = zr3.z;
    lp[3] = zr3.w;
    lp += 66*4;


    lp[0] = zi0.x;
    lp[1] = zi0.y;
    lp[2] = zi0.z;
    lp[3] = zi0.w;
    lp += 66*4;

    lp[0] = zi1.x;
    lp[1] = zi1.y;
    lp[2] = zi1.z;
    lp[3] = zi1.w;
    lp += 66*4;

    lp[0] = zi2.x;
    lp[1] = zi2.y;
    lp[2] = zi2.z;
    lp[3] = zi2.w;
    lp += 66*4;

    lp[0] = zi3.x;
    lp[1] = zi3.y;
    lp[2] = zi3.z;
    lp[3] = zi3.w;

    barrier(CLK_LOCAL_MEM_FENCE);
 }



  void FFT::kfft_pass2()
 {
  __local float *lp;


    lp = lds + (me + (me >> 5));

    float4 zr0, zr1, zr2, zr3;

    zr0.x = lp[0*66];
    zr1.x = lp[1*66];
    zr2.x = lp[2*66];
    zr3.x = lp[3*66];
    lp += 66*4;

    zr0.y = lp[0*66];
    zr1.y = lp[1*66];
    zr2.y = lp[2*66];
    zr3.y = lp[3*66];
    lp += 66*4;

    zr0.z = lp[0*66];
    zr1.z = lp[1*66];
    zr2.z = lp[2*66];
    zr3.z = lp[3*66];
    lp += 66*4;

    zr0.w = lp[0*66];
    zr1.w = lp[1*66];
    zr2.w = lp[2*66];
    zr3.w = lp[3*66];
    lp += 66*4;

    float4 zi0, zi1, zi2, zi3;

    zi0.x = lp[0*66];
    zi1.x = lp[1*66];
    zi2.x = lp[2*66];
    zi3.x = lp[3*66];
    lp += 66*4;

    zi0.y = lp[0*66];
    zi1.y = lp[1*66];
    zi2.y = lp[2*66];
    zi3.y = lp[3*66];
    lp += 66*4;

    zi0.z = lp[0*66];
    zi1.z = lp[1*66];
    zi2.z = lp[2*66];
    zi3.z = lp[3*66];
    lp += 66*4;

    zi0.w = lp[0*66];
    zi1.w = lp[1*66];
    zi2.w = lp[2*66];
    zi3.w = lp[3*66];


    do { float4 ar0 = zr0 + zr2; float4 ar2 = zr1 + zr3; float4 br0 = ar0 + ar2; float4 br1 = zr0 - zr2; float4 br2 = ar0 - ar2; float4 br3 = zr1 - zr3; float4 ai0 = zi0 + zi2; float4 ai2 = zi1 + zi3; float4 bi0 = ai0 + ai2; float4 bi1 = zi0 - zi2; float4 bi2 = ai0 - ai2; float4 bi3 = zi1 - zi3; zr0 = br0; zi0 = bi0; zr1 = br1 + bi3; zi1 = bi1 - br3; zr3 = br1 - bi3; zi3 = br3 + bi1; zr2 = br2; zi2 = bi2; } while (0);

    int tbase = (int)(me << 2);
    do { float c1; float s1 = k_sincos(tbase * 1, &c1); do { float4 __r = c1 * zr1 - s1 * zi1; zi1 = c1 * zi1 + s1 * zr1; zr1 = __r; } while (0); float c2; float s2 = k_sincos(tbase * 2, &c2); do { float4 __r = c2 * zr2 - s2 * zi2; zi2 = c2 * zi2 + s2 * zr2; zr2 = __r; } while (0); float c3; float s3 = k_sincos(tbase * 3, &c3); do { float4 __r = c3 * zr3 - s3 * zi3; zi3 = c3 * zi3 + s3 * zr3; zr3 = __r; } while (0); } while (0);

    barrier(CLK_LOCAL_MEM_FENCE);


    lp = lds + ((me << 2) + (me >> 3));

    lp[0] = zr0.x;
    lp[1] = zr1.x;
    lp[2] = zr2.x;
    lp[3] = zr3.x;
    lp += 66*4;

    lp[0] = zr0.y;
    lp[1] = zr1.y;
    lp[2] = zr2.y;
    lp[3] = zr3.y;
    lp += 66*4;

    lp[0] = zr0.z;
    lp[1] = zr1.z;
    lp[2] = zr2.z;
    lp[3] = zr3.z;
    lp += 66*4;

    lp[0] = zr0.w;
    lp[1] = zr1.w;
    lp[2] = zr2.w;
    lp[3] = zr3.w;
    lp += 66*4;


    lp[0] = zi0.x;
    lp[1] = zi1.x;
    lp[2] = zi2.x;
    lp[3] = zi3.x;
    lp += 66*4;

    lp[0] = zi0.y;
    lp[1] = zi1.y;
    lp[2] = zi2.y;
    lp[3] = zi3.y;
    lp += 66*4;

    lp[0] = zi0.z;
    lp[1] = zi1.z;
    lp[2] = zi2.z;
    lp[3] = zi3.z;
    lp += 66*4;

    lp[0] = zi0.w;
    lp[1] = zi1.w;
    lp[2] = zi2.w;
    lp[3] = zi3.w;

    barrier(CLK_LOCAL_MEM_FENCE);
 }



  void FFT::kfft_pass3()
 {
  __local float *lp;


    lp = lds + (me + (me >> 5));

    float4 zr0, zr1, zr2, zr3;

    zr0.x = lp[0*66];
    zr1.x = lp[1*66];
    zr2.x = lp[2*66];
    zr3.x = lp[3*66];
    lp += 66*4;

    zr0.y = lp[0*66];
    zr1.y = lp[1*66];
    zr2.y = lp[2*66];
    zr3.y = lp[3*66];
    lp += 66*4;

    zr0.z = lp[0*66];
    zr1.z = lp[1*66];
    zr2.z = lp[2*66];
    zr3.z = lp[3*66];
    lp += 66*4;

    zr0.w = lp[0*66];
    zr1.w = lp[1*66];
    zr2.w = lp[2*66];
    zr3.w = lp[3*66];
    lp += 66*4;

    float4 zi0, zi1, zi2, zi3;

    zi0.x = lp[0*66];
    zi1.x = lp[1*66];
    zi2.x = lp[2*66];
    zi3.x = lp[3*66];
    lp += 66*4;

    zi0.y = lp[0*66];
    zi1.y = lp[1*66];
    zi2.y = lp[2*66];
    zi3.y = lp[3*66];
    lp += 66*4;

    zi0.z = lp[0*66];
    zi1.z = lp[1*66];
    zi2.z = lp[2*66];
    zi3.z = lp[3*66];
    lp += 66*4;

    zi0.w = lp[0*66];
    zi1.w = lp[1*66];
    zi2.w = lp[2*66];
    zi3.w = lp[3*66];


    do { float4 ar0 = zr0 + zr2; float4 ar2 = zr1 + zr3; float4 br0 = ar0 + ar2; float4 br1 = zr0 - zr2; float4 br2 = ar0 - ar2; float4 br3 = zr1 - zr3; float4 ai0 = zi0 + zi2; float4 ai2 = zi1 + zi3; float4 bi0 = ai0 + ai2; float4 bi1 = zi0 - zi2; float4 bi2 = ai0 - ai2; float4 bi3 = zi1 - zi3; zr0 = br0; zi0 = bi0; zr1 = br1 + bi3; zi1 = bi1 - br3; zr3 = br1 - bi3; zi3 = br3 + bi1; zr2 = br2; zi2 = bi2; } while (0);

    int tbase = (int)((me >> 2) << 4);
    do { float c1; float s1 = k_sincos(tbase * 1, &c1); do { float4 __r = c1 * zr1 - s1 * zi1; zi1 = c1 * zi1 + s1 * zr1; zr1 = __r; } while (0); float c2; float s2 = k_sincos(tbase * 2, &c2); do { float4 __r = c2 * zr2 - s2 * zi2; zi2 = c2 * zi2 + s2 * zr2; zr2 = __r; } while (0); float c3; float s3 = k_sincos(tbase * 3, &c3); do { float4 __r = c3 * zr3 - s3 * zi3; zi3 = c3 * zi3 + s3 * zr3; zr3 = __r; } while (0); } while (0);

    barrier(CLK_LOCAL_MEM_FENCE);


    lp = lds + me;

    lp[0*66] = zr0.x;
    lp[1*66] = zr0.y;
    lp[2*66] = zr0.z;
    lp[3*66] = zr0.w;
    lp += 66*4;

    lp[0*66] = zr1.x;
    lp[1*66] = zr1.y;
    lp[2*66] = zr1.z;
    lp[3*66] = zr1.w;
    lp += 66*4;

    lp[0*66] = zr2.x;
    lp[1*66] = zr2.y;
    lp[2*66] = zr2.z;
    lp[3*66] = zr2.w;
    lp += 66*4;

    lp[0*66] = zr3.x;
    lp[1*66] = zr3.y;
    lp[2*66] = zr3.z;
    lp[3*66] = zr3.w;
    lp += 66*4;


    lp[0*66] = zi0.x;
    lp[1*66] = zi0.y;
    lp[2*66] = zi0.z;
    lp[3*66] = zi0.w;
    lp += 66*4;

    lp[0*66] = zi1.x;
    lp[1*66] = zi1.y;
    lp[2*66] = zi1.z;
    lp[3*66] = zi1.w;
    lp += 66*4;

    lp[0*66] = zi2.x;
    lp[1*66] = zi2.y;
    lp[2*66] = zi2.z;
    lp[3*66] = zi2.w;
    lp += 66*4;

    lp[0*66] = zi3.x;
    lp[1*66] = zi3.y;
    lp[2*66] = zi3.z;
    lp[3*66] = zi3.w;

    barrier(CLK_LOCAL_MEM_FENCE);
 }

  void FFT::kfft_pass4()
 {
      __local float *lp;


    lp = lds + ((me & 0x3) + ((me >> 2) & 0x3)*(66*4) + ((me >> 4) << 2));

    float4 zr0, zr1, zr2, zr3;

    zr0.x = lp[0*66];
    zr0.y = lp[1*66];
    zr0.z = lp[2*66];
    zr0.w = lp[3*66];
    lp += 16;

    zr1.x = lp[0*66];
    zr1.y = lp[1*66];
    zr1.z = lp[2*66];
    zr1.w = lp[3*66];
    lp += 16;

    zr2.x = lp[0*66];
    zr2.y = lp[1*66];
    zr2.z = lp[2*66];
    zr2.w = lp[3*66];
    lp += 16;

    zr3.x = lp[0*66];
    zr3.y = lp[1*66];
    zr3.z = lp[2*66];
    zr3.w = lp[3*66];
    lp += 66*4*4 - 3*16;

    float4 zi0, zi1, zi2, zi3;

    zi0.x = lp[0*66];
    zi0.y = lp[1*66];
    zi0.z = lp[2*66];
    zi0.w = lp[3*66];
    lp += 16;

    zi1.x = lp[0*66];
    zi1.y = lp[1*66];
    zi1.z = lp[2*66];
    zi1.w = lp[3*66];
    lp += 16;

    zi2.x = lp[0*66];
    zi2.y = lp[1*66];
    zi2.z = lp[2*66];
    zi2.w = lp[3*66];
    lp += 16;

    zi3.x = lp[0*66];
    zi3.y = lp[1*66];
    zi3.z = lp[2*66];
    zi3.w = lp[3*66];


    do { float4 ar0 = zr0 + zr2; float4 ar2 = zr1 + zr3; float4 br0 = ar0 + ar2; float4 br1 = zr0 - zr2; float4 br2 = ar0 - ar2; float4 br3 = zr1 - zr3; float4 ai0 = zi0 + zi2; float4 ai2 = zi1 + zi3; float4 bi0 = ai0 + ai2; float4 bi1 = zi0 - zi2; float4 bi2 = ai0 - ai2; float4 bi3 = zi1 - zi3; zr0 = br0; zi0 = bi0; zr1 = br1 + bi3; zi1 = bi1 - br3; zr3 = br1 - bi3; zi3 = br3 + bi1; zr2 = br2; zi2 = bi2; } while (0);

    int tbase = (int)((me >> 4) << 6);
    do { float c1; float s1 = k_sincos(tbase * 1, &c1); do { float4 __r = c1 * zr1 - s1 * zi1; zi1 = c1 * zi1 + s1 * zr1; zr1 = __r; } while (0); float c2; float s2 = k_sincos(tbase * 2, &c2); do { float4 __r = c2 * zr2 - s2 * zi2; zi2 = c2 * zi2 + s2 * zr2; zr2 = __r; } while (0); float c3; float s3 = k_sincos(tbase * 3, &c3); do { float4 __r = c3 * zr3 - s3 * zi3; zi3 = c3 * zi3 + s3 * zr3; zr3 = __r; } while (0); } while (0);

    barrier(CLK_LOCAL_MEM_FENCE);


    lp = lds + me;

    lp[0*68] = zr0.x;
    lp[1*68] = zr0.y;
    lp[2*68] = zr0.z;
    lp[3*68] = zr0.w;
    lp += 68*4;

    lp[0*68] = zr1.x;
    lp[1*68] = zr1.y;
    lp[2*68] = zr1.z;
    lp[3*68] = zr1.w;
    lp += 68*4;

    lp[0*68] = zr2.x;
    lp[1*68] = zr2.y;
    lp[2*68] = zr2.z;
    lp[3*68] = zr2.w;
    lp += 68*4;

    lp[0*68] = zr3.x;
    lp[1*68] = zr3.y;
    lp[2*68] = zr3.z;
    lp[3*68] = zr3.w;
    lp += 68*4;


    lp[0*68] = zi0.x;
    lp[1*68] = zi0.y;
    lp[2*68] = zi0.z;
    lp[3*68] = zi0.w;
    lp += 68*4;

    lp[0*68] = zi1.x;
    lp[1*68] = zi1.y;
    lp[2*68] = zi1.z;
    lp[3*68] = zi1.w;
    lp += 68*4;

    lp[0*68] = zi2.x;
    lp[1*68] = zi2.y;
    lp[2*68] = zi2.z;
    lp[3*68] = zi2.w;
    lp += 68*4;

    lp[0*68] = zi3.x;
    lp[1*68] = zi3.y;
    lp[2*68] = zi3.z;
    lp[3*68] = zi3.w;

    barrier(CLK_LOCAL_MEM_FENCE);
 }

  void FFT::kfft_pass5()
 {
  const __local float *lp;


    lp = lds + ((me & 0xf) + (me >> 4)*(68*4));

    float4 zr0, zr1, zr2, zr3;

    zr0.x = lp[0*68];
    zr0.y = lp[1*68];
    zr0.z = lp[2*68];
    zr0.w = lp[3*68];
    lp += 16;

    zr1.x = lp[0*68];
    zr1.y = lp[1*68];
    zr1.z = lp[2*68];
    zr1.w = lp[3*68];
    lp += 16;

    zr2.x = lp[0*68];
    zr2.y = lp[1*68];
    zr2.z = lp[2*68];
    zr2.w = lp[3*68];
    lp += 16;

    zr3.x = lp[0*68];
    zr3.y = lp[1*68];
    zr3.z = lp[2*68];
    zr3.w = lp[3*68];

    lp += 68*4*4 - 3*16;

    float4 zi0, zi1, zi2, zi3;

    zi0.x = lp[0*68];
    zi0.y = lp[1*68];
    zi0.z = lp[2*68];
    zi0.w = lp[3*68];
    lp += 16;

    zi1.x = lp[0*68];
    zi1.y = lp[1*68];
    zi1.z = lp[2*68];
    zi1.w = lp[3*68];
    lp += 16;

    zi2.x = lp[0*68];
    zi2.y = lp[1*68];
    zi2.z = lp[2*68];
    zi2.w = lp[3*68];
    lp += 16;

    zi3.x = lp[0*68];
    zi3.y = lp[1*68];
    zi3.z = lp[2*68];
    zi3.w = lp[3*68];


    do { float4 ar0 = zr0 + zr2; float4 ar2 = zr1 + zr3; float4 br0 = ar0 + ar2; float4 br1 = zr0 - zr2; float4 br2 = ar0 - ar2; float4 br3 = zr1 - zr3; float4 ai0 = zi0 + zi2; float4 ai2 = zi1 + zi3; float4 bi0 = ai0 + ai2; float4 bi1 = zi0 - zi2; float4 bi2 = ai0 - ai2; float4 bi3 = zi1 - zi3; zr0 = br0; zi0 = bi0; zr1 = br1 + bi3; zi1 = bi1 - br3; zr3 = br1 - bi3; zi3 = br3 + bi1; zr2 = br2; zi2 = bi2; } while (0);


    __global float4 *gp = (__global float4 *)(gr + (me << 2));
    gp[0*64] = zr0;
    gp[1*64] = zr1;
    gp[2*64] = zr2;
    gp[3*64] = zr3;

    gp = (__global float4 *)(gi + (me << 2));
    gp[0*64] = zi0;
    gp[1*64] = zi1;
    gp[2*64] = zi2;
    gp[3*64] = zi3;
 }


__kernel void kfft(__global float *greal, __global float *gimag)
{

    __local float lds[68*4*4*2];

 FFT fftObj;
 fftObj.Init(greal,gimag,lds);
 fftObj.passAll();
}
