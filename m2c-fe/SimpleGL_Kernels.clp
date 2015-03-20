# 1 "SimpleGL_Kernels.cl"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "SimpleGL_Kernels.cl"
# 22 "SimpleGL_Kernels.cl"
__kernel
void sineWave(
    __global float4 * pos,
    unsigned int width,
    unsigned int height,
    float time)
{
    unsigned int x = get_global_id(0);
    unsigned int y = get_global_id(1);


    float u = x / (float) width;
    float v = y / (float) height;
    u = u*2.0f - 1.0f;
    v = v*2.0f - 1.0f;


    float freq = 4.0f;
    float w = sin(u*freq + time) * cos(v*freq + time) * 0.5f;


    pos[y*width+x] = (float4)(u, w, v, 1.0f);
}
