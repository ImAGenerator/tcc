# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/dudabosel/TCC/TCC

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/dudabosel/TCC/TCC/build

# Include any dependencies generated for this target.
include source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/compiler_depend.make

# Include the progress variables for this target.
include source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/progress.make

# Include the compile flags for this target's objects.
include source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/flags.make

source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/AnnexBread.cpp.o: source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/flags.make
source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/AnnexBread.cpp.o: ../source/Lib/DecoderLib/AnnexBread.cpp
source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/AnnexBread.cpp.o: source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/dudabosel/TCC/TCC/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/AnnexBread.cpp.o"
	cd /home/dudabosel/TCC/TCC/build/source/Lib/DecoderAnalyserLib && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/AnnexBread.cpp.o -MF CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/AnnexBread.cpp.o.d -o CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/AnnexBread.cpp.o -c /home/dudabosel/TCC/TCC/source/Lib/DecoderLib/AnnexBread.cpp

source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/AnnexBread.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/AnnexBread.cpp.i"
	cd /home/dudabosel/TCC/TCC/build/source/Lib/DecoderAnalyserLib && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/dudabosel/TCC/TCC/source/Lib/DecoderLib/AnnexBread.cpp > CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/AnnexBread.cpp.i

source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/AnnexBread.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/AnnexBread.cpp.s"
	cd /home/dudabosel/TCC/TCC/build/source/Lib/DecoderAnalyserLib && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/dudabosel/TCC/TCC/source/Lib/DecoderLib/AnnexBread.cpp -o CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/AnnexBread.cpp.s

source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/BinDecoder.cpp.o: source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/flags.make
source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/BinDecoder.cpp.o: ../source/Lib/DecoderLib/BinDecoder.cpp
source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/BinDecoder.cpp.o: source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/dudabosel/TCC/TCC/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/BinDecoder.cpp.o"
	cd /home/dudabosel/TCC/TCC/build/source/Lib/DecoderAnalyserLib && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/BinDecoder.cpp.o -MF CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/BinDecoder.cpp.o.d -o CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/BinDecoder.cpp.o -c /home/dudabosel/TCC/TCC/source/Lib/DecoderLib/BinDecoder.cpp

source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/BinDecoder.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/BinDecoder.cpp.i"
	cd /home/dudabosel/TCC/TCC/build/source/Lib/DecoderAnalyserLib && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/dudabosel/TCC/TCC/source/Lib/DecoderLib/BinDecoder.cpp > CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/BinDecoder.cpp.i

source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/BinDecoder.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/BinDecoder.cpp.s"
	cd /home/dudabosel/TCC/TCC/build/source/Lib/DecoderAnalyserLib && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/dudabosel/TCC/TCC/source/Lib/DecoderLib/BinDecoder.cpp -o CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/BinDecoder.cpp.s

source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/CABACReader.cpp.o: source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/flags.make
source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/CABACReader.cpp.o: ../source/Lib/DecoderLib/CABACReader.cpp
source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/CABACReader.cpp.o: source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/dudabosel/TCC/TCC/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/CABACReader.cpp.o"
	cd /home/dudabosel/TCC/TCC/build/source/Lib/DecoderAnalyserLib && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/CABACReader.cpp.o -MF CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/CABACReader.cpp.o.d -o CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/CABACReader.cpp.o -c /home/dudabosel/TCC/TCC/source/Lib/DecoderLib/CABACReader.cpp

source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/CABACReader.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/CABACReader.cpp.i"
	cd /home/dudabosel/TCC/TCC/build/source/Lib/DecoderAnalyserLib && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/dudabosel/TCC/TCC/source/Lib/DecoderLib/CABACReader.cpp > CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/CABACReader.cpp.i

source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/CABACReader.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/CABACReader.cpp.s"
	cd /home/dudabosel/TCC/TCC/build/source/Lib/DecoderAnalyserLib && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/dudabosel/TCC/TCC/source/Lib/DecoderLib/CABACReader.cpp -o CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/CABACReader.cpp.s

source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecCu.cpp.o: source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/flags.make
source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecCu.cpp.o: ../source/Lib/DecoderLib/DecCu.cpp
source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecCu.cpp.o: source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/dudabosel/TCC/TCC/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecCu.cpp.o"
	cd /home/dudabosel/TCC/TCC/build/source/Lib/DecoderAnalyserLib && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecCu.cpp.o -MF CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecCu.cpp.o.d -o CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecCu.cpp.o -c /home/dudabosel/TCC/TCC/source/Lib/DecoderLib/DecCu.cpp

source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecCu.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecCu.cpp.i"
	cd /home/dudabosel/TCC/TCC/build/source/Lib/DecoderAnalyserLib && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/dudabosel/TCC/TCC/source/Lib/DecoderLib/DecCu.cpp > CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecCu.cpp.i

