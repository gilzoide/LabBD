#include "tableMetadata.hpp"

// Method which prints the data type
// Taken from OCCI docs
const char *printType (int type) {
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



tableMetadata::tableMetadata (Connection *conn) : conn (conn) {}

vector<columnMetadata> tableMetadata::operator() (const char *tableName) {
	vector<columnMetadata> ret;

	auto meta = conn->getMetaData (tableName);
	// se não é Table, nem preocupa
	if (meta.getInt (MetaData::ATTR_PTYPE) == MetaData::PTYPE_TABLE) {
		auto columns = meta.getVector (MetaData::ATTR_LIST_COLUMNS);
		for (auto c : columns) {
			ret.push_back (move (columnMetadata (c)));
		}
	}

	return ret;
}


/* Colunas */
columnMetadata::columnMetadata (const MetaData& m) {
	name = m.getString (MetaData::ATTR_NAME);
	type = m.getInt (MetaData::ATTR_DATA_TYPE);
	acceptNull = m.getBoolean (MetaData::ATTR_IS_NULL);
}
