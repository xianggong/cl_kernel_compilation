# 1 "FluidSimulation2D_Kernels.cl"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "FluidSimulation2D_Kernels.cl"
# 29 "FluidSimulation2D_Kernels.cl"
#pragma OPENCL EXTENSION cl_amd_fp64 : enable



double computefEq(double rho, double weight, double2 dir, double2 u)
{
    double u2 = (u.x * u.x) + (u.y * u.y);
    double eu = (dir.x * u.x) + (dir.y * u.y);
    return rho * weight * (1.0f + (3.0f * eu) + (4.5f * eu * eu) - (1.5f * u2));
}

__kernel void lbm(__global double *if0, __global double *of0,
                  __global double4 *if1234, __global double4 *of1234,
                  __global double4 *if5678, __global double4 *of5678,
                  __global bool *type,
                  double8 dirX, double8 dirY,
                  __constant double weight[9],
                  double omega,
                  __global double2 *velocityBuffer)
{
    uint2 id = (uint2)(get_global_id(0), get_global_id(1));
    uint width = get_global_size(0);
    uint pos = id.x + width * id.y;


    double f0 = if0[pos];
    double4 f1234 = if1234[pos];
    double4 f5678 = if5678[pos];


    double rho;
    double2 u;



    if(type[pos])
    {

        f1234.xyzw = f1234.zwxy;
        f5678.xyzw = f5678.zwxy;

        rho = 0;
        u = (double2)(0, 0);
    }

    else
    {


        double4 temp = f1234 + f5678;
        temp.lo += temp.hi;
        rho = temp.x + temp.y;
        rho += f0;


        u.x = (dot(f1234, dirX.lo) + dot(f5678, dirX.hi)) / rho;
        u.y = (dot(f1234, dirY.lo) + dot(f5678, dirY.hi)) / rho;

        double4 fEq1234;
        double4 fEq5678;
        double fEq0;


        fEq0 = computefEq(rho, weight[0], (double2)(0, 0), u);
        fEq1234.x = computefEq(rho, weight[1], (double2)(dirX.s0, dirY.s0), u);
        fEq1234.y = computefEq(rho, weight[2], (double2)(dirX.s1, dirY.s1), u);
        fEq1234.z = computefEq(rho, weight[3], (double2)(dirX.s2, dirY.s2), u);
        fEq1234.w = computefEq(rho, weight[4], (double2)(dirX.s3, dirY.s3), u);
        fEq5678.x = computefEq(rho, weight[5], (double2)(dirX.s4, dirY.s4), u);
        fEq5678.y = computefEq(rho, weight[6], (double2)(dirX.s5, dirY.s5), u);
        fEq5678.z = computefEq(rho, weight[7], (double2)(dirX.s6, dirY.s6), u);
        fEq5678.w = computefEq(rho, weight[8], (double2)(dirX.s7, dirY.s7), u);

        f0 = (1 - omega) * f0 + omega * fEq0;
        f1234 = (1 - omega) * f1234 + omega * fEq1234;
        f5678 = (1 - omega) * f5678 + omega * fEq5678;
    }

    velocityBuffer[pos] = u;



    int8 nX = id.x + convert_int8(dirX);
    int8 nY = id.y + convert_int8(dirY);
    int8 nPos = nX + width * nY;


    of0[pos] = f0;

    int t1 = id.x < get_global_size(0) - 1;
    int t4 = id.y > 0;
    int t3 = id.x > 0;
    int t2 = id.y < get_global_size(1) - 1;


    if(t1)
        of1234[nPos.s0].x = f1234.x;


    if(t2)
        of1234[nPos.s1].y = f1234.y;


    if(t3)
        of1234[nPos.s2].z = f1234.z;


    if(t4)
        of1234[nPos.s3].w = f1234.w;


    if(t1 && t2)
        of5678[nPos.s4].x = f5678.x;


    if(t2 && t3)
        of5678[nPos.s5].y = f5678.y;


    if(t3 && t4)
        of5678[nPos.s6].z = f5678.z;


    if(t4 && t1)
        of5678[nPos.s7].w = f5678.w;
}
