#include <iostream>
#include <math.h>
#include <chrono>

__global__ void mMultiply(int length, float *a, float *b, float *output)
{
    int index = threadIdx.x;
    int stride = blockDim.x;

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

    float *testA;
    float *testB;
    float *outputC;

    cudaMallocManaged(&testA, 10000000 * sizeof(float));
    cudaMallocManaged(&testB, 10000000 * sizeof(float));
    cudaMallocManaged(&outputC, 10000000 * sizeof(float));

    std::cout << "Completed array creation." << std::endl;
    std::cout << "Calculating..." << std::endl;

    auto time1 = std::chrono::high_resolution_clock::now();

    mMultiply<<<5, 1024>>>(10000000, testA, testB, outputC);

    cudaDeviceSynchronize();

    auto time2 = std::chrono::high_resolution_clock::now();

    auto dur = std::chrono::duration_cast<std::chrono::microseconds>(time2 - time1).count();

    std::cout << "[CUDA] Time taken: " << (dur / 1000.00) << "ms";
  

    cudaFree(testA);
    cudaFree(testB);
    cudaFree(outputC);
    return 0;
}