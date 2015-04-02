# 1 "BasicDebug_Kernel.cl"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "BasicDebug_Kernel.cl"
# 16 "BasicDebug_Kernel.cl"
__kernel void printfKernel(__global float *inputbuffer)
{
 uint globalID = get_global_id(0);
 uint groupID = get_group_id(0);
 uint localID = get_local_id(0);
 if(10 == globalID)
 {
  float4 f = (float4)(inputbuffer[0], inputbuffer[1], inputbuffer[2], inputbuffer[3]);
  printf("Output vector data: f4 = %2.2v4hlf\n", f);
 }
 __local int data[10];
 data[localID] = localID;
 barrier(CLK_LOCAL_MEM_FENCE);

 if(10 == localID)
 {
  printf("\tThis is group %d\n",groupID);
  printf("\tOutput LDS data:  %d\n",data[10]);
 }
 printf("the global ID of this thread is : %d\n",globalID);
}
