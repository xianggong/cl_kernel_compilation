# 1 "FloydWarshall_Kernels.cl"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "FloydWarshall_Kernels.cl"
# 19 "FloydWarshall_Kernels.cl"
inline
unsigned int uintMin(unsigned int a, unsigned int b)
{
    return (b < a) ? b : a;
}
# 48 "FloydWarshall_Kernels.cl"
__kernel
void floydWarshallPass(__global uint * pathDistanceBuffer,
                       __global uint * pathBuffer ,
                       const unsigned int numNodes ,
                       const unsigned int pass )
{
    int xValue = get_global_id(0);
    int yValue = get_global_id(1);

    int k = pass;
    int oldWeight = pathDistanceBuffer[yValue * numNodes + xValue];
    int tempWeight = (pathDistanceBuffer[yValue * numNodes + k] + pathDistanceBuffer[k * numNodes + xValue]);

    if (tempWeight < oldWeight)
    {
        pathDistanceBuffer[yValue * numNodes + xValue] = tempWeight;
        pathBuffer[yValue * numNodes + xValue] = k;
    }
}
