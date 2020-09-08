#include <iostream>
#include <math.h>
#include <chrono>

__global__ void add(int n, float *x, float *y)
{
    for (int i = 0; i < n; i++)
    {

        y[i] = x[i] + y[i];
    }
    return;
}

int main(void)
{
    auto t1 = std::chrono::high_resolution_clock::now();

    std::cout << "Running 1" << std::endl;
    int n = 1 << 15; //1m

    float *x;
    float *y;
    //need to alloc accessible memory

    cudaMallocManaged(&x, n * sizeof(float));
    cudaMallocManaged(&y, n * sizeof(float));

    //  std::cout << "Running 2 | Size: " << sizeof(x) << std::endl;
    for (unsigned long i = 0; i < n; i++)
    {
        std::cout << "iter " << i << std::endl;
        x[i] = (float)(rand() / 32.23f);
        y[i] = (float)(rand() / 24.354f);
    }
    //  std::cout << "Running 3" << std::endl;
    add<<<1,1>>>(n, x, y);
    //  for(int w = 0; w < n; w++){
    //       std::cout << y[w] << std::endl;;
    //   }
    
    //  std::cout << "Running 4" << std::endl;

    //CPU wait until task done
    cudaDeviceSynchronise();
    //must call sync before freeing memory
    cudaFree(x);
    cudaFree(y);

    auto t2 = std::chrono::high_resolution_clock::now();

    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(t2 - t1).count();

    std::cout << "Time taken: " << float(duration / 1000.00f) << "ms";
    return 0;
}