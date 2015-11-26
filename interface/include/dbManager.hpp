#pragma once

#include "occi.h"
#include <iostream>

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
	 * Inicia conexão com o banco de dados
	 */
	void connect () throw (SQLException);
	/**
	 * Finaliza conexão com o banco de dados
	 */
	void disconnect ();
	/**
	 * Dtor, fecha conexão (se existir)
	 */
	~dbManager ();

	/**
	 * Select de teste
	 */
	vector<vector<string>> select (const string & sel, const string & from);
	/**
	 * Imprime tabela `name' e seus campos
	 */
	int printTableMetaData (const char *tableName);

	/**
	 * Pega as colunas 
	 */
	vector<string> getTableColumns (const char *tableName, int idx);

private:
	/// Nosso ambiente OCCI
	Environment *env {nullptr};
	/// Conexão com o BD
	Connection *conn {nullptr};
};

