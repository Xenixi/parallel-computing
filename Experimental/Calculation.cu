#include <iostream>
#include <math.h>

int main(int argc, char *argv[]){
    if(argc > 1){
        std::cout << argv[1] << " " << argv[2];
    } else {
        std::cout << "Nothing entered.";
    }
    



    return 0;
}