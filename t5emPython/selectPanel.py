# coding: utf-8

import wx
from queryLister import queryLister
from dbManager import dbManager
from updateFrame import updateFrame

class selectPanel (wx.Panel):
    # Id dos botões
    ID_DELETE = 100
    ID_UPDATE = 101
    ID_TABELA = 110

    """Panel que mostra, em abas, todas as tabelas que queremos"""
    def __init__ (self, parent, id = wx.ID_ANY, position = wx.DefaultPosition, size = wx.DefaultSize):
        wx.Panel.__init__ (self, parent, id, position, size)

        self.db = dbManager.getDbManager ()

        # BoxSizer, pra por os 2 negócio junto
        sizer = wx.BoxSizer (wx.VERTICAL)
        self.SetSizer (sizer)

        self.paginas = []
        # cria o Notebook, cada aba um SELECT
        self.note = wx.Notebook (self, style = wx.NB_TOP)
        sizer.Add (self.note, proportion = 10, flag = wx.EXPAND)
        for i, tabela in enumerate (dbManager.TABELAS_IMPORTANTES):
            pagina = queryLister (self.note, self.ID_TABELA + i, size = size - wx.Size (10, 100))
            self.Bind (wx.EVT_LIST_COL_CLICK, pagina.OnColumnClick, id = self.ID_TABELA + i)
            pagina.setConsulta ('*', tabela)
            self.paginas.append (pagina)
            self.note.AddPage (pagina, tabela)

        # botão de apagar
        deleteButton = wx.Button (self, self.ID_DELETE, label = "Apagar tupla")
        self.Bind (wx.EVT_BUTTON, self.onDelete, id = self.ID_DELETE)
        # e botão de update
        updateButton = wx.Button (self, self.ID_UPDATE, label = "Modificar tupla")
        self.Bind (wx.EVT_BUTTON, self.onUpdate, id = self.ID_UPDATE)

        # põe os dois botões na mesma linha
        hbox = wx.BoxSizer (wx.HORIZONTAL)
        hbox.Add (deleteButton, flag = wx.RIGHT, border = 50)
        hbox.Add (updateButton, flag = wx.LEFT, border = 50)

        sizer.Add (hbox, flag = wx.ALIGN_CENTER | wx.TOP, border = 10, proportion = 1)

        # e desenha as tabela
        self.refresh ()

    def onUpdate (self, event):
        """Tenta modificar tuplas selecionadas"""
        # page é o queryLister atual
        page = self.note.GetCurrentPage ()
        prox = -1
        while True:
            prox = page.GetNextSelected (prox)
            if prox == -1:
                break
            try:
                frame = updateFrame (self, size = self.GetSize () - wx.Size (200, 200),
                        tabela = self.note.GetPageText (self.note.GetSelection ()),
                        colunas = page.colunas, tupla = page.valores[prox])
                frame.Show ()
            except Exception as e:
                wx.MessageBox (str (e), "Erro ao tentar atualizar tupla(s)", wx.CENTRE + wx.ICON_ERROR + wx.OK)
        # Refaz a página
        page.refresh ()

    def onDelete (self, event):
        """Tenta apagar tuplas selecionadas"""
        # page é o queryLister atual
        page = self.note.GetCurrentPage ()
        prox = -1
        app = self.GetParent ()
        while True:
            prox = page.GetNextSelected (prox)
            if prox == -1:
                break
            try:
                self.db.delete (self.note.GetPageText (self.note.GetSelection ()),
                    page.colunas, page.valores[prox])
                app.SetStatusText ("Tupla(s) apagada")
                wx.MessageBox ("Tupla apagada")
            except Exception as e:
                app.SetStatusText ("Erro ao apagar tupla(s)")
                wx.MessageBox (str (e), "Erro ao apagar tupla(s)", wx.CENTRE + wx.ICON_ERROR + wx.OK)
        # Refaz a página
        page.refresh ()

    def refresh (self):
        """Atualiza as informações das tabelas"""
        for pag in self.paginas:
            pag.refresh ()

