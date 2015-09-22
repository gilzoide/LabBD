# caminhos do instantclient, seja qual versão for
instantclient = $(shell ls -d instantclient_*)
instantclientSDK = $(instantclient)/sdk/include

# nome do executável, e diretório de construção
exe = main
BUILDDIR = build

objs = dbManager.o interface.o
CXX = g++
INCLUDEDIRS = -I$(instantclientSDK) $(shell wx-config --cflags)
LINKS = -L$(instantclient) -locci -lnnz11 -lclntsh $(shell wx-config --libs)
CXXFLAGS = -Wall -g -std=c++11 $(INCLUDEDIRS)

all : $(objs)
	$(CXX) -o $(BUILDDIR)/$(exe) $(foreach f, $^, $(BUILDDIR)/$f) $(CXXFLAGS) $(LINKS)

%.o : %.cpp
	$(CXX) -o $(BUILDDIR)/$@ -c $< $(CXXFLAGS)

# linka com o instantclient pra rodar
run :
	@LD_LIBRARY_PATH=$(instantclient) $(BUILDDIR)/$(exe)

.PHONY : clean
clean :
	$(RM) $(BUILDDIR)/* *~
