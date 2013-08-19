# Copyright (c) 2013 KAUST - InfoCloud Group (All Rights Reserved)
#
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following
# conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#
# Authors: Amin Allam  <amin.allam@kaust.edu.sa>,
#          Fuad Jamour <fuad.jamour@kaust.edu.sa>
#
# Current version: 1.0 (initial release)
	

# Build targets (your implementation targets should go in IMPL_O)
TEST_O=test_driver/test.o 
#IMPL_O=ref_impl/core.o

IMPL_O=./p_impl/ref_impl/word.cpp ./p_impl/ref_impl/threadspool.cpp ./p_impl/ref_impl/core.cpp ./p_impl/ref_impl/trie.cpp

USER_FLAGS=
USER_LIBS=

# Compiler flags
CC  = gcc
CXX = g++
CFLAGS=$(USER_FLAGS) -O3 -fPIC -Wall -std=gnu++0x -fopenmp -g -I. -I./. -I././p_impl -I././p_impl/ref_impl -I././p_impl/include
CXXFLAGS=$(CFLAGS)
LDFLAGS=-lpthread


# The programs that will be built
PROGRAMS=testdriver

# The name of the library that will be built
LIBRARY=core

# Build all programs
all: $(PROGRAMS)

lib: $(IMPL_O)
	$(CXX) $(CXXFLAGS) -shared -o lib$(LIBRARY).so $(IMPL_O)

testdriver: lib $(TEST_O)
	$(CXX) $(CXXFLAGS) -o testdriver $(TEST_O) ./lib$(LIBRARY).so

clean:
	rm -f $(PROGRAMS) lib$(LIBRARY).so
	find . -name '*.o' -print | xargs rm -f
