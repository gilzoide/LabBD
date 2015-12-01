#!/usr/bin/env python2
# coding: utf-8

import wx
from dbManager import dbManager
from tableInserter import tableInserter
from queryLister import queryLister
from selectPanel import selectPanel
from insertPanel import insertPanel
from relatorioPanel import relatorioPanel

class myFrame (wx.Frame):
    """Nossa janela principal do LabBD"""
    # IDs úteis
    ID_INSERT = 101
    ID_SELECT = 102
    ID_ROLLBACK = 103
    ID_RELATORIO = 104

    # Painel atual
    current = None
    # Tamanho do frame
    frameSize = wx.Size (1024, 768)
    # Tamanho padrão pra painéis
    panelSize = frameSize - wx.Size (10, 100)

    def __init__ (self):
        wx.Frame.__init__ (self, None, wx.ID_ANY, 'LabBD', wx.DefaultPosition, self.frameSize)
        self.CreateStatusBar ()

        # Menus
        self.montaMenus ()
        self.Bind (wx.EVT_MENU, self.onQuit, id = wx.ID_EXIT)
        self.Bind (wx.EVT_MENU, self.onAbout, id = wx.ID_ABOUT)
        self.Bind (wx.EVT_MENU, self.onSelect, id = self.ID_SELECT)
        self.Bind (wx.EVT_MENU, self.onInsert, id = self.ID_INSERT)
        self.Bind (wx.EVT_MENU, self.onRollback, id = self.ID_ROLLBACK)
        self.Bind (wx.EVT_MENU, self.onRelatorio, id = self.ID_RELATORIO)

        # Atalhos do teclado
        atalhos = wx.AcceleratorTable ([
                    (wx.ACCEL_CTRL, ord ('Z'), self.ID_ROLLBACK)
                ])
        self.SetAcceleratorTable (atalhos)

        # abre a tela e troca o ícone
        self.Show ()
        self.icon = wx.Icon ('cavalo.png')
        self.SetIcon (self.icon)

        # conecta com o banco de dados
        self.db = dbManager.getDbManager ()
        try:
            self.db.connect ()
            self.SetStatusText ('Conectado')
        except Exception as e:
            wx.MessageBox (str (e), "Erro de conexão", wx.CENTRE | wx.ICON_ERROR | wx.OK)
            self.Close ()
            return

        self.insertPanel = insertPanel (self, self.ID_INSERT, size = self.panelSize)
        self.relatorioPanel = relatorioPanel (self, self.ID_RELATORIO, size = self.panelSize)
        self.selectPanel = selectPanel (self, self.ID_SELECT, size = self.panelSize)

        self.current = self.selectPanel

    def montaMenus (self):
        """Cria os menus do app"""
        menuBar = wx.MenuBar ()
        # Menu de arquivo
        arquivo = wx.Menu ()
        menuBar.Append (arquivo, '&Arquivo')
        arquivo.Append (self.ID_ROLLBACK, '&Descartar modificações\tCtrl-Z', 'Descarta transação corrente')
        arquivo.Append (wx.ID_EXIT, '&Sair', 'Sai do programa')
        # Menu de operações
        operacoes = wx.Menu ()
        menuBar.Append (operacoes, '&Operações')
        operacoes.Append (self.ID_INSERT, '&Inserir', "Painel de inserção no BD")
        operacoes.Append (self.ID_SELECT, '&Mostrar tabelas', "Tabelas de dados")
        operacoes.Append (self.ID_RELATORIO, '&Gerar relatórios', "Painel de geração de relatórios")
        # Menu de ajuda
        ajuda = wx.Menu ()
        menuBar.Append (ajuda, 'A&juda')
        ajuda.Append (wx.ID_ABOUT, '&Sobre', 'Mostra informação sobre o programa')

        self.SetMenuBar (menuBar)

    def onRollback (self, event):
        """Pergunta se usuário quer dar Rollback"""
        if wx.MessageBox ("Desfazer alterações no BD?", "Rollback?", wx.YES_NO) == wx.YES:
            self.db.rollback ()
            self.SetStatusText ("Rollback executado")
            self.algoMudou ()

    def onRelatorio (self, event):
        """Abre janela dos relatórios"""
        self.changePanel (self.relatorioPanel)

    def onSelect (self, event):
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

    def algoMudou (self):
        """Algo mudou, então refaz os SELECTs"""
        self.selectPanel.refresh ()

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
