# coding: utf-8

import wx
import cx_Oracle
from wx.lib.intctrl import IntCtrl
from dbManager import dbManager

class tableInserter (wx.Panel):
    # Id do botão, pra rolar callback
    ID_INSERT = 100
    def __init__ (self, parent, id, position, size, tabela, obs = {}):
        """Ctor. 'obs' é um dicionário que mostra algumas observações sobre
        alguns campos (por nome), como por exemplo CONSTRAINTs de vários tipos.

        Observações possíveis (a partir do tipo/valor):
            'ignore' - ignora campo
            (tupla) - enum, lista de valores fixos (bom pra quando tem CHECK IN)
        """
        wx.Panel.__init__ (self, parent, id, position, size)
        self.tabela = tabela
        self.db = dbManager.getDbManager ()
        colunas = self.db.getTableInfo (tabela)
        #print colunas

        self.campos = []

        sizer = wx.BoxSizer (wx.VERTICAL)
        self.SetSizer (sizer)
        for c in colunas:
            observacao = obs.get (c[0])
            # Nada de ignorar, comportamento básico: "Label [ctrl]"
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
                # adiciona o "Label [ctrl]" no BoxSizer, pra ficar tudo bonitão
                hbox = wx.BoxSizer (wx.HORIZONTAL)
                hbox.Add (txt, flag = wx.CENTER | wx.RIGHT, border = 10)
                hbox.Add (ctrl, proportion = 1)
                sizer.Add (hbox, flag = wx.EXPAND)
                # salva na lista, pra podermos pegar depois
                self.campos.append ((c[0], ctrl))

        addButton = wx.Button (self, self.ID_INSERT, label = 'Inserir')
        sizer.Add ((-1, 20))
        sizer.Add (addButton, flag = wx.ALIGN_CENTER)
        self.Bind (wx.EVT_BUTTON, self.insere, id = self.ID_INSERT)

    def insere (self, event):
        colunas = []
        valores = []
        for c in self.campos:
            colunas.append (c[0])
            # formata a entrada dependendo do tipo
            if type (c[1]) is wx.Choice:
                valor = "'" + c[1].GetString (c[1].GetSelection ()) + "'"
            elif type (c[1]) is IntCtrl:
                valor = str (c[1].GetValue ())
            else:
                valor = "'" + c[1].GetValue () + "'"
            valores.append (valor)

        try:
            self.db.insert (self.tabela, colunas, valores)
            wx.MessageBox ("Tupla inserida!", "Inserção", wx.CENTRE + wx.ICON_ERROR + wx.OK)
            self.GetParent ().GetParent ().GetParent ().marcaAlgoMudou ()
        except Exception as e:
            wx.MessageBox (str (e), "Erro de inserção", wx.CENTRE + wx.ICON_ERROR + wx.OK)

