# coding: utf-8

import wx
from wx.lib.intctrl import IntCtrl
from dbManager import dbManager

class relatorioPanel (wx.Panel):
    """Painel que possibilita a geração de relatórios"""
    # Ids
    ID_REL1 = 100

    def __init__ (self, parent, id = wx.ID_ANY, position = wx.DefaultPosition, size = wx.DefaultSize):
        wx.Panel.__init__ (self, parent, id, position, size)

        # BoxSizer, pra por os 2 negócio junto
        sizer = wx.BoxSizer (wx.VERTICAL)
        self.SetSizer (sizer)

        fonteTitulo = wx.Font (24, wx.DEFAULT, wx.NORMAL, wx.NORMAL)

        ## Relatório 1 ##
        txt = wx.StaticText (self, wx.ID_ANY, "Relatório 1 - Candidatos")
        txt.SetFont (fonteTitulo)
        sizer.Add (txt, flag = wx.ALIGN_CENTER)
        # primeiro campo
        hbox = wx.BoxSizer (wx.HORIZONTAL)
        txt = wx.StaticText (self, wx.ID_ANY, "Idade inicial")
        ctrl = IntCtrl (self, min = 0, max = 150)
        hbox.Add (txt, flag = wx.CENTER | wx.LEFT | wx.RIGHT, border = 10)
        hbox.Add (ctrl, proportion = 1)
        sizer.Add (hbox, flag = wx.EXPAND)

        self.rel1inicial = ctrl
        # segundo campo
        hbox = wx.BoxSizer (wx.HORIZONTAL)
        txt = wx.StaticText (self, wx.ID_ANY, "Idade final")
        ctrl = IntCtrl (self, min = 0, max = 150)
        hbox.Add (txt, flag = wx.CENTER | wx.LEFT | wx.RIGHT, border = 10)
        hbox.Add (ctrl, proportion = 1)
        sizer.Add (hbox, flag = wx.EXPAND)

        self.rel1final = ctrl
        # botão pra gerar
        button = wx.Button (self, self.ID_REL1, 'Gerar relatório')
        self.Bind (wx.EVT_BUTTON, self.onRel1, id = self.ID_REL1)
        sizer.Add (button, flag = wx.CENTER)

        sizer.AddSpacer (50)
        ## Relatório 2 ##
        txt = wx.StaticText (self, wx.ID_ANY, "Relatório 2 - ???")
        txt.SetFont (fonteTitulo)
        sizer.Add (txt, flag = wx.ALIGN_CENTER)

        # e a saída
        font = wx.Font (10, wx.FONTFAMILY_TELETYPE, wx.FONTSTYLE_NORMAL,
                wx.FONTWEIGHT_NORMAL, False, "DejaVu Sans Mono")
        self.msgBox = wx.TextCtrl (self, style = wx.TE_MULTILINE | wx.TE_READONLY
                | wx.HSCROLL)
        self.msgBox.SetDefaultStyle (wx.TextAttr ("black", font = font))
        sizer.Add (self.msgBox, flag = wx.EXPAND, proportion = 1)

    def onRel1 (self, event):
        """Botão de relatório 1"""
        db = dbManager.getDbManager ()
        saida = db.procedure ('relatorios.gera_relatorio', [self.rel1inicial.GetValue (),
                self.rel1final.GetValue ()])
        self.msgBox.SetValue (saida)
