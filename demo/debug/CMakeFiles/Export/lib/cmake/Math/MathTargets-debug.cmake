#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Math" for configuration "Debug"
set_property(TARGET Math APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(Math PROPERTIES
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/lib/libMathd.so.1.0.0"
  IMPORTED_SONAME_DEBUG "libMathd.so.1"
  )

list(APPEND _IMPORT_CHECK_TARGETS Math )
list(APPEND _IMPORT_CHECK_FILES_FOR_Math "${_IMPORT_PREFIX}/lib/libMathd.so.1.0.0" )

# Import target "SqrtLib" for configuration "Debug"
set_property(TARGET SqrtLib APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(SqrtLib PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/lib/libSqrtLibd.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS SqrtLib )
list(APPEND _IMPORT_CHECK_FILES_FOR_SqrtLib "${_IMPORT_PREFIX}/lib/libSqrtLibd.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
