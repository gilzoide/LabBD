# coding: utf-8

import wx
import cx_Oracle
from wx.lib.intctrl import IntCtrl
from dbManager import dbManager, fk
from sequenceCtrl import sequenceCtrl

class tableInserter (wx.Panel):
    # Id do botão, pra rolar callback
    ID_INSERT = 100
    ID_FK = 101

    def __init__ (self, parent, id, position, size, tabela, obs = {}):
        """Ctor. 'obs' é um dicionário que mostra algumas observações sobre
        alguns campos (por nome), como por exemplo CONSTRAINTs de vários tipos.

        Observações possíveis (a partir do tipo/valor):
            'ignore' - ignora campo
            (tupla) - enum, lista de valores fixos (bom pra quando tem CHECK IN)
        """
        wx.Panel.__init__ (self, parent, id, position, size)
        self.tabela = tabela
        self.db = dbManager.getDbManager ()
        colunas = self.db.getTableInfo (tabela)
        #print colunas

        self.campos = []

        sizer = wx.BoxSizer (wx.VERTICAL)
        self.SetSizer (sizer)
        # primeira coisa (se tiver), põe as opções de FKs
        if obs.get ('fks'):
            # nossa lista de campos dependentes de FK
            self.fkCtrlList = []
            self.fks = obs['fks']
            self.fkChoices = []
            for i, fk in enumerate (self.fks):
                # descobre quais são as possíveis fks, e mostra pa nóis
                txt = wx.StaticText (self, wx.ID_ANY, 'FK ' + fk.descricao)
                chaves = fk.getKeys ()
                ctrl = wx.Choice (self, id = self.ID_FK + i, choices = chaves)
                self.fkChoices.append (ctrl)
                # e adiciona no BoxSizer
                hbox = wx.BoxSizer (wx.HORIZONTAL)
                hbox.Add (txt, flag = wx.CENTER | wx.RIGHT, border = 10)
                hbox.Add (ctrl, proportion = 1)
                sizer.Add (hbox, flag = wx.EXPAND)
                # adiciona uma posição no fkCtrls
                self.fkCtrlList.append ([])
                self.Bind (wx.EVT_CHOICE, self.atualizaFks, id = self.ID_FK + i)

        for c in colunas:
            observacao = obs.get (c[0])
            # Nada de ignorar, comportamento básico: "Label [ctrl]"
            if observacao != 'ignore':
                txt = wx.StaticText (self, wx.ID_ANY, c[0] +
                        (observacao == 'seq' and ' (seq)' or ''))
                ## Cada tipo de dados pede um input diferente, digo bora ##
                # Número: IntCtrl, com máximo e mínimo
                if c[1] is cx_Oracle.NUMBER:
                    if observacao == 'seq':
                        ctrl = sequenceCtrl (self, tabela = tabela)
                    else:
                        ctrl = IntCtrl (self, min = 0, max = c[4] and 10 ** c[4] or None)
                # Data: DatePickerCtrl, pq né
                elif c[1] is cx_Oracle.DATETIME:
                    ctrl = wx.DatePickerCtrl (self)
                # Enum (CHAR/VARCHAR2 com CHECK): Choice com as possibilidades
                elif type (observacao) is tuple:
                    ctrl = wx.Choice (self, choices = observacao)
                    ctrl.SetSelection (0)
                # String (CHAR/VARCHAR2): TextCtrl
                else:
                    ctrl = wx.TextCtrl (self)

                # FKs: salva o Ctrl na lista de Ctrls das FKs
                if type (observacao) is int:
                    # salva o Ctrl, pra que possamos completar quando as FKs
                    # forem selecionadas
                    self.fkCtrlList[observacao].append (ctrl)

                # adiciona o "Label [ctrl]" no BoxSizer, pra ficar tudo bonitão
                hbox = wx.BoxSizer (wx.HORIZONTAL)
                hbox.Add (txt, flag = wx.CENTER | wx.RIGHT, border = 10)
                hbox.Add (ctrl, proportion = 1)
                sizer.Add (hbox, flag = wx.EXPAND)
                # salva na lista, pra podermos pegar depois
                self.campos.append ((c[0], ctrl))

        # nosso botão de inserir tupla
        addButton = wx.Button (self, self.ID_INSERT, label = 'Inserir')
        sizer.Add ((-1, 20))
        sizer.Add (addButton, flag = wx.ALIGN_CENTER)
        self.Bind (wx.EVT_BUTTON, self.insere, id = self.ID_INSERT)

    def atualizaFks (self, event):
        """Ao selecionar uma FK, completa os campos relacionados"""
        campos = event.GetString ().split (', ')
        for i, ctrl in enumerate (self.fkCtrlList[self.ID_FK - event.GetId ()]):
            valor = campos[i]
            if type (ctrl) is IntCtrl:
                valor = int (valor)
            ctrl.SetValue (valor)

    def refresh (self):
        """Atualiza os campos de FKs"""
        pass

    def insere (self, event):
        # colunas e valores a inserir
        colunas = []
        valores = []
        for c in self.campos:
            colunas.append (c[0])
            # formata a entrada dependendo do tipo
            if type (c[1]) is wx.Choice:
                valor = "'" + c[1].GetString (c[1].GetSelection ()) + "'"
            elif type (c[1]) is IntCtrl or type (c[1]) is sequenceCtrl:
                valor = str (c[1].GetValue ())
            elif type (c[1]) is wx.DatePickerCtrl:
                valor = "TO_DATE ('" + c[1].GetValue ().FormatISODate () + "', 'yyyy-mm-dd')"
            else:
                valor = "'" + c[1].GetValue () + "'"
            valores.append (valor)

        try:
            self.db.insert (self.tabela, colunas, valores)
            wx.MessageBox ("Tupla inserida!", "Inserção", wx.CENTRE + wx.OK)
            app = self.GetParent ().GetParent ().GetParent ()
            app.SetStatusText ("Tupla inserida")
            app.algoMudou ()
        except Exception as e:
            wx.MessageBox (str (e), "Erro de inserção", wx.CENTRE + wx.ICON_ERROR + wx.OK)

