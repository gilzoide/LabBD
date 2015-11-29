# coding: utf-8

import wx

class queryLister (wx.ListCtrl):
    def __init__ (self, parent, id, position, size):
        wx.ListCtrl.__init__ (self, parent, id, position, size, wx.LC_REPORT + wx.LC_VIRTUAL)
        self.size = size

    def setValues (self, colunas, valores):
        self.valores = valores
        height = len (valores)
        width = len (colunas)
        columnWidth = self.size.GetWidth () / width
        for i, c in enumerate (colunas):
            col = wx.ListItem ()
            col.SetId (i)
            col.SetText (c[0])
            col.SetWidth (columnWidth)
            self.InsertColumnItem (col, i)

        self.SetItemCount (height)

    def OnGetItemText (self, item, coluna):
        return self.valores[item][coluna]
