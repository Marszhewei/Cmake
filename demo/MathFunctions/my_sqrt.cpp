#include <iostream>
#include <cmath>

#include "table.h"

namespace mathfunctions {
    namespace detail {
        // a hack square root calculation using simple operations
        double my_sqrt(double x)
        {
            if (x <= 0) {
                return 0;
            }

            if (x >= 1 && x < 10) {
                std::cout << "Use the table to help find an initial value " << std::endl;
                double result = sqrtTable[static_cast<int>(x)];
                return result;
            }

        //   double result = x;
        #if defined(HAVE_LOG) && defined(HAVE_EXP)
            double result = std::exp(std::log(x) * 0.5);
            std::cout << "Computing sqrt of " << x << " to be " << result
                    << " using log and exp" << std::endl;
        #else
            double result = x;

            // do ten iterations
            for (int i = 0; i < 10; ++i) {
                if (result <= 0) {
                    result = 0.1;
            }
                double delta = x - (result * result);
                result = result + 0.5 * delta / result;
                std::cout << "Computing sqrt of " << x << " to be " << result << std::endl;
            }
        #endif

        return result;
        }
    }
}



