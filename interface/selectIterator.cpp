#include "selectIterator.hpp"

selectIterator::selectIterator (ResultSet *queryRes) : res (queryRes) {}

bool selectIterator::next () {
	return res->next ();
}

ResultSet *& selectIterator::operator* () {
	return res;
}
