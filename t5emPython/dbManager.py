# coding: utf-8

import cx_Oracle

# utf-8!
import os
os.environ['NLS_LANG'] = "PORTUGUESE_BRAZIL.AL32UTF8"

class fk ():
    """Classe que descreve uma relação de parentesco entre chaves: Foreign Keys"""
    def __init__ (self, tabelaPai, chaves, descricao):
        self.tabela = tabelaPai
        self.chaves = chaves
        self.descricao = descricao

    def getKeys (self):
        db = dbManager.getDbManager ()
        _, valores = db.select (','.join (self.chaves), self.tabela)
        return map (lambda tupla : ', '.join (map (str, tupla)), valores)

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
    TABELAS_IMPORTANTES = ('Zona', 'Secao', 'Urna', 'Pessoa', 'Filia', 'Partido',
            'Funcionario', 'Candidato', 'EhViceDe', 'VotoCandidato', 'VotoPartido')

    RESTRICOES = {
                'Zona' : {
                    'NROZONA' : 'seq',
                    'ESTADOZONA' : 'pk',
                    'QTDELEITORESZ' : 'ignore',
                },
                'Secao' : {
                    'NROZONA' : 0,
                    'ESTADOZONA' : 0,
                    'NROSECAO' : 'seq',
                    'QTDELEITORESS' : 'ignore',
                    'fks' : [fk ('Zona', ['NROZONA', 'ESTADOZONA'], 'Zona correspondente')],
                },
                'Urna' : {
                    'NROZONA' : 0,
                    'ESTADOZONA' : 0,
                    'NROSECAO' : 0,
                    'NROURNA' : 'seq',
                    'TIPOURNA' : ('manual', 'eletronica'),
                    'fks' : [fk ('Secao', ['NROZONA', 'ESTADOZONA', 'NROSECAO'], 'Seção correspondente')]
                },
                'Pessoa' : {
                    'NROTITELEITOR' : 'pk',
                    'NROZONA' : 0,
                    'ESTADOZONA' : 0,
                    'NROSECAO' : 0,
                    'TIPOPESSOA' : 'ignore',
                    'fks' : [fk ('Secao', ['NROZONA', 'ESTADOZONA', 'NROSECAO'], 'Seção de votação')],
                },
                'Filia' : {
                    'NROTITELEITOR' : 0,
                    'NROPARTIDO' : 1,
                    'fks' : [fk ('Pessoa', ['NROTITELEITOR'], 'Eleitor'), fk ('Partido', ['NROPARTIDO'], 'Partido filiado')]
                },
                'Partido' : {
                    'NROPARTIDO' : 'seq',
                    'NROVOTOSP' : 'ignore',
                },
                'Candidato' : {
                    'NROTITELEITOR' : 0,
                    'CARGOCANDIDATO' : ('presidente', 'vice-presidente', 'governador',
                        'vice-governador', 'prefeito', 'vice-prefeito', 'vereador'),
                    'fks' : [fk ('Pessoa', ['NROTITELEITOR'], 'Pessoa correspondente')]
                },
                'Funcionario' : {
                    'NROTITELEITOR' : 0,
                    'CARGOFUNC' : ('mesario','presidente','secretario','suplente'),
                    'NROZONA' : 1,
                    'ESTADOZONA' : 1,
                    'NROSECAO' : 1,
                    'fks' : [fk ('Pessoa', ['NROTITELEITOR'], 'Pessoa correspondente'), fk ('Secao', ['NROZONA', 'ESTADOZONA', 'NROSECAO'], 'Seção de trabalho')]
                },
                'EhViceDe' : {
                    'NROTITELEITORPRINCIPAL' : 0,
                    'NROTITELEITORVICE' : 1,
                    'fks' : [fk ('Candidato', ['NROTITELEITOR'], 'Candidato principal'), fk ('Candidato', ['NROTITELEITOR'], 'Candidato vice')]
                },
                'VotoCandidato' : {
                    'NROTITELEITOR' : 0,
                    'NROZONA' : 1,
                    'ESTADOZONA' : 1,
                    'NROSECAO' : 1,
                    'NROURNA' : 1,
                    'IDVOTOC' : 'seq',
                    'fks' : [fk ('Candidato', ['NROTITELEITOR'], 'Candidato votado'), fk ('Urna', ['NROZONA', 'ESTADOZONA', 'NROSECAO', 'NROURNA'], 'Urna utilizada')]
                },
                'VotoPartido' : {
                    'NROPARTIDO' : 0,
                    'NROZONA' : 1,
                    'ESTADOZONA' : 1,
                    'NROSECAO' : 1,
                    'NROURNA' : 1,
                    'IDVOTOP' : 'seq',
                    'fks' : [fk ('Partido', ['NROPARTIDO'], 'Partido votado'), fk ('Urna', ['NROZONA', 'ESTADOZONA', 'NROSECAO', 'NROURNA'], 'Urna utilizada')]

                },
            }

    # A instância única, Singleton
    instance = None

    @staticmethod
    def getDbManager ():
        # Singleton! Só cria se for a primeira
        if not dbManager.instance:
            dbManager.instance = dbManager ()
        return dbManager.instance

    def connect (self):
        """Tenta conectar com o banco de dados. Solta exceção se deu ruim"""
        try:
            self.conn = cx_Oracle.connect (self.login, self.password, self.dsn_tns)
            # ativa output
            cur = self.conn.cursor ()
            cur.callproc ('dbms_output.enable', [99999999])
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

    def delete (self, tabela, colunas, valores):
        """Executa um "DELETE FROM tabela WHERE where"""
        try:
            cur = self.conn.cursor ()
            # conjunto de condições 'ATTR_NAME = valor'
            condicoes = []
            for i, c in enumerate (colunas):
                # se número, só vira string
                if c[1] is cx_Oracle.NUMBER:
                    valor = str (valores[i])
                # strings: põe aspas
                else:
                    valor = "'" + valores[i] + "'"
                condicoes.append (c[0] + ' = ' + valor)
            string = 'DELETE FROM ' + tabela + ' WHERE ' + (' AND '.join (condicoes))
            cur.execute (string)
        except cx_Oracle.DatabaseError, exc:
            raise Exception (exc.args[0].message)

    def update (self, tabela, colunasAtualiza, valoresAtualiza, colunasRestricao, valoresRestricao):
        """Executa um 'UPDATE tabela SET atualizacoes WHERE restricoes'"""
        if len (colunasAtualiza):
            try:
                cur = self.conn.cursor ()

                # conjunto de valores a serem atualizados
                atualizacoes = []
                for i, c in enumerate (colunasAtualiza):
                    atualizacoes.append (c[0] + ' = ' + valoresAtualiza[i])

                # conjunto de condições 'ATTR_NAME = valor'
                condicoes = []
                for i, c in enumerate (colunasRestricao):
                    if not valoresRestricao[i] is None:
                        # se número, só vira string
                        if c[1] is cx_Oracle.NUMBER:
                            valor = str (valoresRestricao[i])
                        elif c[1] is cx_Oracle.DATETIME:
                            valor = "TO_DATE ('" + valoresRestricao[i].date ().isoformat () + "', 'yyyy-mm-dd')"
                        # strings: põe aspas
                        else:
                            valor = "'" + valoresRestricao[i] + "'"
                        condicoes.append (c[0] + ' = ' + valor)

                #print 'atualizações:', atualizacoes, 'condições:', condicoes
                string = 'UPDATE ' + tabela + ' SET ' + (','.join (atualizacoes)) + ' WHERE ' + (' AND '.join (condicoes))
                cur.execute (string)
            except cx_Oracle.DatabaseError, exc:
                raise Exception (exc.args[0].message)

    def procedure (self, proc, args):
        """Executa uma procedure, pos relatório e pá"""
        cur = self.conn.cursor ()
        cur.callproc (proc, args)
        s = ' ' * 1000
        n = 0
        strs = []
        while not n:
            s, n = cur.callproc ('DBMS_OUTPUT.GET_LINE', (s, n))
            strs.append (s)
        return '\n'.join (strs[:-1])

    def getTableInfo (self, tabela):
        """Retorna a lista de colunas da tabela 'tableName'"""
        cur = self.conn.cursor ()
        cur.execute ('SELECT * FROM ' + tabela)
        return cur.description

    def rollback (self):
        """Dá rollback na transação"""
        self.conn.rollback ()

    def disconnect (self, shouldCommit):
        """Disconecta do banco de dados (se tiver conectado, claro)"""
        if self.conn:
            # commita as mudanças, se pediu
            if shouldCommit:
                self.conn.commit ()
            self.conn.close ()