source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecCu.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecCu.cpp.s"
	cd /home/dudabosel/TCC/TCC/build/source/Lib/DecoderAnalyserLib && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/dudabosel/TCC/TCC/source/Lib/DecoderLib/DecCu.cpp -o CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecCu.cpp.s

source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecLib.cpp.o: source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/flags.make
source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecLib.cpp.o: ../source/Lib/DecoderLib/DecLib.cpp
source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecLib.cpp.o: source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/dudabosel/TCC/TCC/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building CXX object source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecLib.cpp.o"
	cd /home/dudabosel/TCC/TCC/build/source/Lib/DecoderAnalyserLib && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecLib.cpp.o -MF CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecLib.cpp.o.d -o CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecLib.cpp.o -c /home/dudabosel/TCC/TCC/source/Lib/DecoderLib/DecLib.cpp

source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecLib.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecLib.cpp.i"
	cd /home/dudabosel/TCC/TCC/build/source/Lib/DecoderAnalyserLib && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/dudabosel/TCC/TCC/source/Lib/DecoderLib/DecLib.cpp > CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecLib.cpp.i

source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecLib.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecLib.cpp.s"
	cd /home/dudabosel/TCC/TCC/build/source/Lib/DecoderAnalyserLib && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/dudabosel/TCC/TCC/source/Lib/DecoderLib/DecLib.cpp -o CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecLib.cpp.s

source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecSlice.cpp.o: source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/flags.make
source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecSlice.cpp.o: ../source/Lib/DecoderLib/DecSlice.cpp
source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecSlice.cpp.o: source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/dudabosel/TCC/TCC/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Building CXX object source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecSlice.cpp.o"
	cd /home/dudabosel/TCC/TCC/build/source/Lib/DecoderAnalyserLib && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecSlice.cpp.o -MF CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecSlice.cpp.o.d -o CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecSlice.cpp.o -c /home/dudabosel/TCC/TCC/source/Lib/DecoderLib/DecSlice.cpp

source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecSlice.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecSlice.cpp.i"
	cd /home/dudabosel/TCC/TCC/build/source/Lib/DecoderAnalyserLib && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/dudabosel/TCC/TCC/source/Lib/DecoderLib/DecSlice.cpp > CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecSlice.cpp.i

source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecSlice.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecSlice.cpp.s"
	cd /home/dudabosel/TCC/TCC/build/source/Lib/DecoderAnalyserLib && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/dudabosel/TCC/TCC/source/Lib/DecoderLib/DecSlice.cpp -o CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecSlice.cpp.s

source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/NALread.cpp.o: source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/flags.make
source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/NALread.cpp.o: ../source/Lib/DecoderLib/NALread.cpp
source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/NALread.cpp.o: source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/dudabosel/TCC/TCC/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "Building CXX object source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/NALread.cpp.o"
	cd /home/dudabosel/TCC/TCC/build/source/Lib/DecoderAnalyserLib && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/NALread.cpp.o -MF CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/NALread.cpp.o.d -o CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/NALread.cpp.o -c /home/dudabosel/TCC/TCC/source/Lib/DecoderLib/NALread.cpp

source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/NALread.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/NALread.cpp.i"
	cd /home/dudabosel/TCC/TCC/build/source/Lib/DecoderAnalyserLib && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/dudabosel/TCC/TCC/source/Lib/DecoderLib/NALread.cpp > CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/NALread.cpp.i

source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/NALread.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/NALread.cpp.s"
	cd /home/dudabosel/TCC/TCC/build/source/Lib/DecoderAnalyserLib && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/dudabosel/TCC/TCC/source/Lib/DecoderLib/NALread.cpp -o CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/NALread.cpp.s

source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/SEIread.cpp.o: source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/flags.make
source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/SEIread.cpp.o: ../source/Lib/DecoderLib/SEIread.cpp
source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/SEIread.cpp.o: source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/dudabosel/TCC/TCC/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_8) "Building CXX object source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/SEIread.cpp.o"
	cd /home/dudabosel/TCC/TCC/build/source/Lib/DecoderAnalyserLib && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/SEIread.cpp.o -MF CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/SEIread.cpp.o.d -o CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/SEIread.cpp.o -c /home/dudabosel/TCC/TCC/source/Lib/DecoderLib/SEIread.cpp

source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/SEIread.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/SEIread.cpp.i"
	cd /home/dudabosel/TCC/TCC/build/source/Lib/DecoderAnalyserLib && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/dudabosel/TCC/TCC/source/Lib/DecoderLib/SEIread.cpp > CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/SEIread.cpp.i

