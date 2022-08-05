#include <iostream>
#include <string>
#include "MathFunctions.h"

int main(int argc, char** argv)
{
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