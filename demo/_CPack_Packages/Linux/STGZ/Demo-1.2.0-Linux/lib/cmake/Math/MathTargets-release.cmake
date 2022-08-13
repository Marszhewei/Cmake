#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Math" for configuration "Release"
set_property(TARGET Math APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(Math PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libMath.so.1.0.0"
  IMPORTED_SONAME_RELEASE "libMath.so.1"
  )

list(APPEND _IMPORT_CHECK_TARGETS Math )
list(APPEND _IMPORT_CHECK_FILES_FOR_Math "${_IMPORT_PREFIX}/lib/libMath.so.1.0.0" )

# Import target "SqrtLib" for configuration "Release"
set_property(TARGET SqrtLib APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(SqrtLib PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libSqrtLib.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS SqrtLib )
list(APPEND _IMPORT_CHECK_FILES_FOR_SqrtLib "${_IMPORT_PREFIX}/lib/libSqrtLib.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