source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/SEIread.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/SEIread.cpp.s"
	cd /home/dudabosel/TCC/TCC/build/source/Lib/DecoderAnalyserLib && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/dudabosel/TCC/TCC/source/Lib/DecoderLib/SEIread.cpp -o CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/SEIread.cpp.s

source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/VLCReader.cpp.o: source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/flags.make
source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/VLCReader.cpp.o: ../source/Lib/DecoderLib/VLCReader.cpp
source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/VLCReader.cpp.o: source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/dudabosel/TCC/TCC/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_9) "Building CXX object source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/VLCReader.cpp.o"
	cd /home/dudabosel/TCC/TCC/build/source/Lib/DecoderAnalyserLib && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/VLCReader.cpp.o -MF CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/VLCReader.cpp.o.d -o CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/VLCReader.cpp.o -c /home/dudabosel/TCC/TCC/source/Lib/DecoderLib/VLCReader.cpp

source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/VLCReader.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/VLCReader.cpp.i"
	cd /home/dudabosel/TCC/TCC/build/source/Lib/DecoderAnalyserLib && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/dudabosel/TCC/TCC/source/Lib/DecoderLib/VLCReader.cpp > CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/VLCReader.cpp.i

source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/VLCReader.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/VLCReader.cpp.s"
	cd /home/dudabosel/TCC/TCC/build/source/Lib/DecoderAnalyserLib && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/dudabosel/TCC/TCC/source/Lib/DecoderLib/VLCReader.cpp -o CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/VLCReader.cpp.s

# Object files for target DecoderAnalyserLib
DecoderAnalyserLib_OBJECTS = \
"CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/AnnexBread.cpp.o" \
"CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/BinDecoder.cpp.o" \
"CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/CABACReader.cpp.o" \
"CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecCu.cpp.o" \
"CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecLib.cpp.o" \
"CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecSlice.cpp.o" \
"CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/NALread.cpp.o" \
"CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/SEIread.cpp.o" \
"CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/VLCReader.cpp.o"

# External object files for target DecoderAnalyserLib
DecoderAnalyserLib_EXTERNAL_OBJECTS =

../lib/umake/gcc-11.3/x86_64/release/libDecoderAnalyserLib.a: source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/AnnexBread.cpp.o
../lib/umake/gcc-11.3/x86_64/release/libDecoderAnalyserLib.a: source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/BinDecoder.cpp.o
../lib/umake/gcc-11.3/x86_64/release/libDecoderAnalyserLib.a: source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/CABACReader.cpp.o
../lib/umake/gcc-11.3/x86_64/release/libDecoderAnalyserLib.a: source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecCu.cpp.o
../lib/umake/gcc-11.3/x86_64/release/libDecoderAnalyserLib.a: source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecLib.cpp.o
../lib/umake/gcc-11.3/x86_64/release/libDecoderAnalyserLib.a: source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/DecSlice.cpp.o
../lib/umake/gcc-11.3/x86_64/release/libDecoderAnalyserLib.a: source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/NALread.cpp.o
../lib/umake/gcc-11.3/x86_64/release/libDecoderAnalyserLib.a: source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/SEIread.cpp.o
../lib/umake/gcc-11.3/x86_64/release/libDecoderAnalyserLib.a: source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/__/DecoderLib/VLCReader.cpp.o
../lib/umake/gcc-11.3/x86_64/release/libDecoderAnalyserLib.a: source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/build.make
../lib/umake/gcc-11.3/x86_64/release/libDecoderAnalyserLib.a: source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/dudabosel/TCC/TCC/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_10) "Linking CXX static library ../../../../lib/umake/gcc-11.3/x86_64/release/libDecoderAnalyserLib.a"
	cd /home/dudabosel/TCC/TCC/build/source/Lib/DecoderAnalyserLib && $(CMAKE_COMMAND) -P CMakeFiles/DecoderAnalyserLib.dir/cmake_clean_target.cmake
	cd /home/dudabosel/TCC/TCC/build/source/Lib/DecoderAnalyserLib && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/DecoderAnalyserLib.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/build: ../lib/umake/gcc-11.3/x86_64/release/libDecoderAnalyserLib.a
.PHONY : source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/build

source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/clean:
	cd /home/dudabosel/TCC/TCC/build/source/Lib/DecoderAnalyserLib && $(CMAKE_COMMAND) -P CMakeFiles/DecoderAnalyserLib.dir/cmake_clean.cmake
.PHONY : source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/clean

source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/depend:
	cd /home/dudabosel/TCC/TCC/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/dudabosel/TCC/TCC /home/dudabosel/TCC/TCC/source/Lib/DecoderAnalyserLib /home/dudabosel/TCC/TCC/build /home/dudabosel/TCC/TCC/build/source/Lib/DecoderAnalyserLib /home/dudabosel/TCC/TCC/build/source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : source/Lib/DecoderAnalyserLib/CMakeFiles/DecoderAnalyserLib.dir/depend

