# 创建名为MathFunctions的静态库
add_library(Math mysqrt.cxx)
# add_library(MathFunctions STATIC mysqrt.cxx)

target_include_directories(Math
          INTERFACE ${PROJECT_SOURCE_DIR}/MathFunctions# ${CMAKE_CURRENT_SOURCE_DIR}
          )		# 把与该库源代码有关的头文件绑定到该库（INTERFACE表明该库用不到该头文件，提供给调用该库的接口）


get_target_property(i_d Math INCLUDE_DIRECTORIES)
get_target_property(i_i_d Math INTERFACE_INCLUDE_DIRECTORIES)

message(NOTICE "** Math INCLUDE_DIRECTORIES: ${i_d}")
message(NOTICE "** Math INTERFACE_INCLUDE_DIRECTORIES: ${i_i_d}")
