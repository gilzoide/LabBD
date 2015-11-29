# coding: utf-8

import wx
from dbManager import dbManager
from queryLister import queryLister

class myFrame (wx.Frame):
    """Nossa janela principal do LabBD"""
    # IDs úteis
    ID_RECONNECT = 100

    def __init__ (self):
        wx.Frame.__init__ (self, None, wx.ID_ANY, 'LabBD', wx.DefaultPosition, wx.Size (800, 600))

        self.db = dbManager ()
        self.CreateStatusBar ()

        self.montaMenus ()
        self.Bind (wx.EVT_MENU, self.onQuit, id = wx.ID_EXIT)
        self.Bind (wx.EVT_MENU, self.onAbout, id = wx.ID_ABOUT)
        self.Bind (wx.EVT_MENU, self.onReconnect, id = self.ID_RECONNECT)
        self.Show ()
        self.icon = wx.Icon ('cavalo.png')
        self.SetIcon (self.icon)

        self.onReconnect (None)

        #lister = queryLister (self, wx.ID_ANY, wx.DefaultPosition, wx.Size (700, 500))
        #colunas, valores = self.db.select ('*', 'Zona')
        #print colunas, valores
        #lister.setValues (colunas, valores)


    def montaMenus (self):
        menuBar = wx.MenuBar ()
        # Menu de arquivo
        arquivo = wx.Menu ()
        menuBar.Append (arquivo, '&Arquivo')
        arquivo.Append (self.ID_RECONNECT, '&Reconectar', 'Tenta reconectar com o bando de dados')
        arquivo.Append (wx.ID_EXIT, '&Sair', 'Sai do programa')
        # Menu de operações
        operacoes = wx.Menu ()
        menuBar.Append (operacoes, '&Operações')
        # Menu de ajuda
        ajuda = wx.Menu ()
        menuBar.Append (ajuda, 'A&juda')
        ajuda.Append (wx.ID_ABOUT, '&Sobre', 'Mostra informação sobre o programa')

        self.SetMenuBar (menuBar)
    
    def onReconnect (self, event):
        self.db.disconnect ()
        try:
            self.db.connect ()
            self.SetStatusText ('Conectado')
        except Exception as e:
            wx.MessageBox (str (e), "Erro de conexão", wx.CENTRE + wx.ICON_ERROR + wx.OK)
            self.SetStatusText ('Não conectado')



    def onAbout (self, event):
        info = wx.AboutDialogInfo ()
        info.SetName ('T5 de LabBD')
        info.SetVersion ('0.0.1')
        info.SetDescription ('Trabalho 5 de Laboratório de Bases de Dados')
        info.SetIcon (self.icon)
        info.AddDeveloper ('Gil Barbosa Reis - 8532248')
        info.AddDeveloper ('Raul Zaninetti Rosa - 8517310')
        wx.AboutBox (info)

    def onQuit (self, event):
        self.Close ()

app = wx.App (False)
frame = myFrame ()
app.MainLoop ()
