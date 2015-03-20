# 1 "MersenneTwister_Kernels.cl"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "MersenneTwister_Kernels.cl"
# 35 "MersenneTwister_Kernels.cl"
class gaussianRandom
{
protected:
 const __global uint4 *seedArray;
    uint width;
    uint mulFactor;
    __global float4 *gaussianRand;

    uint4 temp[8];

    size_t xPid;
    size_t yPid;

    uint4 state1;
    uint4 state2;
    uint4 state3;
    uint4 state4;
    uint4 state5;

    uint4 mask4;
    uint4 thirty4;
    uint4 one4;
    uint4 two4;
    uint4 three4;
    uint4 four4;

    uint4 r1;
    uint4 r2;

    uint4 a;
    uint4 b;

    uint4 e;
    uint4 f;

    unsigned int thirteen;
    unsigned int fifteen;
    unsigned int shift;

    unsigned int mask11;
    unsigned int mask12;
    unsigned int mask13;
    unsigned int mask14;

    size_t actualPos;

    float one;
    float intMax;
    float PI;
    float two;

    float4 r;
    float4 phi;

    float4 temp1;
    float4 temp2;

 unsigned int invshift;

 uint4 lshift128(uint4);
 uint4 rshift128(uint4);
 void evaluate(uint4 num_1,
                  uint4 num_2,
                  uint4 num_3,
                  uint4 num_4);

public:
 void initial(const __global uint4*, uint, uint, __global float4*);
 void run();


};

void
gaussianRandom::initial(const __global uint4 *seedArray,
            uint width,
            uint mulFactor,
            __global float4 *gaussianRand)
{
 this->seedArray = seedArray;
    this->width = width;
    this->mulFactor = mulFactor ;
    this->gaussianRand = gaussianRand ;

 xPid = get_global_id(0);
    yPid = get_global_id(1);

 state1 = seedArray[yPid *width + xPid];

    mask4 = (uint4)(1812433253u);
    thirty4 = (uint4)(30u);
    one4 = (uint4)(1u);
    two4 = (uint4)(2u);
    three4 = (uint4)(3u);
    four4 = (uint4)(4u);

    thirteen = 13u;
    fifteen = 15u;
    shift = 8u * 3u;

    mask11 = 0xfdff37ffu;
    mask12 = 0xef7f3f7du;
    mask13 = 0xff777b7du;
    mask14 = 0x7ff7fb2fu;

    one = 1.0f;
    intMax = 4294967296.0f;
    PI = 3.14159265358979f;
    two = 2.0f;

 invshift = 32u - shift;

 state2 = mask4 * (state1 ^ (state1 >> thirty4)) + one4;
    state3 = mask4 * (state2 ^ (state2 >> thirty4)) + two4;
    state4 = mask4 * (state3 ^ (state3 >> thirty4)) + three4;
    state5 = mask4 * (state4 ^ (state4 >> thirty4)) + four4;
}

void
gaussianRandom::run()
{
 uint i = 0;
    for(i = 0; i < mulFactor; ++i)
    {
        switch(i)
        {
            case 0:
    evaluate(state4, state5, state1, state3);
                break;
            case 1:
    evaluate(r2, temp[0], state2, state4);
                break;
            case 2:
    evaluate(r2, temp[1], state3, state5);
                break;
            case 3:
    evaluate(r2, temp[2], state4, state1);
                break;
            case 4:
    evaluate(r2, temp[3], state5, state2);
                break;
            case 5:
    evaluate(r2, temp[4], temp[0], temp[2]);
                break;
            case 6:
    evaluate(r2, temp[5], temp[1], temp[3]);
                break;
            case 7:
    evaluate(r2, temp[6], temp[2], temp[4]);
                break;
            default:
                break;

        }

        e = lshift128(a);
        f = rshift128(r1);

        temp[i].x = a.x ^ e.x ^ ((b.x >> thirteen) & mask11) ^ f.x ^ (r2.x << fifteen);
        temp[i].y = a.y ^ e.y ^ ((b.y >> thirteen) & mask12) ^ f.y ^ (r2.y << fifteen);
        temp[i].z = a.z ^ e.z ^ ((b.z >> thirteen) & mask13) ^ f.z ^ (r2.z << fifteen);
        temp[i].w = a.w ^ e.w ^ ((b.w >> thirteen) & mask14) ^ f.w ^ (r2.w << fifteen);
    }

    actualPos = (yPid * width + xPid) * mulFactor;

    for(i = 0; i < mulFactor / 2; ++i)
    {
        temp1 = convert_float4(temp[i]) * one / intMax;
        temp2 = convert_float4(temp[i + 1]) * one / intMax;


        r = sqrt((-two) * log(temp1));
        phi = two * PI * temp2;
        gaussianRand[actualPos + i * 2 + 0] = r * cos(phi);
        gaussianRand[actualPos + i * 2 + 1] = r * sin(phi);
    }

}

uint4
gaussianRandom::lshift128(uint4 input)
{
    uint4 temp;

    temp.x = input.x << shift;
    temp.y = (input.y << shift) | (input.x >> invshift);
    temp.z = (input.z << shift) | (input.y >> invshift);
    temp.w = (input.w << shift) | (input.z >> invshift);

    return temp;
}

uint4
gaussianRandom::rshift128(uint4 input)
{
    uint4 temp;

    temp.w = input.w >> shift;
    temp.z = (input.z >> shift) | (input.w << invshift);
    temp.y = (input.y >> shift) | (input.z << invshift);
    temp.x = (input.x >> shift) | (input.y << invshift);

    return temp;
}

void
gaussianRandom::evaluate(uint4 num_1,
                         uint4 num_2,
                         uint4 num_3,
                         uint4 num_4)
{
 this->r1 = num_1;
 this->r2 = num_2;
 this->a = num_3;
 this->b = num_4;
}

__kernel
void gaussianRand(const __global uint4 *seedArray,
            uint width,
            uint mulFactor,
            __global float4 *gaussianRand)
{

    gaussianRandom GaussianRand;
 GaussianRand.initial(seedArray, width, mulFactor, gaussianRand);
 GaussianRand.run();

}
