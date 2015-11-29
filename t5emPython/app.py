# coding: utf-8

import wx
from dbManager import dbManager
from tableInserter import tableInserter
from queryLister import queryLister
from selectPanel import selectPanel
from insertPanel import insertPanel

class myFrame (wx.Frame):
    """Nossa janela principal do LabBD"""
    # IDs úteis
    ID_RECONNECT = 100
    ID_INSERT = 101
    ID_SELECT = 102
    ID_ROLLBACK = 103

    # Flag que marca se algo mudou na base de dados
    algoMudou = False
    # Painel atual
    current = None
    # Tamanho padrão pra painéis
    panelSize = wx.Size (750, 500)

    def __init__ (self):
        wx.Frame.__init__ (self, None, wx.ID_ANY, 'LabBD', wx.DefaultPosition, wx.Size (800, 600))
        self.CreateStatusBar ()

        self.montaMenus ()
        self.Bind (wx.EVT_MENU, self.onQuit, id = wx.ID_EXIT)
        self.Bind (wx.EVT_MENU, self.onAbout, id = wx.ID_ABOUT)
        self.Bind (wx.EVT_MENU, self.onReconnect, id = self.ID_RECONNECT)
        self.Bind (wx.EVT_MENU, self.onSelect, id = self.ID_SELECT)
        self.Bind (wx.EVT_MENU, self.onInsert, id = self.ID_INSERT)
        self.Bind (wx.EVT_MENU, self.onRollback, id = self.ID_ROLLBACK)

        # abre a tela e troca o ícone
        self.Show ()
        self.icon = wx.Icon ('cavalo.png')
        self.SetIcon (self.icon)

        # conecta com o banco de dados
        self.db = dbManager.getDbManager ()
        self.onReconnect (None)

        self.insertPanel = insertPanel (self, self.ID_INSERT, size = self.panelSize)
        self.selectPanel = selectPanel (self, self.ID_SELECT, size = self.panelSize)

        self.current = self.selectPanel

    def montaMenus (self):
        """Cria os menus do app"""
        menuBar = wx.MenuBar ()
        # Menu de arquivo
        arquivo = wx.Menu ()
        menuBar.Append (arquivo, '&Arquivo')
        arquivo.Append (self.ID_RECONNECT, '&Reconectar', 'Tenta reconectar com o bando de dados')
        arquivo.Append (self.ID_ROLLBACK, '&Descartar modificações', 'Descarta transação corrente')
        arquivo.Append (wx.ID_EXIT, '&Sair', 'Sai do programa')
        # Menu de operações
        operacoes = wx.Menu ()
        menuBar.Append (operacoes, '&Operações')
        operacoes.Append (self.ID_INSERT, '&Inserir')
        operacoes.Append (self.ID_SELECT, '&Mostrar tabelas')
        # Menu de ajuda
        ajuda = wx.Menu ()
        menuBar.Append (ajuda, 'A&juda')
        ajuda.Append (wx.ID_ABOUT, '&Sobre', 'Mostra informação sobre o programa')

        self.SetMenuBar (menuBar)
    
    def onReconnect (self, event):
        """Tenta reconectar com o Banco de Dados"""
        self.db.disconnect ()
        try:
            self.db.connect ()
            self.SetStatusText ('Conectado')
        except Exception as e:
            wx.MessageBox (str (e), "Erro de conexão", wx.CENTRE + wx.ICON_ERROR + wx.OK)
            self.SetStatusText ('Não conectado')

    def onRollback (self, event):
        self.db.rollback ()
        self.algoMudou = True

    def onSelect (self, event):
        # se algo mudou, atualiza as queries
        self.selectPanel.refresh (self.algoMudou)
        self.algoMudou = False
        self.changePanel (self.selectPanel)

    def changePanel (self, newPanel):
        if self.current:
            self.current.Show (False)
        # atualiza a janela atual
        self.current = newPanel
        # e mostra o trem
        self.current.Show (True)

    def onInsert (self, event):
        self.changePanel (self.insertPanel)

    def marcaAlgoMudou (self):
        """Marca a flag que algo mudou, para podermos dar refresh dos SELECTs"""
        self.algoMudou = True

    def onAbout (self, event):
        """Mostra informações sobre esse app"""
        info = wx.AboutDialogInfo ()
        info.SetName ('T5 de LabBD')
        info.SetVersion ('0.0.1')
        info.SetDescription ('Trabalho 5 de Laboratório de Bases de Dados')
        info.SetIcon (self.icon)
        info.AddDeveloper ('Gil Barbosa Reis - 8532248')
        info.AddDeveloper ('Raul Zaninetti Rosa - 8517310')
        wx.AboutBox (info)

    def onQuit (self, event):
        """Sai do programa"""
        self.db.disconnect ()
        self.Close ()

app = wx.App (False)
frame = myFrame ()
app.MainLoop ()
