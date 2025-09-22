# Compiler
CXX = g++
CXXFLAGS = -std=c++23 -Wall -Wextra -Wpedantic -Wshadow -Wconversion -Wsign-conversion -Wnon-virtual-dtor -Wold-style-cast -Wcast-align -Woverloaded-virtual -Wduplicated-cond -Wduplicated-branches -Wlogical-op -Wnull-dereference -Wdouble-promotion -Wformat=2 -O2
LDFLAGS = 

 # Optional: enable AddressSanitizer / UndefinedBehaviorSanitizer for debugging
SANITIZE = -fsanitize=address,undefined -fno-omit-frame-pointer

# Target executable
TARGET = app

# Source files
SRC = main.cpp
OBJ = $(SRC:.cpp=.o)

# Default target
all: run

# Build executable
build: $(OBJ)
	$(CXX) $(CXXFLAGS) $(SANITIZE) $(OBJ) -o $(TARGET) $(LDFLAGS)

# Compile source files
%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Run the program
run: build
	./$(TARGET)

# Clean build files
clean:
	rm -f $(OBJ) $(TARGET)

# Build with sanitizers for debugging
debug: CXXFLAGS += $(SANITIZE) -g
debug: LDFLAGS += $(SANITIZE)
debug: clean build

.PHONY: all build run clean debug
