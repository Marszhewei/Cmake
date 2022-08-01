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


# 配置头文件将版本号传递给源代码
configure_file( "${PROJECT_SOURCE_DIR}/TutorialConfig.h.in"
                "${PROJECT_BINARY_DIR}/TutorialConfig.h")
# configure_file(TutorialConfig.h.in TutorialConfig.h)


# 添加可执行文件
add_executable(Tutorial tutorial.cxx)

# 指定头文件所在目录
target_include_directories(Tutorial PUBLIC
                           "${PROJECT_BINARY_DIR}"
                           ) # 头文件在二进制代码同目录
# include_directories("${PROJECT_BINARY_DIR}")
# add_executable(Tutorial tutorial.cxx)