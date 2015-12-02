#!/usr/bin/env python2
# coding: utf-8

import wx
from dbManager import dbManager
from tableInserter import tableInserter
from queryLister import queryLister
from selectPanel import selectPanel
from insertPanel import insertPanel
from relatorioPanel import relatorioPanel
from selectsEspecificosPanel import selectsEspecificosPanel

class myFrame (wx.Frame):
    """Nossa janela principal do LabBD"""
    # IDs úteis
    ID_INSERT = 101
    ID_SELECT = 102
    ID_ROLLBACK = 103
    ID_RELATORIO = 104
    ID_SELECTS_ESPECIFICOS = 105
    ID_COMMIT = 106

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
        self.Bind (wx.EVT_MENU, self.onCommit, id = self.ID_COMMIT)
        self.Bind (wx.EVT_MENU, self.onRelatorio, id = self.ID_RELATORIO)
        self.Bind (wx.EVT_MENU, self.onSelectsEspecificos, id = self.ID_SELECTS_ESPECIFICOS)

        # Atalhos do teclado
        atalhos = wx.AcceleratorTable ([
            (wx.ACCEL_CTRL, ord ('Z'), self.ID_ROLLBACK),
            (wx.ACCEL_CTRL, ord ('S'), self.ID_COMMIT),
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
        self.insertPanel.Show (False)
        self.relatorioPanel = relatorioPanel (self, self.ID_RELATORIO, size = self.panelSize)
        self.relatorioPanel.Show (False)
        self.selectsEspecificosPanel = selectsEspecificosPanel (self, self.ID_SELECTS_ESPECIFICOS, size = self.panelSize)
        self.selectsEspecificosPanel.Show (False)
        self.selectPanel = selectPanel (self, self.ID_SELECT, size = self.panelSize)

        self.current = self.selectPanel

    def montaMenus (self):
        """Cria os menus do app"""
        menuBar = wx.MenuBar ()
        # Menu de arquivo
        arquivo = wx.Menu ()
        menuBar.Append (arquivo, '&Arquivo')
        arquivo.Append (self.ID_COMMIT, '&Aplicar modificações\tCtrl-S', 'Aplica modificações da transação corrente')
        arquivo.Append (self.ID_ROLLBACK, '&Descartar modificações\tCtrl-Z', 'Descarta transação corrente')
        arquivo.Append (wx.ID_EXIT, '&Sair', 'Sai do programa')
        # Menu de operações
        operacoes = wx.Menu ()
        menuBar.Append (operacoes, '&Operações')
        operacoes.Append (self.ID_INSERT, '&Inserir', "Painel de inserção no BD")
        operacoes.Append (self.ID_SELECT, '&Mostrar tabelas', "Tabelas de dados")
        operacoes.Append (self.ID_SELECTS_ESPECIFICOS, '&Pesquisas', "Saída de pesquisas específicas")
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

    def onCommit (self, event):
        """Pergunta se usuário quer dar Commit"""
        if wx.MessageBox ("Aplicar alterações no BD?", "Commit?", wx.YES_NO) == wx.YES:
            self.db.commit ()
            self.SetStatusText ("Commit executado")

    def onRelatorio (self, event):
        """Abre janela dos relatórios"""
        self.changePanel (self.relatorioPanel)

    def onSelect (self, event):
        """Abre janela de SELECT * FROM tabela"""
        self.changePanel (self.selectPanel)

    def onSelectsEspecificos (self, event):
        """Abre janela de Pesquisas do T2"""
        self.changePanel (self.selectsEspecificosPanel)

    def changePanel (self, newPanel):
        """Função que troca o painel atual pelo `newPanel'"""
        self.current.Show (False)
        # atualiza a janela atual
        self.current = newPanel
        # e mostra o trem
        self.current.Show (True)

    def onInsert (self, event):
        """Abre janela de inserções"""
        self.changePanel (self.insertPanel)

    def algoMudou (self):
        """Algo mudou, então refaz os SELECTs"""
        self.selectPanel.refresh ()
        self.selectsEspecificosPanel.refresh ()

    def onAbout (self, event):
        """Mostra informações sobre esse app"""
        info = wx.AboutDialogInfo ()
        info.SetName ('T5 de LabBD')
        info.SetVersion ('0.0.2')
        info.SetDescription ('Trabalho 5 de Laboratório de Bases de Dados')
        info.SetIcon (self.icon)
        info.AddDeveloper ('Gil Barbosa Reis - 8532248')
        info.AddDeveloper ('Raul Zaninetti Rosa - 8517310')
        wx.AboutBox (info)

    def onQuit (self, event):
        """Sai do programa"""
        self.db.disconnect (True)
        self.Close ()

# cria app e roda
if __name__ == '__main__':
    app = wx.App (False)
    frame = myFrame ()
    app.MainLoop ()
