# coding: utf-8

import wx
import cx_Oracle

class myFrame (wx.Frame):
    ip = 'grad.icmc.usp.br'
    port = 15215
    SID = 'orcl'
    login = password = 'a8532248'
    dsn_tns = cx_Oracle.makedsn (ip, port, SID)

    def __init__ (self):
        wx.Frame.__init__ (self, None, wx.ID_ANY, 'LabBD', wx.DefaultPosition, wx.Size (800, 600))
        self.conn = cx_Oracle.connect (self.login, self.password, self.dsn_tns)
        cur = self.conn.cursor ()
        cur.execute ('SELECT * FROM Zona')

        for attr in cur:
            print attr
        cur.close ()

        self.montaMenus ()
        self.Bind (wx.EVT_MENU, self.onQuit, id = wx.ID_EXIT)
        self.Bind (wx.EVT_MENU, self.onAbout, id = wx.ID_ABOUT)
        self.Show ()
        self.icon = wx.Icon ('cavalo.png')
        self.SetIcon (self.icon)

    def montaMenus (self):
        menuBar = wx.MenuBar ()
        # Menu de arquivo
        arquivo = wx.Menu ()
        menuBar.Append (arquivo, '&Arquivo')
        arquivo.Append (wx.ID_EXIT, '&Sair', 'Sai do programa')
        # Menu de operações
        operacoes = wx.Menu ()
        menuBar.Append (operacoes, '&Operações')
        # Menu de ajuda
        ajuda = wx.Menu ()
        menuBar.Append (ajuda, 'A&juda')
        ajuda.Append (wx.ID_ABOUT, '&Sobre', 'Mostra informação sobre o programa')

        self.SetMenuBar (menuBar)

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
