#include "dbManager.hpp"
#include "query.hpp"
#include "tableMetadata.hpp"


void dbManager::connect () throw (SQLException) {
	cout << "Usando OCCI versão " << OCCI_MAJOR_VERSION << '.' << OCCI_MINOR_VERSION << endl;

	try {
		// ambiente Oracle
		env = Environment::createEnvironment ();
		// Conecta, por favor
		conn = env->createConnection (usuarioConnect, senhaConnect, dbConnect);
		cout << "Conectado!" << endl;
	}
	catch (SQLException e) {
		throw;
	}
}


void dbManager::disconnect () {
	if (env) {
		env->terminateConnection (conn);
		Environment::terminateEnvironment (env);
		env = nullptr;
	}
}


dbManager::~dbManager () {
	// termina conexão, porque dizem que precisa (pq n usar destrutor, mô deus!)
	disconnect ();
}


vector<vector<string>> dbManager::select (const string & sel, const string & from) {
	query q (conn);
	return move (q (sel, from));
}


int dbManager::printTableMetaData (const char *tableName) {
	tableMetadata T (conn);
	auto columns = T (tableName);
	for (auto & c : columns) {
		cout << "  Column name: " << c.name << endl;
		cout << "    Data Type: " << printType (c.type) << endl;
		if (c.acceptNull) {
			cout << "    Allows null" << endl;
		}
		else {
			cout << "    Does not allow null" << endl;
		}
	}

	return 1;
}


vector<string> dbManager::getTableColumns (const char *tableName, int idx) {
	auto stmt = conn->createStatement();
	auto resultado = stmt->executeQuery ("SELECT * FROM " + string (tableName));

	vector<string> vec;
	while (resultado->next ()) {
		vec.push_back (resultado->getString (idx));
	}

	return move (vec);
}
