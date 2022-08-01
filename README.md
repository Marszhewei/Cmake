# cmake

## cmake_mininum_required

**_主要用于设定cmake最低版本要求_**

1.   语法格式

     ```cmake
     cmake_minimum_required(VERSION <min>[...<policy_max>] [FATAL_ERROR])
     ```

     

2.   参数

     -   VERSION

         此命令会将`CMAKE_MINIMUM_REQUIRED_VERSION`变量的值设置为 `<min>` 

         ```cmake
         cmake_mininum_required(VERSION 3.10...3.20)
         ```

     -   FATAL_ERROR

         该 `FATAL_ERROR` 选项被接受，但通过CMake的2.6和更高忽略。应该指定它，以便CMake 2.4及更低版本失败并显示错误，而不仅仅是警告

         

3.   policy setting

     当指定的 `<min>` 版本高于2.4时，该命令会隐式调用

     ```cmake
     cmake_policy(VERSION <min>[...<max>])
     ```

     当给出 `<min>` 2.4或更低版本时，该命令会隐式调用

     ```cmake
     cmake_policy(VERSION 2.4[...<max>])
     ```





## project

**_主要用于指定项目相关信息_**

1.   语法格式

     ```cmake
     project(<PROJECT-NAME> [<language-name>...]) # project_name是必须项，项目版本，语言等为可选项
     project(<PROJECT-NAME>
             [VERSION <major>[.<minor>[.<patch>[.<tweak>]]]]	# 项目版本
             [DESCRIPTION <project-description-string>]	# 项目描述
             [HOMEPAGE_URL <url-string>]	# 主页地址
             [LANGUAGES <language-name>...])	# 指定项目语言
     ```

     

2.   参数

     -   VERSION

         1.  `PROJECT_VERSION` `<PROJECT_NAME>_VERSION`
         2.  `PROJECT_VERSION_MAJOR` `<PROJECT_NAME>_VERSION_MAJOR`
         3.  `PROJECT_VERSION_MINOR` `<PROJECT_NAME>_VERSION_MINOR`
         4.  `PROJECT_VERSION_PATCH` `<PROJECT_NAME>_VERSION_PATCH`
         5.  `PROJECT_VERSION_TWEAK` `<PROJECT_NAME>_VERSION_TWEAK`

         `project()`从顶层调用命令 时`CMakeLists.txt`，版本也存储在变量中 `CMAKE_PROJECT_VERSION`

         ```cmake
         project(NAME 1.2.3.4)
         # PROJECT_VERSION/CMAKE_PROJECT_VERSION == 1.2.3.4
         # PROJECT_VERSION_MAJOR == 1 主要
         # PROJECT_VERSION_MINOR == 2 次要
         # PROJECT_VERSION_PATCH == 3 修补
         # PROJECT_VERSION_TWEAK == 4 调整
         ```

     -   DESCRIPTION

         `PROJECT_DESCRIPTION` `<PROJECT_NAME>_DESCRIPTION`

         当`project()`从顶层调用命令时`CMakeLists.txt`，描述也存储在变量中`CMAKE_PROJECT_DESCRIPTION`

     -   HOMEPAGE_URL

         `PROJECT_HOMEPAGE_URL` `<PROJECT_NAME>_HOMEPAGE_URL`

         当`project()`从顶层调用命令时`CMakeLists.txt`，URL 也存储在变量中`CMAKE_PROJECT_HOMEPAGE_URL`

     -   LANGUAGE

     

3.   相关变量

     -   项目名

     项目名存储在`PROJECT_NAME`中，从顶层调用时还存在了`CMAKE_PROJECT_NAME`中

     -   项目源目录的绝对路径

     ```cmake
     PROJECT_SOURCE_DIR
     <PROJECT_NAME>_SOURCE_DIR
     ```

     -   项目二进制目录的绝对路径

     ```cmake
     PROJECT_BINARY_DIR
     <PROJECT_NAME>_BINARY_DIR
     ```

     -   指示项目是否为顶级的布尔值

     ```cmake
     PROJECT_IS_TOP_LEVEL
     <PROJECT_NAME>_IS_TOP_LEVEL
     ```

     

4.   代码注入

     ```cmake
     CMAKE_PROJECT_INCLUDE_BEFORE
     CMAKE_PROJECT_<PROJECT-NAME>_INCLUDE_BEFORE
     CMAKE_PROJECT_INCLUDE
     CMAKE_PROJECT_<PROJECT-NAME>_INCLUDE
     CMAKE_PROJECT_TOP_LEVEL_INCLUDES
     ```

