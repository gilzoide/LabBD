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
	 * Ctor, inicia conexão
	 */
	dbManager ();
	/**
	 * Dtor, fecha conexão
	 */
	~dbManager ();

	/**
	 * Select de teste
	 */
	void select ();
	/**
	 * Imprime tabela `name' e seus campos
	 */
	int printTableMetaData (const char *table_name);

	/**
	 * Pega as colunas 
	 */
	vector<string> getTableColumns (const char *table_name, int idx);
private:
	/// Nosso ambiente OCCI
	Environment *env;
	/// Conexão com o BD
	Connection *conn;
};

