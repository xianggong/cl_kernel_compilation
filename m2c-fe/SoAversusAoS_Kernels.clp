# 1 "SoAversusAoS_Kernels.cl"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "SoAversusAoS_Kernels.cl"
# 17 "SoAversusAoS_Kernels.cl"
template <int TREE_SIZE>
struct AppleTree
{
 int apples[TREE_SIZE];
};

template <int TREE_NUM>
struct ApplesOnTrees
{
 int trees[TREE_NUM];
};


__kernel void AoSKernel(global AppleTree<num1> *trees, global int *outBuf,int treeSize)
{
   uint gid = get_global_id(0);
   uint res = 0;
   for(int i=0;i<treeSize;i++)
   {
       res += trees[gid].apples[i];
   }
   outBuf[gid] = res;
}


__kernel void SoAKernel(global ApplesOnTrees<num2> *applesOnTrees, global int *outBuf,int treeSize)
{
   uint gid = get_global_id(0);
   uint res = 0;
   for(int i = 0;i<treeSize;i++)
   {
    res += applesOnTrees[i].trees[gid];
   }
   outBuf[gid] = res;
}
