# coding: utf-8

import wx
from queryLister import queryLister
from dbManager import dbManager

class selectPanel (wx.Panel):
    # Id do botão de delete
    ID_DELETE = 100
    """Panel que mostra, em abas, todas as tabelas que queremos"""
    def __init__ (self, parent, id = wx.ID_ANY, position = wx.DefaultPosition, size = wx.DefaultSize):
        wx.Panel.__init__ (self, parent, id, position, size)

        sizer = wx.BoxSizer (wx.VERTICAL)
        self.SetSizer (sizer)

        self.paginas = []
        # cria o Notebook, cada aba um SELECT
        self.note = wx.Notebook (self, style = wx.NB_TOP)
        sizer.Add (self.note, proportion = 10, flag = wx.EXPAND)
        for tabela in dbManager.TABELAS_IMPORTANTES:
            pagina = queryLister (self.note)
            pagina.setConsulta ('*', tabela)
            self.paginas.append (pagina)
            self.note.AddPage (pagina, tabela)

        deleteButton = wx.Button (self, self.ID_DELETE, label = "Apagar tupla")
        sizer.Add (deleteButton, flag = wx.ALIGN_CENTER, proportion = 1)

        self.refresh (True)

    def refresh (self, doRefresh):
        if doRefresh:
            for pag in self.paginas:
                pag.refresh ()

