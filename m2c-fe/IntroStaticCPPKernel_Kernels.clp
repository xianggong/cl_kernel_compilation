# 1 "IntroStaticCPPKernel_Kernels.cl"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "IntroStaticCPPKernel_Kernels.cl"
# 31 "IntroStaticCPPKernel_Kernels.cl"
template <typename T>
class Rect
{
    T myLength;
    T myWidth;
public:
    Rect () {
    }
    Rect (T a, T b)
    {
        myLength = a;
        myWidth = b;
    }
    T get_length()
    {
        return myLength;
    }
    T get_width()
    {
        return myWidth;
    }
};
# 62 "IntroStaticCPPKernel_Kernels.cl"
template <typename T>
kernel void AreaCalculation(__global Rect <T>* InputClass, __global T* myDevArea )
{
    size_t gid = get_global_id(0);
    myDevArea[gid] = InputClass[gid].get_length()* InputClass[gid].get_width();
}

template __attribute__((mangled_name(AreaCalculation_float))) kernel void
    AreaCalculation(__global Rect<float>* InputClass, __global float* myDevArea);

template __attribute__((mangled_name(AreaCalculation_int))) kernel void
    AreaCalculation(__global Rect<int>* InputClass, __global int* myDevArea);
