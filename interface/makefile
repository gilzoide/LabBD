# caminhos do instantclient, seja qual versão for
instantclient = $(shell ls -d instantclient_*)
instantclientSDK = $(instantclient)/sdk/include

# nome do executável, e diretório de construção
exe = main
export BUILDDIR = $(CURDIR)/build

export CXX = g++
export INCLUDEDIRS = -I$(CURDIR)/$(instantclientSDK) $(shell wx-config --cflags) -I$(CURDIR)/include
export LINKS = -L$(instantclient) -locci -lnnz11 -lclntsh $(shell wx-config --libs)
export CXXFLAGS = -Wall -Wno-deprecated-declarations -g -std=c++11 $(INCLUDEDIRS)

all :
	$(MAKE) -C wx
	$(MAKE) -C db
	$(CXX) -o $(BUILDDIR)/$(exe) $(BUILDDIR)/*.o $(CXXFLAGS) $(LINKS)

# linka com o instantclient pra rodar
run :
	@LD_LIBRARY_PATH=$(instantclient) $(BUILDDIR)/$(exe)

.PHONY : clean
clean :
	$(RM) $(BUILDDIR)/* *~
