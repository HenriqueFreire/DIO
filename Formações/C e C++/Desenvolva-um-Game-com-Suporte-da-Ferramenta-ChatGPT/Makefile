# Compiler and flags
CXX = g++
# Using C++17 standard, enabling all warnings, and adding debug symbols
CXXFLAGS = -std=c++17 -Wall -g
# Using pkg-config to get linker flags for libcurl
LDFLAGS = $(shell pkg-config --libs libcurl)

# Project files
TARGET = quiz_game
SOURCES = main.cpp Quiz.cpp ApiAssistant.cpp
OBJECTS = $(SOURCES:.cpp=.o)

# Default target to build the executable
all: $(TARGET)

# Linking rule
$(TARGET): $(OBJECTS)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(OBJECTS) $(LDFLAGS)

# Compilation rule for .cpp files
%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Rule to clean up generated files
clean:
	rm -f $(TARGET) $(OBJECTS)

# Phony targets are not real files
.PHONY: all clean
