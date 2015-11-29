# coding: utf-8

import wx
from dbManager import dbManager

class queryLister (wx.ListCtrl):
    """Tabela que lista um SELECT"""
    def __init__ (self, parent, id = wx.ID_ANY, position = wx.DefaultPosition, size = wx.DefaultSize):
        wx.ListCtrl.__init__ (self, parent, id, position, size, wx.LC_REPORT + wx.LC_VIRTUAL)
        self.db = dbManager.getDbManager ()

    def setConsulta (self, what, fromWhat):
        self.what = what
        self.fromWhat = fromWhat

    def refresh (self):
        """Refaz a consulta, repondo os valores na tabela"""
        colunas, valores = self.db.select (self.what, self.fromWhat)
        self.setValues (colunas, valores)

    def setValues (self, colunas, valores):
        # limpa primeiro
        self.ClearAll ()
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
