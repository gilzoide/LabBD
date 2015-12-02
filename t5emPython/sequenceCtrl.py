# coding: utf-8

import wx
from dbManager import dbManager

class sequenceCtrl (wx.TextCtrl):
    """Caixa de texto que controla uma SEQUENCE do sql"""
    def __init__ (self, parent, id = wx.ID_ANY, size = wx.DefaultSize, style = wx.TE_READONLY, tabela = None):
        wx.TextCtrl.__init__ (self, parent, id = id, size = size, style = style)
        self.tabela = tabela
        self.SetValue ('sequence')

    def GetValue (self):
        """Pega o valor da sequência. Use só na hora do insert, pliz"""
        db = dbManager.getDbManager ()
        _, valores = db.select ('seq_' + self.tabela + '.nextval', 'dual')
        valor = valores[0][0]
        self.SetValue (str (valor + 1))
        return valor
