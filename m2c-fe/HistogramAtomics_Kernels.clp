# 1 "HistogramAtomics_Kernels.cl"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "HistogramAtomics_Kernels.cl"
# 21 "HistogramAtomics_Kernels.cl"
#pragma OPENCL EXTENSION cl_khr_local_int32_base_atomics : enable







__kernel
void histogramKernel_Vector(__global uint4 *Image,
                            __global uint *Histogram,
                            uint n4VectorsPerThread)
{
    __local uint subhists[16 * 256];

    uint tid = get_global_id(0);
    uint ltid = get_local_id(0);
    uint Stride = get_global_size(0);
    uint groupSize = get_local_size(0);

    uint i;
    uint4 temp, temp2;

    const uint shft = (uint) 8;
    const uint msk = (uint) (256 -1);
    uint offset = (uint) ltid % (uint) (16);
    uint lmem_items = (16 * 256);


    __local uint4 *p = (__local uint4 *) subhists;
    for(i=ltid; i<(lmem_items/4); i+=groupSize)
    {
        p[i] = 0;
    }

    barrier( CLK_LOCAL_MEM_FENCE );


    for( i=0; i<n4VectorsPerThread; i++)
    {
        temp = Image[tid + i * Stride];
        temp2 = (temp & msk) * (uint4) 16 + offset;

        atom_inc( subhists + temp2.x );
        atom_inc( subhists + temp2.y );
        atom_inc( subhists + temp2.z );
        atom_inc( subhists + temp2.w );

        temp = temp >> shft;
        temp2 = (temp & msk) * (uint4) 16 + offset;

        atom_inc( subhists + temp2.x );
        atom_inc( subhists + temp2.y );
        atom_inc( subhists + temp2.z );
        atom_inc( subhists + temp2.w );

        temp = temp >> shft;
        temp2 = (temp & msk) * (uint4) 16 + offset;

        atom_inc( subhists + temp2.x );
        atom_inc( subhists + temp2.y );
        atom_inc( subhists + temp2.z );
        atom_inc( subhists + temp2.w );

        temp = temp >> shft;
        temp2 = (temp & msk) * (uint4) 16 + offset;

        atom_inc( subhists + temp2.x );
        atom_inc( subhists + temp2.y );
        atom_inc( subhists + temp2.z );
        atom_inc( subhists + temp2.w );
    }

    barrier( CLK_LOCAL_MEM_FENCE );


    for( i=ltid; i<256; i+=groupSize)
    {
  uint bin = 0, off = offset;

     for(int j=0; j<16; j++, off++)
  {
   bin += subhists[i * 16 + (off % 16)];
  }

  Histogram[ (get_group_id(0) * 256) + i] = bin;
 }
}

__kernel
void histogramKernel_Scalar(__global uint *Image,
                            __global uint *Histogram,
                            uint nVectorsPerThread)
{
    __local uint subhists[4 * 256];

    uint tid = get_global_id(0);
    uint ltid = get_local_id(0);
    uint Stride = get_global_size(0);
    uint groupSize = get_local_size(0);

    uint i, j, idx;
    uint temp, temp2;

    const uint shft = (uint) 8;
    const uint msk = (uint) (256 -1);
    uint offset = (uint) ltid % (uint) (4);
    uint lmem_items = 4 * 256;


    __local uint *p = (__local uint *) subhists;
    for(i=ltid; i<lmem_items; i+=groupSize)
    {
        p[i] = 0;
    }

    barrier( CLK_LOCAL_MEM_FENCE );


    for( i=0; i<nVectorsPerThread; i++)
    {
        temp = Image[tid + i * Stride];
        temp2 = (temp & msk) * (uint) 4 + offset;
        atom_inc( subhists + temp2 );

        temp = temp >> shft;
        temp2 = (temp & msk) * (uint) 4 + offset;
        atom_inc( subhists + temp2 );

        temp = temp >> shft;
        temp2 = (temp & msk) * (uint) 4 + offset;
        atom_inc( subhists + temp2 );

        temp = temp >> shft;
        temp2 = (temp & msk) * (uint) 4 + offset;
        atom_inc( subhists + temp2 );
    }

    barrier( CLK_LOCAL_MEM_FENCE );


    for( i= ltid; i<256; i+=groupSize)
    {
        uint bin = 0, off = offset;

  for(int j=0; j<4; j++, off++)
  {
   bin += subhists[i * 4 + (off % 4)];
  }
  Histogram[ (get_group_id(0) * 256) + i] = bin;
    }
}

__kernel void reduceKernel( __global uint *Histogram, uint nSubHists )
{
     uint tid = get_global_id(0);
    uint bin = 0;





    for( int i=0; i < nSubHists; i = i + 4)
        bin += Histogram[ i * 256 + tid ] + Histogram[ i * 256 + tid + 256 ] +
        Histogram[ i * 256 + tid + 2 * 256 ] + Histogram[ i * 256 + tid + 3 * 256];

    Histogram[ tid ] = bin;
}
