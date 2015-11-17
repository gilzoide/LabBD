#include "query.hpp"
#include <iostream>

query::query (Connection *conn) : conn (conn) {}


vector<vector<string>> query::operator() (const string & select, const string & from) {
	// nosso resultado
	vector<vector<string>> ret;
	try {
		auto stmt = conn->createStatement ();

		// executa o select
		auto resultado = stmt->executeQuery ("SELECT " + select + " FROM " + from);

		// primeiro, descobre quantas colunas têm...
		auto metas = resultado->getColumnListMetaData ();
		int columnNumber = metas.size ();
		// ...e quais os nomes das colunas
		vector<string> colunas;
		for (auto & meta : metas) {
			colunas.push_back (meta.getString (MetaData::ATTR_NAME));
		}
		ret.push_back (move (colunas));

		// agora, adiciona os resultados
		while (resultado->next ()) {
			vector<string> row;
			for (int i = 1; i <= columnNumber; i++) {
				row.push_back (resultado->getString (i));
			}
			ret.push_back (move (row));
		}

		conn->terminateStatement (stmt);
	}
	catch (SQLException e) {
		cout << "Erro na query: " << e.what ();
		ret.push_back ({""});
	}

	return move (ret);
}
