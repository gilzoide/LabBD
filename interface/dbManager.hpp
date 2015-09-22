#pragma once

#include <iostream>
#include "occi.h"

using namespace std;
using namespace oracle::occi;

// String de conexão com o BD
#define dbConnect \
"(DESCRIPTION =						\
	(ADDRESS =						\
		(PROTOCOL = tcp) 			\
		(HOST = grad.icmc.usp.br)	\
		(PORT = 15215))				\
	(CONNECT_DATA = (SID = orcl))	\
)"

// Usuário e Senha pra conexão
#define usuarioConnect "a8532248"
#define senhaConnect usuarioConnect

class dbManager {
public:
	/**
	 * 
	 */
	dbManager ();
	/**
	 * Dtor, fecha conexão
	 */
	~dbManager ();

	void select ();
	int printTableMetaData (const char *name);
private:
	Environment *env;
	Connection *conn;
};

