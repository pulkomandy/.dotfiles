cmake_minimum_required (VERSION 3.13)

# projectname is the same as the main-executable
project(%HERE%%FDIR%)

# Export compile_commands.json (useful for autocompletion in IDE and other tools)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Set some sane compiler flags
set(CFLAGS
	-O2 # Optimizations are enabled
	-g  # Debug information is included in the executable
	-Wall -Werror # Good set of warnings, all triggering compilation errors
	-fsanitize=address -fsanitize=undefined # Check for invalid pointers and other problems at runtime (with good error messages instead of crashing, but there is a performance cost)
	-fstack-protector-strong # Detect stack overflows and other stack corruption problems
	-std=gnu17 # Use the current version of the C language, with the GNU extensions
)
add_definitions(${CFLAGS})
add_link_options(${CFLAGS})

add_executable(${PROJECT_NAME} ${PROJECT_NAME}.cpp)
