cmake_minimum_required(VERSION 3.16)

project(sonegx_player VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick REQUIRED)

find_package(Qt6 6.2 COMPONENTS QuickControls2 REQUIRED)
qt_add_resources( MY_RESOURCE qml.qrc

)
qt_add_resources( MY_RESOURCE2 images.qrc

)
qt_add_executable(appsonegx_player
    main.cpp
    jsonfile.cpp
    jsonfile.h
   ${MY_RESOURCE}
   ${MY_RESOURCE2}
)

qt_add_qml_module(appsonegx_player
    URI sonegx_player
    VERSION 1.0
)

set_target_properties(appsonegx_player PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appsonegx_player
    PRIVATE Qt6::Quick Qt6::QuickControls2)

install(TARGETS appsonegx_player
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
