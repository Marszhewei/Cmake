#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Math" for configuration ""
set_property(TARGET Math APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(Math PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libMath.so.1.0.0"
  IMPORTED_SONAME_NOCONFIG "libMath.so.1.0.0"
  )

list(APPEND _IMPORT_CHECK_TARGETS Math )
list(APPEND _IMPORT_CHECK_FILES_FOR_Math "${_IMPORT_PREFIX}/lib/libMath.so.1.0.0" )

# Import target "SqrtLib" for configuration ""
set_property(TARGET SqrtLib APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(SqrtLib PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_NOCONFIG "CXX"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libSqrtLib.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS SqrtLib )
list(APPEND _IMPORT_CHECK_FILES_FOR_SqrtLib "${_IMPORT_PREFIX}/lib/libSqrtLib.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