项目的顶级`CMakeLists.txt`文件必须包含对`project()`命令的直接调用；通过加载一个`include()`命令是不够的。如果不存在这样的调用，CMake 将发出警告并假装 `project(Project)`顶部有一个以启用默认语言（`C`和`CXX`）





## configure_file

**_将文件复制到另一个位置并修改其内容_**

1.   格式

     ```cmake
     configure_file(<input> <output>
                    [NO_SOURCE_PERMISSIONS | USE_SOURCE_PERMISSIONS |
                     FILE_PERMISSIONS <permissions>...]
                    [COPYONLY] [ESCAPE_QUOTES] [@ONLY]
                    [NEWLINE_STYLE [UNIX|DOS|WIN32|LF|CRLF] ])
     ```

     `#cmakedefine`

     ```c
     #cmakedefine VAR ...
     #define VAR ...  // 如果VAR已定义（ON）
     #undef VAR		// 未定义（OFF）
     ```

     `#cmakedefine01`

     ```c
     #cmakedefine01 VAR
     #define VAR 1	// VAR已定义（ON）
     #define VAR 0	// 未定义（OFF）
     ```

     

2.   参数

     -   `<input>`

         输入文件的路径。相对路径的值相对于`CMAKE_CURRENT_SOURCE_DIR`。输入路径必须是文件，而不是目录
     -   `<output>`

         输出文件或目录的路径。相对路径的值相对于`CMAKE_CURRENT_BINARY_DIR`。如果路径命名现有目录，则输出文件将放置在该目录中，文件名与输入文件相同。如果路径包含不存在的目录，则会创建它们
     -   `NO_SOURCE_PERMISSIONS`

         不要将输入文件的权限转移到输出文件。复制的文件权限默认为标准 644 值 (-rw-r--r--)
     -   `USE_SOURCE_PERMISSIONS`

         将输入文件的权限转移到输出文件
     -   `FILE_PERMISSIONS <permissions>...`

         忽略输入文件的权限并使用`<permissions>` 为输出文件指定的权限
     -   `COPYONLY`

         复制文件而不替换任何变量引用或其他内容
     -   `ESCAPE_QUOTES`

         使用反斜杠（C 样式）转义任何替换的引号
     -   `@ONLY`

         将变量替换限制为对表单的引用`@VAR@`。这对于配置使用`${VAR}`语法的脚本很有用
     -   `NEWLINE_STYLE <style>`

         指定输出文件的换行样式

     



## set

1.   设置正常变量

     ```cmake
     set(<variable> <value>... [PARENT_SCOPE])
     ```

     -   给`variable`设定给定的值（在当前函数或目录范围内）

     -   给出`PARENT_SCOPE` 参数

         变量将设置在当前范围之上的范围内。每个新目录或函数都会创建一个新范围。此命令会将变量的值设置到父目录或调用函数中（以适用于手头的情况为准）。变量值的先前状态在当前范围内保持不变（例如，如果它之前未定义，它仍然是未定义的，如果它有一个值，它仍然是那个值）

         

2.   设置缓存条目

     ```cmake
     set(<variable> <value>... CACHE <type> <docstring> [FORCE])
     ```

     -   设置给定的缓存`<variable>`（缓存条目）。由于缓存条目旨在提供用户可设置的值，因此默认情况下不会覆盖现有的缓存条目。使用`FORCE`选项覆盖现有条目

     -   `<type>`必须指定为以下之一

         1.   `BOOL`

              布尔`ON/OFF`值

         2.   `FILEPATH`

              磁盘上文件的路径

         3.   `PATH`

              磁盘上目录的路径

         4.   `STRING`

              一行文字（如果`STRINGS`缓存条目属性已设置）

         5.   `INTERNAL`

              一行文字（它们可用于跨运行持久存储变量。使用这种类型意味着`FORCE`）

     -   `<docstring>`必须指定为一行文本

     如果在调用之前缓存条目不存在或`FORCE` 给出了选项，则缓存条目将设置为给定值

     

3.   设置环境变量

     ```cmake
     set(ENV{<variable>} [<value>])
     ```

     设置一个`Environment Variable` 到给定的值。后续调用`$ENV{<variable>}`将返回这个新值

     如果在后面没有给出参数`ENV{<variable>}`或者`<value>`是一个空字符串，那么这个命令将清除环境变量的任何现有值

     

     

## add_executable

