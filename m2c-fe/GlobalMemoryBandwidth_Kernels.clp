# 1 "GlobalMemoryBandwidth_Kernels.cl"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "GlobalMemoryBandwidth_Kernels.cl"
# 19 "GlobalMemoryBandwidth_Kernels.cl"
__kernel void read_linear(__global DATATYPE *input,__global DATATYPE *output)
{
 DATATYPE val = (DATATYPE)(0.0f);
 uint gid = get_global_id(0);

 val = val + input[gid + 0];
 val = val + input[gid + 1];
 val = val + input[gid + 2];
 val = val + input[gid + 3];
 val = val + input[gid + 4];
 val = val + input[gid + 5];
 val = val + input[gid + 6];
 val = val + input[gid + 7];
 val = val + input[gid + 8];
 val = val + input[gid + 9];
 val = val + input[gid + 10];
 val = val + input[gid + 11];
 val = val + input[gid + 12];
 val = val + input[gid + 13];
 val = val + input[gid + 14];
 val = val + input[gid + 15];
 val = val + input[gid + 16];
 val = val + input[gid + 17];
 val = val + input[gid + 18];
 val = val + input[gid + 19];
 val = val + input[gid + 20];
 val = val + input[gid + 21];
 val = val + input[gid + 22];
 val = val + input[gid + 23];
 val = val + input[gid + 24];
 val = val + input[gid + 25];
 val = val + input[gid + 26];
 val = val + input[gid + 27];
 val = val + input[gid + 28];
 val = val + input[gid + 29];
 val = val + input[gid + 30];
 val = val + input[gid + 31];

 output[gid] = val;
}

__kernel void read_linear_uncached(__global DATATYPE *input,__global DATATYPE *output)
{
 DATATYPE val = (DATATYPE)(0.0f);
 uint gid = get_global_id(0);
 uint index = gid;

 val = val + input[index += OFFSET];
 val = val + input[index += OFFSET];
 val = val + input[index += OFFSET];
 val = val + input[index += OFFSET];
 val = val + input[index += OFFSET];
 val = val + input[index += OFFSET];
 val = val + input[index += OFFSET];
 val = val + input[index += OFFSET];
 val = val + input[index += OFFSET];
 val = val + input[index += OFFSET];
 val = val + input[index += OFFSET];
 val = val + input[index += OFFSET];
 val = val + input[index += OFFSET];
 val = val + input[index += OFFSET];
 val = val + input[index += OFFSET];
 val = val + input[index += OFFSET];
 val = val + input[index += OFFSET];
 val = val + input[index += OFFSET];
 val = val + input[index += OFFSET];
 val = val + input[index += OFFSET];
 val = val + input[index += OFFSET];
 val = val + input[index += OFFSET];
 val = val + input[index += OFFSET];
 val = val + input[index += OFFSET];
 val = val + input[index += OFFSET];
 val = val + input[index += OFFSET];
 val = val + input[index += OFFSET];
 val = val + input[index += OFFSET];
 val = val + input[index += OFFSET];
 val = val + input[index += OFFSET];
 val = val + input[index += OFFSET];
 val = val + input[index += OFFSET];

 output[gid] = val;
}

__kernel void read_single(__global DATATYPE *input,__global DATATYPE *output)
{
 DATATYPE val = (DATATYPE)(0.0f);
 uint gid = get_global_id(0);

 val = val + input[0];
 val = val + input[1];
 val = val + input[2];
 val = val + input[3];
 val = val + input[4];
 val = val + input[5];
 val = val + input[6];
 val = val + input[7];
 val = val + input[8];
 val = val + input[9];
 val = val + input[10];
 val = val + input[11];
 val = val + input[12];
 val = val + input[13];
 val = val + input[14];
 val = val + input[15];
 val = val + input[16];
 val = val + input[17];
 val = val + input[18];
 val = val + input[19];
 val = val + input[20];
 val = val + input[21];
 val = val + input[22];
 val = val + input[23];
 val = val + input[24];
 val = val + input[25];
 val = val + input[26];
 val = val + input[27];
 val = val + input[28];
 val = val + input[29];
 val = val + input[30];
 val = val + input[31];

 output[gid] = val;
}

