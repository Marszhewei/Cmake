//
// Created by fetch150zy on 8/12/22.
//

#include <iostream>
#include <string>
#include <cmath>

#include "config.h"

#ifdef BUILD_SHARED_LIBS
    #include "math_func.h"
#endif

int main(int argc, char* argv[])
{
  if (argc < 2) {
    // report version
    std::cout << argv[0] << " Version " << VERSION_MAJOR << "."
              << VERSION_MINOR << std::endl;
    std::cout << "Usage: " << argv[0] << " number" << std::endl;
    return 1;
  }

  // convert input to double
  const double inputValue = std::stod(argv[1]);

  // which square root function should we use?
#ifdef BUILD_SHARED_LIBS
  const double outputValue = mathfunctions::sqrt(inputValue);
#else
  const double outputValue = sqrt(inputValue);
#endif

  std::cout << "The square root of " << inputValue << " is " << outputValue
            << std::endl;
  return 0;
}