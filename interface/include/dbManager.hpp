#pragma once

#include <iostream>
#include "occi.h"

using namespace std;
using namespace oracle::occi;

// String de conexão com o BD
#define dbConnect "//grad.icmc.usp.br:15215/orcl.grad.usricmc.icmc.usp.br"

// Usuário e Senha pra conexão
#define usuarioConnect "a8532248"
#define senhaConnect usuarioConnect

class dbManager {
public:
	/**
	 * Ctor, inicia conexão
	 */
	dbManager () throw (string);
	/**
	 * Dtor, fecha conexão
	 */
	~dbManager ();

	/**
	 * Select de teste
	 */
	vector<vector<string>> select (const string & sel, const string & from);
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

