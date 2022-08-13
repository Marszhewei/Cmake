#include <cmath>

#ifdef USE_MYMATH
    #include "my_sqrt.h"
#endif

namespace mathfunctions {
    double sqrt(double x)
    {
        #ifdef USE_MYMATH
        return detail::my_sqrt(x);
        #else
        return std::sqrt(x);
        #endif
    }
}