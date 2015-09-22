#include "dbManager.hpp"


dbManager::dbManager () {
	cout << "Usando Oracle versão " << OCCI_MAJOR_VERSION << '.' << OCCI_MINOR_VERSION << endl << endl;

	// ambiente Oracle
	env = Environment::createEnvironment ();

	try {
		// Conecta, por favor
		conn = env->createConnection (usuarioConnect, senhaConnect, dbConnect);
	}
	catch (SQLException e) {
		cout << "FALHOU AO CONECTAR: " << e.what ();
		conn = nullptr;
	}
}


dbManager::~dbManager () {
	// termina conexão, porque dizem que precisa (pq n usar destrutor, mô deus!)
	env->terminateConnection (conn);
}


// Method which prints the data type
// Taken from OCCI docs
const char *printType (int type)
{
	switch (type) {
		case OCCI_SQLT_CHR : 	return "VARCHAR2";			break;
		case OCCI_SQLT_NUM : 	return "NUMBER";			break;
		case OCCIINT : 			return "INTEGER";			break;
		case OCCIFLOAT : 		return "FLOAT";				break;
		case OCCI_SQLT_STR : 	return "STRING";			break;
		case OCCI_SQLT_VNU : 	return "VARNUM";			break;
		case OCCI_SQLT_LNG : 	return "LONG";				break;
		case OCCI_SQLT_VCS : 	return "VARCHAR";			break;
		case OCCI_SQLT_RID : 	return "ROWID";				break;
		case OCCI_SQLT_DAT : 	return "DATE";				break;
		case OCCI_SQLT_VBI : 	return "VARRAW";			break;
		case OCCI_SQLT_BIN : 	return "RAW";				break;
		case OCCI_SQLT_LBI : 	return "LONG RAW";			break;
		case OCCIUNSIGNED_INT : return "UNSIGNED INT";		break;
		case OCCI_SQLT_LVC : 	return "LONG VARCHAR";		break;
		case OCCI_SQLT_LVB : 	return "LONG VARRAW";		break;
		case OCCI_SQLT_AFC : 	return "CHAR";				break;
		case OCCI_SQLT_AVC : 	return "CHARZ";				break;
		case OCCI_SQLT_RDD : 	return "ROWID";				break;
		case OCCI_SQLT_NTY : 	return "NAMED DATA TYPE";	break;
		case OCCI_SQLT_REF : 	return "REF";				break;
		case OCCI_SQLT_CLOB: 	return "CLOB";				break;
		case OCCI_SQLT_BLOB: 	return "BLOB";				break;
		case OCCI_SQLT_FILE:	return "BFILE";				break;
	}

	return "";
}


void dbManager::select () {
	// dá um select ae
	auto stmt = conn->createStatement();
	auto resultado = stmt->executeQuery ("SELECT * FROM Zona");

	// e escreve os resultados
	cout << "Listando Zonas existentes" << endl;
	cout << "-------------------------" << endl;
	while (resultado->next ()) {
		cout << resultado->getInt (1) << " -> " << "localizado em: " <<
				resultado->getString (3) << '\t' << resultado->getString (2) <<
				'\t' << resultado->getInt (4) << " eleitores" << endl;
	}
	conn->terminateStatement (stmt);
}


int dbManager::printTableMetaData (const char *table_name) {
	auto meta = conn->getMetaData (table_name);
	// se não é Table, nem preocupa
	if (meta.getInt (MetaData::ATTR_PTYPE) != MetaData::PTYPE_TABLE) {
		return 0;
	}

	cout << "Table name: " << meta.getString (MetaData::ATTR_OBJ_NAME) << endl;

	auto columns = meta.getVector (MetaData::ATTR_LIST_COLUMNS);
	for (auto c : columns) {
		cout << "  Column name: " << c.getString (MetaData::ATTR_NAME) << endl;
		cout << "    Data Type: " << printType (c.getInt(MetaData::ATTR_DATA_TYPE)) << endl;
		cout << "    Size : " << c.getInt (MetaData::ATTR_DATA_SIZE) << endl;
		cout << "    Precision : " << c.getInt (MetaData::ATTR_PRECISION) << endl;
		cout << "    Scale : " << c.getInt (MetaData::ATTR_SCALE) << endl;
		bool isnull = c.getBoolean (MetaData::ATTR_IS_NULL);
		if (isnull) {
			cout << "    Allows null" << endl;
		}
		else {
			cout << "    Does not allow null" << endl;
		}
	}

	return 1;
}


vector<string> dbManager::getTableColumns (const char *table_name, int idx) {
	auto meta = conn->getMetaData (table_name);
	

	auto stmt = conn->createStatement();
	auto resultado = stmt->executeQuery ("SELECT * FROM " + string (table_name));

	vector<string> vec;
	while (resultado->next ()) {
		vec.push_back (resultado->getString (idx));
	}
	return move (vec);
}
