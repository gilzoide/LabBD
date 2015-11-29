# coding: utf-8

import wx

class tableInserter (wx.Panel):
    def __init__ (self, parent, id, position, size, db, tableName):
        wx.Panel.__init__ (self, parent, id, position, size)
        self.db = db
        colunas = self.db.getTableInfo (tableName)

        sizer = wx.BoxSizer (wx.VERTICAL)
        self.SetSizer (sizer)
        for c in colunas:
            txt = wx.StaticText (self, wx.ID_ANY, c[0])
            txtCtrl = wx.TextCtrl (self)
            hbox = wx.BoxSizer (wx.HORIZONTAL)
            hbox.Add (txt, flag = wx.RIGHT, border = 10)
            hbox.Add (txtCtrl, proportion = 1)
            sizer.Add (hbox, flag = wx.EXPAND, proportion = 1)


