# coding: utf-8

import wx
import datetime
from dbManager import dbManager

class queryLister (wx.ListCtrl):
    """Tabela que lista um SELECT"""
    def __init__ (self, parent, id = wx.ID_ANY, position = wx.DefaultPosition, size = wx.DefaultSize):
        wx.ListCtrl.__init__ (self, parent, id, position, size, wx.LC_REPORT | wx.LC_VIRTUAL)
        self.db = dbManager.getDbManager ()

    def setConsulta (self, what, fromWhat):
        """Troca qual consulta que vai rolar"""
        self.what = what
        self.fromWhat = fromWhat

    def refresh (self):
        """Refaz a consulta, repondo os valores na tabela"""
        colunas, valores = self.db.select (self.what, self.fromWhat)
        self.setValues (colunas, valores)

    def setValues (self, colunas, valores):
        """Troca os valores atuais listados"""
        # limpa primeiro
        self.ClearAll ()
        # salva os valores pra tabela
        self.colunas = colunas
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
        valor = self.valores[item][coluna] or ''
        if type (valor) is datetime.datetime:
            valor = valor.date ().isoformat ()
        return valor
