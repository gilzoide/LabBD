# coding: utf-8

import wx
from dbManager import dbManager

class updateFrame (wx.Frame):
    """Janela de Update de tuplas"""
    # Id dos botões
    ID_ATUALIZA = 100
    ID_CANCELA = 101
    def __init__ (self, parent, id = wx.ID_ANY, position = wx.DefaultPosition, size = wx.DefaultSize, tabela = '', colunas = [], tupla = ()):
        wx.Frame.__init__ (self, parent, id, tabela, wx.DefaultPosition, size)

        sizer = wx.BoxSizer (wx.VERTICAL)
        self.SetSizer (sizer)

        self.tabela = tabela
        obs = dbManager.RESTRICOES[tabela]

        for c in colunas:
            print c

        cancelButton = wx.Button (self, self.ID_CANCELA, 'Cancelar')
        self.Bind (wx.EVT_BUTTON, self.onCancel, id = self.ID_CANCELA)

        atualizaButton = wx.Button (self, self.ID_ATUALIZA, 'Atualizar')
        self.Bind (wx.EVT_BUTTON, self.onAtualiza, id = self.ID_ATUALIZA)
        # põe os dois botões na mesma linha
        hbox = wx.BoxSizer (wx.HORIZONTAL)
        hbox.Add (atualizaButton, flag = wx.RIGHT, border = 50)
        hbox.Add (cancelButton, flag = wx.LEFT, border = 50)

        sizer.Add (hbox, flag = wx.ALIGN_CENTER | wx.TOP, border = 10, proportion = 1)

    def onAtualiza (self, event):
        """Clicou em 'Atualizar'!"""
        try:
            atualizacoes = ''
            restricoes = ''
            dbManager.getDbManager ().update (self.tabela, atualizacoes, restricoes)
        except Exception as e:
            wx.MessageBox (str (e), "Erro ao modificar tupla(s)", wx.CENTRE + wx.ICON_ERROR + wx.OK)
            self.GetParent ().SetStatusText ("Erro ao modificar tupla(s)")

    def onCancel (self, event):
        """Cancelou, fecha janela"""
        self.Close ()
