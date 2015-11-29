# coding: utf-8

import cx_Oracle

class dbManager ():
    ip = 'grad.icmc.usp.br'
    port = 15215
    SID = 'orcl'
    login = password = 'a8532248'
    dsn_tns = cx_Oracle.makedsn (ip, port, SID)

    conn = None

    def connect (self):
        try:
            self.conn = cx_Oracle.connect (self.login, self.password, self.dsn_tns)
            cur = self.conn.cursor ()
            cur.execute ('SELECT * FROM Zona')

            for attr in cur:
                print attr
            cur.close ()
        except cx_Oracle.DatabaseError, exc:
            raise Exception (exc.args[0].message)

    def select (self, what, fromWhat):
        cur = self.conn.cursor ()
        cur.execute ('SELECT ' + what + ' FROM ' + fromWhat)
        return cur.description, cur.fetchall ()

    def disconnect (self):
        if self.conn:
            self.conn.close ()
