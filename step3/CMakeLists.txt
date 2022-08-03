# 指定cmake最低版本
cmake_minimum_required(VERSION 3.10)


# 设置项目名称以及项目版本信息
project(Tutorial VERSION 1.2)
# project(Tutorial)
# set(Tutorial_VERSION_MAJOR 1)
# set(Tutorial_VERSION_MINOR 2)


# 设定C++标准
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)


# 实现将MathFunctions库设为可选
option(USE_MYMATH "Use tutorial provided math implementation" ON)


# 配置头文件将版本号传递给源代码
configure_file( "${PROJECT_SOURCE_DIR}/TutorialConfig.h.in"
                "${PROJECT_BINARY_DIR}/TutorialConfig.h")
# configure_file(TutorialConfig.h.in TutorialConfig.h)


#[[ 链接库
# add the MathFunctions library
add_subdirectory(MathFunctions)


# 添加可执行文件
add_executable(Tutorial tutorial.cxx)

# 指定头文件所在目录
target_include_directories(Tutorial PUBLIC
                        "${PROJECT_BINARY_DIR}"
                        "${PROJECT_SOURCE_DIR}/MathFunctions"
                        )
# include_directories("${PROJECT_BINARY_DIR}"
#                     "${PROJECT_SOURCE_DIR}/MathFunctions")
# add_executable(Tutorial tutorial.cxx)


target_link_libraries(Tutorial PUBLIC MathFunctions) 
]]


if(USE_MYMATH)
    add_subdirectory(${PROJECT_SOURCE_DIR}/MathFunctions)
    list(APPEND EXTRA_LIBS Math)
endif()
add_executable(Tutorial tutorial.cxx)
target_include_directories(Tutorial PRIVATE # PUBLIC
                        ${PROJECT_BINARY_DIR}
                        )
target_link_libraries(Tutorial PRIVATE ${EXTRA_LIBS}) # PUBLIC


get_target_property(i_d Tutorial INCLUDE_DIRECTORIES)
get_target_property(i_i_d Tutorial INTERFACE_INCLUDE_DIRECTORIES)

get_target_property(l_l Tutorial LINK_LIBRARIES)
get_target_property(i_l_l Tutorial INTERFACE_LINK_LIBRARIES)

message(NOTICE "** Tutorial INCLUDE_DIRECTORIES: ${i_d}")
message(NOTICE "** Tutorial INTERFACE_INCLUDE_DIRECTORIES: ${i_i_d}")

message(NOTICE "** Tutorial LINK_LIBRARIES: ${l_l}")
message(NOTICE "** Tutorial INTERFACE_LINK_LIBRARIES: ${i_l_l}")

set(CMAKE_DEBUG_TARGET_PROPERTIES INCLUDE_DIRECTORIES)
