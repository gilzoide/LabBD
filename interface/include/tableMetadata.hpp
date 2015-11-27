#pragma once

#include "occi.h"
#include <string>

using namespace std;
using namespace oracle::occi;

/// Representação em String dos tipos de dados do Oracle
const char *printType (int type);

/**
 * Classe com informações sobre colunas
 */
struct columnMetadata {
	/**
	 * Ctor
	 */
	columnMetadata (const MetaData& m);
	
	/* Atributos necessários */
	/// Nome da coluna
	string name;
	/// Tipo de dados
	int type;
	/// Precisão de NUMBERs
	int precisao;
	/// Aceita NULL?
	bool acceptNull;
};


/**
 * Classe que interpreta metadados de tabelas
 */
class tableMetadata {
public:
	/**
	 * Ctor: precisa da conexão com o BD
	 */
	tableMetadata (Connection *conn);

	vector<columnMetadata> operator() (const char *tableName);

private:
	Connection *conn;
};

