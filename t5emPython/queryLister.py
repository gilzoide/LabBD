# coding: utf-8

import wx
import datetime
from dbManager import dbManager

class queryLister (wx.ListCtrl):
    """Tabela que lista um SELECT"""
    def __init__ (self, parent, id = wx.ID_ANY, position = wx.DefaultPosition, size = wx.DefaultSize):
        wx.ListCtrl.__init__ (self, parent, id, position, size, wx.LC_REPORT | wx.LC_VIRTUAL)
        self.db = dbManager.getDbManager ()
        self.ultimoClique = None

    def setConsulta (self, what, fromWhat):
        """Troca qual consulta que vai rolar"""
        self.what = what
        self.fromWhat = fromWhat
        self.orderBy = None

    def refresh (self):
        """Refaz a consulta, repondo os valores na tabela"""
        fromWhat = self.fromWhat + (self.orderBy and ' ORDER BY ' + self.orderBy or '')
        colunas, valores = self.db.select (self.what, fromWhat)
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
            self.InsertColumn (i, dbManager.getColunaBonita (c[0]), width = columnWidth)

        self.SetItemCount (height)

    def OnColumnClick (self, event):
        """Se clicou numa coluna, dá um Sort pliz ^^ """
        clique = event.m_col
        if self.ultimoClique == clique:
            self.asc = not self.asc
        else:
            self.ultimoClique = clique
            self.asc = True

        self.orderBy = self.colunas[clique][0] + (self.asc and ' ASC' or ' DESC')
        self.refresh ()

    def OnGetItemText (self, item, coluna):
        """Dita qual valor fica em cada célula"""
        valor = self.valores[item][coluna] or ''
        if type (valor) is datetime.datetime:
            valor = valor.date ().isoformat ()
        return valor
