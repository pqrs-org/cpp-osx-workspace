cmake_minimum_required (VERSION 3.9)

project(workspace)

install(
  DIRECTORY
  ${CMAKE_CURRENT_LIST_DIR}/include
  ${CMAKE_CURRENT_LIST_DIR}/src
  DESTINATION
  .
)
