objs = dbManager.o query.o tableMetadata.o

all : $(objs)

%.o : %.cpp
	$(CXX) -o $(BUILDDIR)/$@ -c $< $(CXXFLAGS)

