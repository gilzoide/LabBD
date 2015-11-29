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

        self.db = dbManager.getDbManager ()

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
        self.Bind (wx.EVT_BUTTON, self.onDelete, id = self.ID_DELETE)
        sizer.Add (deleteButton, flag = wx.ALIGN_CENTER, proportion = 1)

        self.refresh (True)

    def onDelete (self, event):
        page = self.note.GetCurrentPage ()
        prox = -1
        while True:
            prox = page.GetNextSelected (prox)
            if prox == -1:
                break
            try:
                self.db.delete (self.note.GetPageText (self.note.GetSelection ()),
                    page.colunas, page.valores[prox])
                wx.MessageBox ("Tupla apagada", "", wx.CENTRE + wx.ICON_ERROR + wx.OK)
                page.refresh ()
            except Exception as e:
                wx.MessageBox (str (e), "Erro ao apagar", wx.CENTRE + wx.ICON_ERROR + wx.OK)

    def refresh (self, doRefresh):
        """Atualiza as informações das tabelas, se necessário"""
        if doRefresh:
            for pag in self.paginas:
                pag.refresh ()

