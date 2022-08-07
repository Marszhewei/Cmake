#include <iostream>
#include <string>
#include "MathFunctions.h"


void test(void)
{
    for (int i = 0; i < 5; ++i)
    {
        std::cout << "this is: " << i << std::endl;
    }
    std::cout << "end func" << std::endl;
    return ;
}

int main(int argc, char** argv)
{
    std::cout << "hello" << std::endl;
    for (int i = 0; i < 5; ++i)
    {
        std::cout << i << std::endl;
    }
    test();
    if (argc < 3)
    {
        std::cout << "error" << std::endl;
        return 1;
    }
    double a = std::stod(argv[1]);
    double b = std::stod(argv[2]);

    double c = mathfunctions::sqrt(a*a+b*b);
    std::cout << "the res is: " << c << std::endl;

    return 0;
}