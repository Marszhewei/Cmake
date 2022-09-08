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
    add_subdirectory(./MathFunctions)		# 调用子目录下的CMakeLists.txt文件
    list(APPEND EXTRA_LIBS MathFunctions)	# 添加库到变量中
    list(APPEND EXTRA_INCLUDES "${PROJECT_SOURCE_DIR}/MathFunctions")	# 头文件路径
endif()
add_executable(Tutorial tutorial.cxx)
target_include_directories(Tutorial PUBLIC
                        "${PROJECT_BINARY_DIR}"
                        ${EXTRA_INCLUDES}
                        )
target_link_libraries(Tutorial PUBLIC ${EXTRA_LIBS})
# include_directories("${PROJECT_BINARY_DIR}")
# if (USE_MYMATH)
#   include_directories ("${PROJECT_SOURCE_DIR}/MathFunctions")
#   add_subdirectory (MathFunctions)
#   set (EXTRA_LIBS ${EXTRA_LIBS} MathFunctions)
# endif (USE_MYMATH)
# add_executable (Tutorial tutorial.cxx)
# target_link_libraries (Tutorial  ${EXTRA_LIBS})
