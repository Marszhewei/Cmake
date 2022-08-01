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

     

2.   参数

     -   `<input>`
     -   `<output>`
     -   `NO_SOURCE_PERMISSIONS`
     -   `USE_SOURCE_PERMISSIONS`
     -   `FILE_PERMISSIONS <permissions>...`
     -   `COPYONLY`
     -   `ESCAPE_QUOTES`
     -   `@ONLY`
     -   `NEWLINE_STYLE <style>`

3.   

-   配置一个头文件将版本号传递给源代码

    ```cmake
    configure_file(TutorialConfig.h.in TutorialConfig.h)
    ```

    

-   将该目录添加到路径列表中以搜索包含文件

    ```cmake
    target_include_directories(Tutorial PUBLIC
                               "${PROJECT_BINARY_DIR}"
                               )	# 在文件结尾
    ```



## 指定C++标准

```cmake
# specify the C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)
```



## 添加库

-   