__kernel void write_linear(__constant DATATYPE *c0, __global DATATYPE *output)
{
 uint gid = get_global_id(0);

 output[gid + 0 * (512 / sizeof(DATATYPE))] = *c0;
 output[gid + 1 * (512 / sizeof(DATATYPE))] = *c0;
 output[gid + 2 * (512 / sizeof(DATATYPE))] = *c0;
 output[gid + 3 * (512 / sizeof(DATATYPE))] = *c0;
 output[gid + 4 * (512 / sizeof(DATATYPE))] = *c0;
 output[gid + 5 * (512 / sizeof(DATATYPE))] = *c0;
 output[gid + 6 * (512 / sizeof(DATATYPE))] = *c0;
 output[gid + 7 * (512 / sizeof(DATATYPE))] = *c0;
 output[gid + 8 * (512 / sizeof(DATATYPE))] = *c0;
 output[gid + 9 * (512 / sizeof(DATATYPE))] = *c0;
 output[gid + 10 * (512 / sizeof(DATATYPE))] = *c0;
 output[gid + 11 * (512 / sizeof(DATATYPE))] = *c0;
 output[gid + 12 * (512 / sizeof(DATATYPE))] = *c0;
 output[gid + 13 * (512 / sizeof(DATATYPE))] = *c0;
 output[gid + 14 * (512 / sizeof(DATATYPE))] = *c0;
 output[gid + 15 * (512 / sizeof(DATATYPE))] = *c0;
 output[gid + 16 * (512 / sizeof(DATATYPE))] = *c0;
 output[gid + 17 * (512 / sizeof(DATATYPE))] = *c0;
 output[gid + 18 * (512 / sizeof(DATATYPE))] = *c0;
 output[gid + 19 * (512 / sizeof(DATATYPE))] = *c0;
 output[gid + 20 * (512 / sizeof(DATATYPE))] = *c0;
 output[gid + 21 * (512 / sizeof(DATATYPE))] = *c0;
 output[gid + 22 * (512 / sizeof(DATATYPE))] = *c0;
 output[gid + 23 * (512 / sizeof(DATATYPE))] = *c0;
 output[gid + 24 * (512 / sizeof(DATATYPE))] = *c0;
 output[gid + 25 * (512 / sizeof(DATATYPE))] = *c0;
 output[gid + 26 * (512 / sizeof(DATATYPE))] = *c0;
 output[gid + 27 * (512 / sizeof(DATATYPE))] = *c0;
 output[gid + 28 * (512 / sizeof(DATATYPE))] = *c0;
 output[gid + 29 * (512 / sizeof(DATATYPE))] = *c0;
 output[gid + 30 * (512 / sizeof(DATATYPE))] = *c0;
 output[gid + 31 * (512 / sizeof(DATATYPE))] = *c0;
}

__kernel void read_random(__global DATATYPE2 *input, __global DATATYPE2 *output)
{
 uint gid = get_global_id(0);
 uint Index = get_local_id(0);

    DATATYPE2 val = (DATATYPE2)(0.0f);
    DATATYPE2 midval = (DATATYPE2)(0.0f);

    for(uint i = 0; i<32;i++)
    {
  midval = input[Index];
  val += midval;
  Index = (uint)(midval.S0);
    }

 output[gid] = val;
}

__kernel void read_random1(__global float *input, __global float *output)
{
 uint gid = get_global_id(0);
 uint Index = get_local_id(0);

    float val = (float)(0.0f);
    float midval = (float)(0.0f);

    for(uint i = 0; i<32;i++)
    {
  midval = input[Index];
  val += midval;
  Index = (uint)(midval);
    }

 output[gid] = val;
}


__kernel void read_uncoalescing(__global DATATYPE *input,__global DATATYPE *output)
{
    DATATYPE val = (DATATYPE)(0.0f);
    uint gid = get_global_id(0);

    val = val + input[gid * 32 + 0];
    val = val + input[gid * 32 + 1];
    val = val + input[gid * 32 + 2];
    val = val + input[gid * 32 + 3];
    val = val + input[gid * 32 + 4];
    val = val + input[gid * 32 + 5];
    val = val + input[gid * 32 + 6];
    val = val + input[gid * 32 + 7];
    val = val + input[gid * 32 + 8];
    val = val + input[gid * 32 + 9];
    val = val + input[gid * 32 + 10];
    val = val + input[gid * 32 + 11];
    val = val + input[gid * 32 + 12];
    val = val + input[gid * 32 + 13];
    val = val + input[gid * 32 + 14];
    val = val + input[gid * 32 + 15];
    val = val + input[gid * 32 + 16];
    val = val + input[gid * 32 + 17];
    val = val + input[gid * 32 + 18];
    val = val + input[gid * 32 + 19];
    val = val + input[gid * 32 + 20];
    val = val + input[gid * 32 + 21];
    val = val + input[gid * 32 + 22];
    val = val + input[gid * 32 + 23];
    val = val + input[gid * 32 + 24];
    val = val + input[gid * 32 + 25];
    val = val + input[gid * 32 + 26];
    val = val + input[gid * 32 + 27];
    val = val + input[gid * 32 + 28];
    val = val + input[gid * 32 + 29];
    val = val + input[gid * 32 + 30];
    val = val + input[gid * 32 + 31];

    output[gid] = val;
}
