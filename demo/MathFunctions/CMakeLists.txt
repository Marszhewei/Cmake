# add a shared lib
add_library(Math SHARED math_func.cpp)

# find head file path
#[[ target_include_directories(Math INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})  # my_sqrt.h ]]#
target_include_directories(Math INTERFACE
                            $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>  # for build
                            $<INSTALL_INTERFACE:include>                    # for install
                           )

# use our own math functions?
option(USE_MYMATH "Use tutorial provided math implementation" ON)

if(USE_MYMATH)
    # define USE_MYMATH in Math lib(shared)
    target_compile_definitions(Math PRIVATE "USE_MYMATH")

    # add exec 
    add_executable(Table make_table.cpp)

    # create table.h in ./build/MathFunctions/
    add_custom_command(
        OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/table.h
        COMMAND Table ${CMAKE_CURRENT_BINARY_DIR}/table.h
        DEPENDS Table
        )

    # add a static lib
    add_library(SqrtLib STATIC my_sqrt.cpp
                ${CMAKE_CURRENT_BINARY_DIR}/table.h)

    # link flags for C++ version
    target_link_libraries(SqrtLib PRIVATE compiler_flag)

    # find head file path (Math lib in need)
    target_include_directories(SqrtLib
            PRIVATE ${CMAKE_CURRENT_BINARY_DIR}     # table.h
            )

    # static lib are location dependent, shared lib are location independent
    # if we combining static lib and shared lib, we must set POSITION_INDEPENDENT_CODE target property of SqrtLib be true
    set_target_properties(SqrtLib PROPERTIES
                POSITION_INDEPENDENT_CODE ${BUILD_SHARED_LIBS}
                )
    
    target_link_libraries(Math PRIVATE SqrtLib compiler_flag)
endif(USE_MYMATH)

# get INCLUDE_DIRECTORIES and INTERFACE_INCLUDE_DIRECTORIES about Math lib
get_target_property(m_i_d Math INCLUDE_DIRECTORIES)
get_target_property(m_i_i_d Math INTERFACE_INCLUDE_DIRECTORIES)

# get INCLUDE_DIRECTORIES and INTERFACE_INCLUDE_DIRECTORIES about SqrtLib lib
get_target_property(s_i_d SqrtLib INCLUDE_DIRECTORIES)
get_target_property(s_i_i_d SqrtLib INTERFACE_INCLUDE_DIRECTORIES)

# print it in cmake
message(NOTICE "** Math INCLUDE_DIRECTORIES: ${m_i_d}")
message(NOTICE "** Math INTERFACE_INCLUDE_DIRECTORIES: ${m_i_i_d}")

message(NOTICE "** SqrtLib INCLUDE_DIRECTORIES: ${s_i_d}")
message(NOTICE "** SqrtLib INTERFACE_INCLUDE_DIRECTORIES: ${s_i_i_d}")

# judge system provide the log and exp?
include(CheckCXXSourceCompiles)
check_cxx_source_compiles("
    #include <cmath>
    int main() {
        std::log(1.0);
        return 0;
    }
    " HAVE_LOG)

check_cxx_source_compiles("
    #include <cmath>
    int main() {
        std::exp(1.0);
        return 0;
    }
    " HAVE_EXP)

#define HAVE_LOG and HAVE_EXP in SqrtLib lib(static)
if(HAVE_LOG AND HAVE_EXP)
    target_compile_definitions(SqrtLib PRIVATE HAVE_LOG HAVE_EXP)
endif()

# add version num to Math lib(shared)
set_property(TARGET Math PROPERTY VERSION "1.0.0")
set_property(TARGET Math PROPERTY SOVERSION "1")

# install rules
set(installable_libs Math compiler_flag)
if(TARGET SqrtLib)
  list(APPEND installable_libs SqrtLib)
endif()
install(TARGETS ${installable_libs}
        EXPORT MathTargets
        DESTINATION lib)
install(FILES math_func.h DESTINATION include)