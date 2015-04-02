# 1 "EigenValue_Kernels.cl"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "EigenValue_Kernels.cl"
# 16 "EigenValue_Kernels.cl"
class calEigenValue
{
protected:
 __global uint* numEigenIntervals;
 __global float* eigenIntervals;
 __global float* diagonal;
 __global float* offDiagonal;
 uint width;

 uint threadId;
 uint lowerId ;
 uint upperId ;

 float calNumEigenValuesLessThan(const float);

public:
 uint currentIndex;

 void initial(__global uint*, __global float*, __global float*, __global float*, const uint);
 void run();
};

class calEigenValue_inherit :public calEigenValue
{
public:
 float class_tolerance;
 __global float * newEigenIntervals;
 void run();
};

void
calEigenValue::initial(
 __global uint* numEigenIntervals,
 __global float* eigenIntervals,
 __global float* diagonal,
 __global float* offDiagonal,
 uint width
 )
{
 this->numEigenIntervals = numEigenIntervals;
    this->eigenIntervals = eigenIntervals;
    this->diagonal = diagonal ;
    this->offDiagonal = offDiagonal ;
    this->width = width ;

 this->lowerId = 2 * get_global_id(0);
 this->upperId = lowerId + 1;
}

float
calEigenValue::calNumEigenValuesLessThan(const float x)
{
    uint count = 0;

    float prev_diff = (this->diagonal[0] - x);
    count += (prev_diff < 0)? 1 : 0;
    for(uint i = 1; i < this->width ; i += 1)
    {
        float diff = (this->diagonal[i] - x) - ((this->offDiagonal[i-1] * this->offDiagonal[i-1]) / prev_diff);

        count += (diff < 0) ? 1 : 0;
        prev_diff = diff;
    }
    return count;
}

void
calEigenValue::run()
{
    float lowerLimit = this->eigenIntervals[lowerId];
    float upperLimit = this->eigenIntervals[upperId];

    uint numEigenValuesLessThanLowerLimit = calNumEigenValuesLessThan(lowerLimit);
    uint numEigenValuesLessThanUpperLimit = calNumEigenValuesLessThan(upperLimit);

    this->numEigenIntervals[get_global_id(0)] = numEigenValuesLessThanUpperLimit - numEigenValuesLessThanLowerLimit;
}


void
calEigenValue_inherit::run()
{
   this->currentIndex = get_global_id(0);

    uint index = 0;
    while(currentIndex >= this->numEigenIntervals[index])
    {
        currentIndex -= this->numEigenIntervals[index];
        ++index;
    }

    uint lId = 2 * index;
    uint uId = lId + 1;


    if(this->numEigenIntervals[index] == 1)
    {
        float midValue = (this->eigenIntervals[uId] + this->eigenIntervals[lId])/2;
        float n = calNumEigenValuesLessThan(midValue);
        n -= calNumEigenValuesLessThan(this->eigenIntervals[lId]);


        if(this->eigenIntervals[uId] - this->eigenIntervals[lId] < class_tolerance)
        {
            this->newEigenIntervals[this->lowerId] = this->eigenIntervals[lId];
            this->newEigenIntervals[this->upperId] = this->eigenIntervals[uId];
        }
        else if(n == 0)
        {
            this->newEigenIntervals[this->lowerId] = midValue;
            this->newEigenIntervals[this->upperId] = this->eigenIntervals[uId];
        }
        else
        {
            this->newEigenIntervals[this->lowerId] = this->eigenIntervals[lId];
            this->newEigenIntervals[this->upperId] = midValue;
        }
    }

    else
    {
        float divisionWidth = (this->eigenIntervals[uId] - this->eigenIntervals[lId]) / this->numEigenIntervals[index];
        this->newEigenIntervals[lowerId] = this->eigenIntervals[lId] + divisionWidth * currentIndex;
        this->newEigenIntervals[upperId] = this->newEigenIntervals[lowerId] + divisionWidth;
    }

}


__kernel
void calNumEigenValueInterval(__global uint * numEigenIntervals,
                              __global float * eigenIntervals,
                              __global float * diagonal,
                              __global float * offDiagonal,
                              uint width)
{
 calEigenValue EigenValue_A ;
 EigenValue_A.initial(numEigenIntervals,eigenIntervals,diagonal,offDiagonal,width);
 EigenValue_A.run();

}


__kernel
void recalculateEigenIntervals(__global float * newEigenIntervals,
                               __global float * eigenIntervals,
                               __global uint * numEigenIntervals,
                               __global float * diagonal,
                               __global float * offDiagonal,
                               const uint width,
                               const float tolerance)
{
 calEigenValue_inherit EigenValue_B ;
 EigenValue_B.class_tolerance = tolerance;
 EigenValue_B.newEigenIntervals = newEigenIntervals;
 EigenValue_B.initial(numEigenIntervals, eigenIntervals,diagonal,offDiagonal,width);
 EigenValue_B.run();

}