1.  正常的可执行文件

    ```cmake
    add_executable(<name> [WIN32] [MACOSX_BUNDLE]
                   [EXCLUDE_FROM_ALL]
                   [source1] [source2 ...])
    ```

    `<name>`并且在项目中必须是全局唯一的

    

2.  导入的可执行文件

    ```cmake
    add_executable(<name> IMPORTED [GLOBAL])
    ```

    

3.  别名可执行文件

    ```cmake
    add_executable(<name> ALIAS <target>)
    ```

    



## target_include_directories

1.   格式

     ```cmake
     target_include_directories(<target> [SYSTEM] [AFTER|BEFORE]
       <INTERFACE|PUBLIC|PRIVATE> [items1...]
       [<INTERFACE|PUBLIC|PRIVATE> [items2...] ...])
     ```

     

2.   参数

     -   `<target>`必须是由命令创建的，例如`add_executable()`或者`add_library()`并且不能是 ALIAS 目标

     -   通过使用`AFTER`or`BEFORE`显式，您可以在附加和前置之间进行选择，而与默认值无关

     -    需要`INTERFACE PUBLIC PRIVATE`指定以下参数的范围

         `PRIVATE`和`PUBLIC`填充了`INCLUDE_DIRECTORIES`的`<target>`

         `INTERFACE`填充了`INTERFACE_INCLUDE_DIRECTORIES`的`<target>`

     -   如果`SYSTEM`与`PUBLIC`或`INTERFACE`一起使用，则 `INTERFACE_SYSTEM_INCLUDE_DIRECTORIES`target 属性将填充指定的目录

     



## add_library

1.  普通库

    ```cmake
    add_library(<name> [STATIC | SHARED | MODULE]
                [EXCLUDE_FROM_ALL]
                [<source>...])
    ```

    

2.  对象库

    ```cmake
    add_library(<name> OBJECT [<source>...])
    ```

    

3.  接口库

    ```cmake
    add_library(<name> INTERFACE)
    ```

    

4.  导入的库

    ```cmake
    add_library(<name> <type> IMPORTED [GLOBAL])
    ```

    

5.  别名库

    ```cmake
    add_library(<name> ALIAS <target>)
    ```





## option

```cmake
option(<variable> "<help_text>" [value])
```

如果没有`<value>`提供初始值，则布尔值`OFF`是默认值。如果`<variable>`已设置为普通或缓存变量，则该命令不执行任何操作





## if

```cmake
if(<condition>)
  <commands>
elseif(<condition>) # optional block, can be repeated
  <commands>
else()              # optional block
  <commands>
endif()
```

1.   基本表达式

     -   `if(<constant>)`

         如果常数是`1`, `ON`, `YES`, `TRUE`,`Y`或非零数（包括浮点数），则为真。False 如果常量是`0`, `OFF`, `NO`, `FALSE`, `N`, `IGNORE`, `NOTFOUND`

     -   `if(<variable>)`

         如果给定一个定义为非假常量的值的变量，则为真。否则为 False，包括变量未定义时

     -   `if(<string>)`

         带引号的字符串始终计算为 false

         

2.   逻辑运算符

     -   `NOT`	`AND`	`OR`

     

3.   存在性检查

     -   `if(COMMAND command-name)`

         如果给定名称是可以调用的命令、宏或函数，则为真

     -   `if(POLICY policy-id)`

         如果给定名称是现有策略（形式为`CMP<NNNN>`），则为真

     -   `if(TARGET target-name)`

         如果给定名称是由调用创建的现有逻辑目标名称，则为真

     -   if(TEST test-name)

         如果给定名称是由 `add_test()`命令

     -   `if(DEFINED <name>|CACHE{<name>}|ENV{<name>})`

         如果定义了给定的变量、缓存变量或环境变量，则为真`<name>`。变量的值无关紧要

         1.   宏参数不是变量
         2.   无法直接测试<name>是否为非缓存变量。如果存在缓存或非缓存变量，则表达式将评估为真。

     -   `if(<variable|string> IN_LIST <variable>)`

         如果给定元素包含在命名列表变量中，则为真

     

4.   文件操作

     -   `if(EXISTS path-to-file-or-directory)`

         如果指定的文件或目录存在，则为真

     -   `if(file1 IS_NEWER_THAN file2)`

         

     -   `if(IS_DIRECTORY path-to-directory)`

         如果给定名称是目录，则为真。行为仅针对完整路径进行了明确定义

     -   `if(IS_SYMLINK file-name)`

5.   比较

6.   版本比较

7.   路径比较

8.   变量扩展





## add_subdirectory





## list





## target_link_libraries





##  