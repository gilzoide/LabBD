# coding: utf-8

import wx
from tableInserter import tableInserter
from dbManager import dbManager

class insertPanel (wx.Panel):
    """Panel que mostra, em abas, as inserções possíveis"""
    def __init__ (self, parent, id = wx.ID_ANY, position = wx.DefaultPosition, size = wx.DefaultSize):
        wx.Panel.__init__ (self, parent, id, position, size)

        # cria o Notebook, cada aba um INSERT
        self.note = wx.Notebook (self, style = wx.NB_TOP, size = size)
        for tabela in dbManager.TABELAS_IMPORTANTES:
            pagina = tableInserter (self.note, wx.ID_ANY, position, size, tabela,
                    obs = dbManager.RESTRICOES.get (tabela) or {})
            self.note.AddPage (pagina, tabela)


