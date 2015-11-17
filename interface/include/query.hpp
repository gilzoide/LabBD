#pragma once

#include "occi.h"
#include <string>

using namespace std;
using namespace oracle::occi;

class query {
public:
	/**
	 * Ctor: precisa da conexão com o BD
	 */
	query (Connection *conn);

	/**
	 * Executa um select: "SELECT $select FROM $from"
	 *
	 * @param[in] select O que selecionar?
	 * @param[in] from Selecionar daonde?
	 *
	 * @return Tabela de resultados, com os nomes das colunas na posição 0
	 * e as linhas a partir da posição 1
	 */
	vector<vector<string>> operator() (const string & select, const string & from);

private:
	Connection *conn;
};
