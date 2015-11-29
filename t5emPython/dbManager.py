# coding: utf-8

import cx_Oracle

class dbManager ():
    """Nosso gerenciador de transações com o banco de dados"""
    # Infos para conexão
    ip = 'grad.icmc.usp.br'
    port = 15215
    SID = 'orcl'
    login = password = 'a8532248'
    dsn_tns = cx_Oracle.makedsn (ip, port, SID)
    # A conexão em si
    conn = None
    # As tabelas importantes para CRUD
    TABELAS_IMPORTANTES = set (('Zona', 'Secao', 'Urna', 'Pessoa'))

    def connect (self):
        """Tenta conectar com o banco de dados. Solta exceção se deu ruim"""
        try:
            self.conn = cx_Oracle.connect (self.login, self.password, self.dsn_tns)
            cur = self.conn.cursor ()
            cur.execute ('SELECT * FROM Zona')

            for attr in cur.fetchall ():
                print attr
            cur.close ()
        except cx_Oracle.DatabaseError, exc:
            raise Exception (exc.args[0].message)

    def select (self, what, fromWhat):
        """Executa um "SELECT what FROM fromWhat"
        Retorna a lista de colunas, e a lista de tuplas resultantes"""
        cur = self.conn.cursor ()
        cur.execute ('SELECT ' + what + ' FROM ' + fromWhat)
        return cur.description, cur.fetchall ()

    def insert (self, tabela, colunas, valores):
        """Executa um "INSERT INTO tabela (colunas) VALUES (valores)"""
        try:
            cur = self.conn.cursor ()
            string = 'INSERT INTO ' + tabela + ' (' + (','.join (colunas)) + ') VALUES (' + (','.join (valores)) + ')'
            cur.execute (string)
        except cx_Oracle.DatabaseError, exc:
            raise Exception (exc.args[0].message)
        

    def getTableInfo (self, tabela):
        """Retorna a lista de colunas da tabela 'tableName'"""
        cur = self.conn.cursor ()
        cur.execute ('SELECT * FROM ' + tabela)
        return cur.description

    def rollback (self):
        """Dá rollback na transação"""
        self.conn.rollback ()

    def disconnect (self):
        """Disconecta do banco de dados (se tiver conectado, claro)"""
        if self.conn:
            # commita as mudanças
            self.conn.commit ()
            self.conn.close ()
