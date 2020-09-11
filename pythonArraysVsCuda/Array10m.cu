#include <iostream>
#include <math.h>
#include <chrono>
__global__ void init(int length, float *a, float *b)
{
    int index = blockIdx.x * blockDim.x + threadIdx.x;
    int stride = blockDim.x * gridDim.x;

    for (int i = index; i < length; i += stride)
    {
        a[i] = 2.3423;
        b[i] = 1.4214;
    }
}

__global__ void mMultiply(int length, float *a, float *b, float *output)
{
    int index = blockIdx.x * blockDim.x + threadIdx.x;
    int stride = blockDim.x * gridDim.x;

    for (int i = index; i < length; i += stride)
    {
        output[i] = (a[i] * b[i]);
    }
    for (int i = index; i < length; i += stride)
    {
        output[i] = (output[i] * a[i]);
    }
    for (int i = index; i < length; i += stride)
    {
        output[i] = (output[i] * b[i]);
    }
}

int main(void)
{
    std::cout << "Starting CUDA example... Array 10m entries" << std::endl;
    std::cout << "Creating array" << std::endl;

    int number = 10000000;

    float *testA;
    float *testB;
    float *outputC;

    cudaMallocManaged(&testA, number * sizeof(float));
    cudaMallocManaged(&testB, number * sizeof(float));
    cudaMallocManaged(&outputC, number * sizeof(float));
    /*
     for (int i = 0; i < number; i++)
    {
        testA[i] = 2.3423;
        testB[i] = 1.4214;
    }
    
*/

//    init<<<9766, 1024>>>(number, testA, testB);
    init<<<9766, 1024>>>(number, testA, testB);
    cudaDeviceSynchronize();

    std::cout << "Completed array creation." << std::endl;
    std::cout << "Calculating..." << std::endl;

    auto time1 = std::chrono::high_resolution_clock::now();

    mMultiply<<<9766, 1024>>>(number, testA, testB, outputC);

    cudaDeviceSynchronize();

    auto time2 = std::chrono::high_resolution_clock::now();

    auto dur = std::chrono::duration_cast<std::chrono::microseconds>(time2 - time1).count();

    std::cout << "[CUDA] Time taken: " << (dur / 1000.00) << "ms";

    cudaFree(testA);
    cudaFree(testB);
    cudaFree(outputC);
    return 0;
}