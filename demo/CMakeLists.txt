# cmake mini version
cmake_minimum_required(VERSION 3.23)

# project name and project version
#[[ project(Demo VERSION 1.2) ]]#
project(Demo)
set(PROJECT_VERSION_MAJOR 1)
set(PROJECT_VERSION_MINOR 2)
set(PROJECT_VERSION_PATCH 0)

 # set debug
 set(CMAKE_DEBUG_POSTFIX d)

# C++ version
#[[ set(CMAKE_CXX_STANDARD 17)
 set(CMAKE_CXX_STANDARD_REQUIRED True) ]]#

# set C++ version by lib compiler_flag
add_library(compiler_flag INTERFACE)
target_compile_features(compiler_flag INTERFACE cxx_std_17)

set(gcc_like_cxx "$<COMPILE_LANG_AND_ID:CXX,ARMClang,AppleClang,Clang,GNU,LCC>")
set(msvc_cxx "$<COMPILE_LANG_AND_ID:CXX,MSVC>")
target_compile_options(compiler_flag INTERFACE
  "$<${gcc_like_cxx}:$<BUILD_INTERFACE:-Wall;-Wextra;-Wshadow;-Wformat=2;-Wunused>>"
  "$<${msvc_cxx}:$<BUILD_INTERFACE:-W3>>"
)

# set static, shared lib and exec file path
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}") # static lib
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}") # shared lib
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}") # exec

# make Math lib(shared) optional
option(BUILD_SHARED_LIBS "Build using shared libraries" ON)

# config.h.in --> config.h  path: from top level to build
configure_file( "${PROJECT_SOURCE_DIR}/config.h.in"
        "${PROJECT_BINARY_DIR}/config.h")

if(BUILD_SHARED_LIBS)
    # enter MathFunctions/CMakeLists.txt
    add_subdirectory(MathFunctions)
    # append Math lib(shared) to Variable EXTRA_LIBS
    list(APPEND EXTRA_LIBS Math)
endif(BUILD_SHARED_LIBS)

# get all .cpp file in PROJECT_SOURCE_DIR
# aux_source_directory(./*.cpp SRC_LIST)
set(SRC_LIST main.cpp)

# add exec
add_executable(res ${SRC_LIST})

# set debug
set_target_properties(res PROPERTIES DEBUG_POSTFIX ${CMAKE_DEBUG_POSTFIX})

# get head file path
target_include_directories(res PRIVATE
        ${PROJECT_BINARY_DIR}           # config.h
        )

# link lib
target_link_libraries(res PRIVATE ${EXTRA_LIBS} compiler_flag)

# get INCLUDE_DIRECTORIES and INTERFACE_INCLUDE_DIRECTORIES about exec res
get_target_property(r_i_d res INCLUDE_DIRECTORIES)
get_target_property(r_i_i_d res INTERFACE_INCLUDE_DIRECTORIES)

# get LINK_LIBRARIES and INTERFACE_LINK_LIBRARIES about exec res
get_target_property(r_l_l res LINK_LIBRARIES)
get_target_property(r_i_l_l res INTERFACE_LINK_LIBRARIES)

# print it in cmake
message(NOTICE "** res INCLUDE_DIRECTORIES: ${r_i_d}")
message(NOTICE "** res INTERFACE_INCLUDE_DIRECTORIES: ${r_i_i_d}")

message(NOTICE "** res LINK_LIBRARIES: ${r_l_l}")
message(NOTICE "** res INTERFACE_LINK_LIBRARIES: ${r_i_l_l}")

set(CMAKE_DEBUG_TARGET_PROPERTIES INCLUDE_DIRECTORIES)

# test
#[[ enable_testing() ]]#
# add support for a testing dashboard
include(CTest)

# add test examples
add_test(NAME Runs COMMAND ./res 25)
add_test(NAME Usage COMMAND ./res)

# for test Usage, return 1, match by regular expression
set_tests_properties(Usage
        PROPERTIES PASS_REGULAR_EXPRESSION "Usage:.*number"
        )


# define a function for test modules
function(do_test target arg result) # func_name args...
    add_test(NAME Comp${arg} COMMAND ${target} ${arg})
    set_tests_properties(Comp${arg}
    PROPERTIES PASS_REGULAR_EXPRESSION ${result}
    )
endfunction(do_test)

# some test exps
do_test(res 4 "4 is 2")
do_test(res 9 "9 is 3")
do_test(res 5 "5 is 2.236")
do_test(res 7 "7 is 2.645")
do_test(res 25 "25 is 5")
do_test(res -25 "-25 is (-nan|nan|0)")
do_test(res 0.0001 "0.0001 is 0.01")

# install
install(TARGETS res DESTINATION bin)
install(FILES ${PROJECT_BINARY_DIR}/config.h DESTINATION include)

# pack
# load runtime lib needed by this project
include(InstallRequiredSystemLibraries)
# load license info
set(CPACK_RESOURCE_FILE_LICENSE ${CMAKE_CURRENT_SOURCE_DIR}/License.txt)
# load verison info
set(CPACK_PACKAGE_VERSION_MAJOR ${PROJECT_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${PROJECT_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${PROJECT_VERSION_PATCH})
# set generator
# set(CPACK_SOURCE_GENERATOR "STGZ")
# set(CPACK_SOURCE_GENERATOR "TGZ")
# set(CPACK_SOURCE_GENERATOR "TZ")
include(CPack)

# export config
install(EXPORT MathTargets
  FILE MathTargets.cmake
  DESTINATION lib/cmake/Math
)

include(CMakePackageConfigHelpers)
configure_package_config_file(${CMAKE_CURRENT_SOURCE_DIR}/Config.cmake.in
  "${CMAKE_CURRENT_BINARY_DIR}/MathConfig.cmake"
  INSTALL_DESTINATION "lib/cmake/example"
  NO_SET_AND_CHECK_MACRO
  NO_CHECK_REQUIRED_COMPONENTS_MACRO
  )

write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/MathConfigVersion.cmake"
  VERSION "${Tutorial_VERSION_MAJOR}.${Tutorial_VERSION_MINOR}"
  COMPATIBILITY AnyNewerVersion
)

install(FILES
  ${CMAKE_CURRENT_BINARY_DIR}/MathConfig.cmake
  ${CMAKE_CURRENT_BINARY_DIR}/MathConfigVersion.cmake
  DESTINATION lib/cmake/Math
  )

# export(EXPORT MathTargets
#     FILE "${CMAKE_CURRENT_BINARY_DIR}/MathTargets.cmake"
#     )