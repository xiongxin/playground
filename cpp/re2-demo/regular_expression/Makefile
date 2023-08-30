# compiler
CC = g++
# install dir
INSTDIR = /usr/local/bin
# include dir
INCLUDE = .
# for debug
CXXFLAGS = -g -std=c++20 -c -Wall
# for release
# CFLAGS = -O -c -Wall

SOURCES = $(shell find *.cpp )
OBJECTS = $(SOURCES:.cpp=.o)
EXECUTABLE = main

all: $(OBJECTS) $(EXECUTABLE)

$(EXECUTABLE) : $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) -o $@

clean :
	-rm -f $(OBJECTS) $(EXECUTABLE)

.PHONY: all clean
