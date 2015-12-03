# coding: utf-8

import wx
import cx_Oracle
from dbManager import dbManager
from queryLister import queryLister
from wx.lib.intctrl import IntCtrl
from sequenceCtrl import sequenceCtrl

class mostraTupla (wx.ListCtrl):
    """Tabela que mostra uma tupla só"""
    def __init__ (self, parent, id = wx.ID_ANY, position = wx.DefaultPosition, size = wx.DefaultSize, colunas = [], tupla = ()):
        wx.ListCtrl.__init__ (self, parent, id, position, size, wx.LC_REPORT | wx.LC_VIRTUAL)
        self.tupla = tupla
        self.colunas = colunas

        # tamanhos calculados
        width = len (colunas)
        columnWidth = self.GetSize ().GetWidth () / width
        # insere as colunas
        for i, c in enumerate (colunas):
            self.InsertColumn (i, dbManager.getColunaBonita (c[0]), width = columnWidth)

        self.SetItemCount (1)

    def OnGetItemText (self, item, coluna):
        return self.tupla[coluna] or ''

class meuDatePicker (wx.DatePickerCtrl):
    """DatePicker que aceita nada, e que tem o método IsEmpty"""
    def __init__ (self, parent, id = wx.ID_ANY, position = wx.DefaultPosition, size = wx.DefaultSize):
        wx.DatePickerCtrl.__init__ (self, parent, id = id, pos = position,
                size = size, style = wx.DP_DEFAULT | wx.DP_SHOWCENTURY | wx.DP_ALLOWNONE)
        self.SetValue (wx.DateTime ())

    def IsEmpty (self):
        return not self.Value.IsValid ()


class updateFrame (wx.Frame):
    """Janela de Update de tuplas"""
    # Id dos botões
    ID_ATUALIZA = 100
    ID_CANCELA = 101
    def __init__ (self, parent, id = wx.ID_ANY, position = wx.DefaultPosition, size = wx.DefaultSize, tabela = '', colunas = [], tupla = ()):
        wx.Frame.__init__ (self, parent, id, tabela, wx.DefaultPosition, size)

        sizer = wx.BoxSizer (wx.VERTICAL)
        self.SetSizer (sizer)

        self.tabela = tabela
        self.tupla = tupla
        self.colunas = colunas
        obs = dbManager.RESTRICOES[tabela]

        tuplaAtual = mostraTupla (self, size = wx.Size (size.GetWidth (), 100), tupla = tupla, colunas = colunas)
        sizer.Add (tuplaAtual)

        # lista de campos de input
        self.campos = []
        for c in colunas:
            observacao = obs.get (c[0])
            # Nada de ignorar, comportamento básico: "Label [ctrl]"
            if not (observacao in ('ignore', 'seq', 'pk') or type (observacao) is int):
                txt = wx.StaticText (self, wx.ID_ANY, 'Novo ' + dbManager.getColunaBonita (c[0]))
                ## Cada tipo de dados pede um input diferente, digo bora ##
                # Número: IntCtrl, com máximo e mínimo
                if c[1] is cx_Oracle.NUMBER:
                    ctrl = IntCtrl (self, min = 0, max = c[4] and 10 ** c[4] or None)
                # Data: DatePickerCtrl, pq né
                elif c[1] is cx_Oracle.DATETIME:
                    ctrl = meuDatePicker (self)
                # Enum (CHAR/VARCHAR2 com CHECK): Choice com as possibilidades
                elif type (observacao) is tuple:
                    ctrl = wx.Choice (self, choices = observacao)
                    ctrl.SetSelection (0)
                # String (CHAR/VARCHAR2): TextCtrl
                else:
                    ctrl = wx.TextCtrl (self)

                # adiciona o "Label [ctrl]" no BoxSizer, pra ficar tudo bonitão
                hbox = wx.BoxSizer (wx.HORIZONTAL)
                hbox.Add (txt, flag = wx.CENTER | wx.RIGHT, border = 10)
                hbox.Add (ctrl, proportion = 1)
                sizer.Add (hbox, flag = wx.EXPAND)
                # salva na lista, pra podermos pegar depois
                self.campos.append ((c, ctrl))

        cancelButton = wx.Button (self, self.ID_CANCELA, 'Cancelar')
        self.Bind (wx.EVT_BUTTON, self.onCancel, id = self.ID_CANCELA)

        atualizaButton = wx.Button (self, self.ID_ATUALIZA, 'Atualizar')
        self.Bind (wx.EVT_BUTTON, self.onAtualiza, id = self.ID_ATUALIZA)
        # põe os dois botões na mesma linha
        hbox = wx.BoxSizer (wx.HORIZONTAL)
        hbox.Add (atualizaButton, flag = wx.RIGHT, border = 50)
        hbox.Add (cancelButton, flag = wx.LEFT, border = 50)

        sizer.Add (hbox, flag = wx.ALIGN_CENTER | wx.TOP, border = 10, proportion = 1)

    def onAtualiza (self, event):
        """Clicou em 'Atualizar'!"""
        # vê quais campos serão atualizados
        colunasAtualiza = []
        valoresAtualiza = []
        for c in self.campos:
            if not c[1].IsEmpty ():
                colunasAtualiza.append (c[0])
                # formata a entrada dependendo do tipo
                if type (c[1]) is wx.Choice:
                    valor = "'" + c[1].GetString (c[1].GetSelection ()) + "'"
                elif type (c[1]) is IntCtrl or type (c[1]) is sequenceCtrl:
                    valor = str (c[1].GetValue ())
                elif type (c[1]) is meuDatePicker:
                    valor = "TO_DATE ('" + c[1].GetValue ().FormatISODate () + "', 'yyyy-mm-dd')"
                else:
                    valor = "'" + str (c[1].GetValue ()) + "'"
                valoresAtualiza.append (valor)

        # só tenta atualizar se tem alguma coisa pra atualizar
        if len (colunasAtualiza):
            # restrições são os próprios valores da tupla em questão
            colunasRestricao = self.colunas
            valoresRestricao = self.tupla

            app = self.GetParent ().GetParent ()
            try:
                dbManager.getDbManager ().update (self.tabela, colunasAtualiza, valoresAtualiza, colunasRestricao, valoresRestricao)
                app.algoMudou ()
                app.SetStatusText ("Tupla modificada")
                wx.MessageBox ("Tupla modificada")
                self.Close ()
            except Exception as e:
                app.SetStatusText ("Erro ao modificar tupla(s)")
                wx.MessageBox (str (e), "Erro ao modificar tupla(s)", wx.CENTRE + wx.ICON_ERROR + wx.OK)

    def onCancel (self, event):
        """Cancelou, fecha janela"""
        self.Close ()
