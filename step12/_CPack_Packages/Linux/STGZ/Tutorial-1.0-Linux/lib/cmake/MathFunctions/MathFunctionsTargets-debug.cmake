#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "MathFunctions" for configuration "Debug"
set_property(TARGET MathFunctions APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(MathFunctions PROPERTIES
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/lib/libMathFunctionsd.so.1.0.0"
  IMPORTED_SONAME_DEBUG "libMathFunctionsd.so.1"
  )

list(APPEND _IMPORT_CHECK_TARGETS MathFunctions )
list(APPEND _IMPORT_CHECK_FILES_FOR_MathFunctions "${_IMPORT_PREFIX}/lib/libMathFunctionsd.so.1.0.0" )

# Import target "SqrtLibrary" for configuration "Debug"
set_property(TARGET SqrtLibrary APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(SqrtLibrary PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/lib/libSqrtLibraryd.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS SqrtLibrary )
list(APPEND _IMPORT_CHECK_FILES_FOR_SqrtLibrary "${_IMPORT_PREFIX}/lib/libSqrtLibraryd.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
