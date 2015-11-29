# coding: utf-8

import wx
from queryLister import queryLister
from dbManager import dbManager

class selectPanel (wx.Panel):
    """Panel que mostra, em abas, todas as tabelas que queremos"""
    def __init__ (self, parent, id = wx.ID_ANY, position = wx.DefaultPosition, size = wx.DefaultSize, db = None):
        wx.Panel.__init__ (self, parent, id, position, size)
        # cria o Notebook, cada aba um SELECT
        self.note = wx.Notebook (self, style = wx.NB_TOP, size = size)
        for tabela in dbManager.TABELAS_IMPORTANTES:
            colunas, valores = db.select ('*', tabela)
            pagina = queryLister (self.note)
            pagina.setValues (colunas, valores)
            self.note.AddPage (pagina, tabela)

