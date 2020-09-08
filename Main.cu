#include <iostream>
#include <math.h>
#include <chrono>

__global__ void add(int n, float *x, float *y)
{

    int index = threadIdx.x;
    int stride = blockDim.x;

    for (unsigned long i = 0; i < n; i++)
    {
        //std::cout << "iter " << i << std::endl;
      
            x[i] = (float)(536.0f / 32.23f);

            y[i] = (float)(653.1f / 24.354f);
        
    }

    for (int i = index; i < n; i += stride)
    {
      
            y[i] = x[i] + y[i];
            x[i] = y[i] * 0.5f;
        
    }
    for (int i = index; i < n; i += stride)
    {
        
            y[i] = (x[i] + (y[i] * 1.3f)) / (sqrt(y[i]) * cbrt(x[i] * 0.5f) / 3);
            x[i] = y[i] * 0.5f;
        
    }
}

int main(void)
{
  //  auto t1 = std::chrono::high_resolution_clock::now();
    //for maximum GPU eating
    //  for (int loopsNum = 0; loopsNum < 5000; loopsNum += 1)
    //  {

  //  std::cout << "Running 1" << std::endl;
    int n = (1000000); //

    float *x;
    float *y;

    //need to alloc accessible memory

    cudaMallocManaged(&x, n * sizeof(float));
    cudaMallocManaged(&y, n * sizeof(float));
 

    //  std::cout << "Running 2 | Size: " << sizeof(x) << std::endl;

    //  std::cout << "Running 3" << std::endl;
    add<<<6, 128>>>(n,x,y);

    //  for(int w = 0; w < n; w++){
    //       std::cout << y[w] << std::endl;;
    //   }

    //  std::cout << "Running 4" << std::endl;

    //CPU wait until task done
    cudaDeviceSynchronize();
    //must call sync before freeing memory
    cudaFree(x);
    cudaFree(y);

    // }
    //auto t2 = std::chrono::high_resolution_clock::now();

   // auto duration = std::chrono::duration_cast<std::chrono::microseconds>(t2 - t1).count();

  //  std::cout << "Time taken: " << float(duration / 1000.00f) << "ms";
    return 0;
}