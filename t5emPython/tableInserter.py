# coding: utf-8

import wx
import cx_Oracle
from wx.lib.intctrl import IntCtrl

class tableInserter (wx.Panel):
    def __init__ (self, parent, id, position, size, db, tableName, obs):
        """Ctor. 'obs' é um dicionário que mostra algumas observações sobre
        alguns campos (por nome), como por exemplo CONSTRAINTs de vários tipos.

        Observações possíveis (a partir do tipo/valor):
            'ignore' - ignora campo
            (tupla) - enum, lista de valores fixos (bom pra quando tem CHECK IN)
        """
        wx.Panel.__init__ (self, parent, id, position, size)
        self.db = db
        colunas = self.db.getTableInfo (tableName)
        #print colunas

        sizer = wx.BoxSizer (wx.VERTICAL)
        self.SetSizer (sizer)
        for c in colunas:
            observacao = obs.get (c[0])
            # nenhuma observação, comportamento básico: "Label [TextCtrl]"
            if observacao != 'ignore':
                txt = wx.StaticText (self, wx.ID_ANY, c[0])
                ## Cada tipo de dados pede um input diferente, digo bora ##
                # Número: IntCtrl, com máximo e mínimo
                if c[1] == cx_Oracle.NUMBER:
                    ctrl = IntCtrl (self, min = 0, max = c[4] and 10 ** c[4] or None)
                # Data: DatePickerCtrl, pq né
                elif c[1] == cx_Oracle.DATETIME:
                    ctrl = wx.DatePickerCtrl (self)
                # Enum (CHAR/VARCHAR2 com CHECK): Choice com as possibilidades
                elif type (observacao) is tuple:
                    ctrl = wx.Choice (self, choices = observacao)
                # String (CHAR/VARCHAR2): TextCtrl
                else:
                    ctrl = wx.TextCtrl (self)
                hbox = wx.BoxSizer (wx.HORIZONTAL)
                hbox.Add (txt, flag = wx.CENTER | wx.RIGHT, border = 10)
                hbox.Add (ctrl, proportion = 1)
                sizer.Add (hbox, flag = wx.EXPAND)
