cmake_minimum_required(VERSION 3.8)
project(swagger-codegen-demo C CXX)

set(CMAKE_PREFIX_PATH ${CMAKE_PREFIX_PATH} ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/Modules/")
set(CMAKE_SKIP_INSTALL_ALL_DEPENDENCY true)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Boost REQUIRED)
find_package(cpprestsdk REQUIRED)
find_package(OpenSSL REQUIRED)

#include_directories(gen/cpp-restsdk/stargazer-open-api/map-ingest)
#add_subdirectory(gen/cpp-restsdk/stargazer-open-api/map-ingest)

# Generated SDK
set(API_SDK_DIR "gen/cpp-restsdk/stargazer-open-api/map-ingest")
file(GLOB  API_SDK_SOURCE_FILES  "${API_SDK_DIR}/*"  "${API_SDK_DIR}/api/*"  "${API_SDK_DIR}/model/*")
add_library(CppRestOpenAPIClient ${API_SDK_SOURCE_FILES})
target_include_directories(CppRestOpenAPIClient
  PUBLIC
    ${API_SDK_DIR}
    ${API_SDK_DIR}/api
    ${API_SDK_DIR}/model
)
target_link_libraries(CppRestOpenAPIClient
  PUBLIC
    cpprestsdk::cpprest
  PRIVATE
    Boost::boost
    ${Boost_LIBRARIES}
    OpenSSL::Crypto
    OpenSSL::SSL
)

add_executable (map_ingest_demo src/main.cpp)
target_link_libraries(map_ingest_demo PRIVATE
	Boost::boost
	cpprestsdk
	CppRestOpenAPIClient
)
