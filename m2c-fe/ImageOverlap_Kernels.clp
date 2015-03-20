# 1 "ImageOverlap_Kernels.cl"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "ImageOverlap_Kernels.cl"
# 17 "ImageOverlap_Kernels.cl"
__kernel void OverLap(
    __read_only image2d_t pconfig_src,
    __read_only image2d_t pconfig_src2,
  __write_only image2d_t pconfig_dst)
{
  const int ix = get_global_id(0);
  const int iy = get_global_id(1);
  int2 locate;
  locate.x = ix;
  locate.y = iy;
  uint4 color_src;
  uint4 color_dst;
  const sampler_t sampler = 0;
  color_src = read_imageui(pconfig_src, sampler,locate);
  color_dst = read_imageui(pconfig_src2, sampler,locate);
  write_imageui(pconfig_dst, locate, color_src + color_dst);

 return;
}
