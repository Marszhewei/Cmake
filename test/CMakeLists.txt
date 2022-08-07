cmake_minimum_required(VERSION 3.10)

project(testinstall)

set(CMAKE_BUILD_TYPE Debug)

# add_library(Math SHARED IMPORTED)
# set_property(TARGET Math PROPERTY
#                 IMPORTED_LOCATION "/home/mars/Projects/VscodeWorkspace/cmake_test/install/lib/libMathFunctions.so")
# set_property(TARGET Math PROPERTY
#                 IMPORTED_IMPLIB "/home/mars/Projects/VscodeWorkspace/cmake_test/install/lib/libMathFunctions.so")
# set_property(TARGET Math PROPERTY
#                 INTERFACE_INCLUDE_DIRECTORIES "/home/mars/Projects/VscodeWorkspace/cmake_test/install/include/")

# include("/home/mars/Projects/VscodeWorkspace/cmake_test/install/lib/cmake/MathFunctions/MathFunctionsTargets.cmake")

set(CMAKE_PREFIX_PATH "/home/mars/Projects/VscodeWorkspace/cmake_test/install/")
find_package(MathFunctions 1.0)

add_executable(main main.cxx)

target_link_libraries(main PRIVATE MathFunctions)