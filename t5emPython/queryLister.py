# coding: utf-8

import wx

class queryLister (wx.ListCtrl):
    """Tabela que lista um SELECT"""
    def __init__ (self, parent, id, position, size):
        wx.ListCtrl.__init__ (self, parent, id, position, size, wx.LC_REPORT + wx.LC_VIRTUAL)

    def setValues (self, colunas, valores):
        # salva os valores pra tabela
        self.valores = valores
        height = len (valores)
        width = len (colunas)
        columnWidth = self.GetSize ().GetWidth () / width

        # insere as colunas
        for i, c in enumerate (colunas):
            self.InsertColumn (i, c[0], width = columnWidth)

        self.SetItemCount (height)

    def OnGetItemText (self, item, coluna):
        """Dita qual valor fica em cada célula"""
        return self.valores[item][coluna]
