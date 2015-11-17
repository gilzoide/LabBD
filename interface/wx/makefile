objs = app.o queryLister.o

all : $(objs)

%.o : %.cpp
	$(CXX) -o $(BUILDDIR)/$@ -c $< $(CXXFLAGS)
