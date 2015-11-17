#pragma once

#include "occi.h"

using namespace oracle::occi;

class selectIterator {
public:
	selectIterator (ResultSet *queryRes);
	bool next ();
	ResultSet *& operator* ();
private:
	ResultSet *res;
	
};
