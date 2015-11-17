objs = dbManager.o query.o

all : $(objs)

%.o : %.cpp
	$(CXX) -o $(BUILDDIR)/$@ -c $< $(CXXFLAGS)

