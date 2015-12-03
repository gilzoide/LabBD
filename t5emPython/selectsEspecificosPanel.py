# coding: utf-8

import wx
from queryLister import queryLister

class selectsEspecificosPanel (wx.Panel):
    """Painel dos SELECTs específicos, do T2"""

    pesquisas = [
        ('P.nomePessoa, C.nomeFantasia',
"""Candidato C
JOIN Pessoa P ON C.nroTitEleitor = P.nroTitEleitor
WHERE NOT EXISTS (
(SELECT Z.nroZona, Z.estadoZona
FROM Zona Z
)
MINUS
(SELECT Z.nroZona, Z.estadoZona
FROM Zona Z
JOIN VotoCandidato V ON V.nroZona = Z.nroZona AND V.estadoZona = Z.estadoZona
WHERE V.nroTitEleitor = C.nroTitEleitor
)
)""",
        'Nomes e nomes fantasia dos candidatos que tiveram votos registrados em todas as zonas eleitorais'),
        ('Pessoa.nomePessoa',
"""Pessoa
JOIN filia ON pessoa.nroTitEleitor = filia.nroTitEleitor
JOIN partido ON filia.nroPartido = partido.nroPartido
WHERE partido.siglaPartido IN ('PMG','PDB') AND pessoa.nroZona IN(1,2)
""",
        'Nome das pessoas que tenham filiação no partido PDB ou PMG e zona eleitoral seja igual a 1 ou 2'),
        ('pessoa.escolaridade,funcionario.cargoFunc, COUNT(pessoa.nroTitEleitor) AS "Numero de Pessoas"',
"""pessoa
JOIN funcionario ON pessoa.nroTitEleitor = funcionario.nroTitEleitor
JOIN secao ON secao.nroSecao = funcionario.nroSecao
WHERE secao.localSecao = 'Sala 1'
GROUP BY ROLLUP(pessoa.escolaridade, funcionario.cargoFunc)
""",
        "Listagem por escolaridade da quantidade de pessoas em cada cargo que tem como localSecao = 'Sala 1'"),
        ('P.nomePessoa, C.nomeFantasia',
"""Candidato C
JOIN Pessoa P ON C.nroTitEleitor = P.nroTitEleitor
WHERE P.estadoZona = 'SP'
AND EXISTS (
SELECT *
FROM EhViceDe E
WHERE E.nroTitEleitorPrincipal = C.nroTitEleitor
)""",
        "Nomes e nomes fantasia dos candidatos do estado de São Paulo que possuem vice"),
        ('P.siglaPartido, SUM (C.nroVotos) AS "Número de Votos"',
"""Candidato C
JOIN VotoCandidato V ON C.nroTitEleitor = V.nroTitEleitor
JOIN Filia F ON C.nroTitEleitor = F.nroTitEleitor
JOIN Partido P ON F.nroPartido = P.nroPartido
GROUP BY P.siglaPartido, P.nroVotosP
HAVING SUM (C.nroVotos) >= 20
ORDER BY SUM (C.nroVotos) DESC
""",
        "Soma de votos a candidatos por partido, para partidos com mais de 20 votos")
    ]
    def __init__ (self, parent, id = wx.ID_ANY, position = wx.DefaultPosition, size = wx.DefaultSize):
        wx.Panel.__init__ (self, parent, id, position, size)

        self.paginas = []
        # cria o Notebook, cada aba um SELECT
        self.note = wx.Notebook (self, style = wx.NB_TOP, size = size)

        # nossa fonte pra títulos, grandona =]
        fonteTitulo = wx.Font (18, wx.DEFAULT, wx.NORMAL, wx.NORMAL)

        for i, pesquisa in enumerate (self.pesquisas):
            # o painel pra por no Notebook, que não aceita Sizers
            painel = wx.Panel (self.note, size = size)

            vbox = wx.BoxSizer (wx.VERTICAL)
            txt = wx.StaticText (painel, wx.ID_ANY, pesquisa[2])
            txt.SetFont (fonteTitulo)
            txt.Wrap (size.GetWidth ())

            pagina = queryLister (painel)
            pagina.setConsulta (pesquisa[0], pesquisa[1])
            self.paginas.append (pagina)

            vbox.Add (txt, flag = wx.CENTER)
            vbox.Add (pagina, flag = wx.EXPAND, proportion = 1)
            painel.SetSizer (vbox)

            self.note.AddPage (painel, 'Pesquisa ' + str (i))

        self.refresh ()

    def refresh (self):
        """Atualiza as informações das tabelas"""
        for pag in self.paginas:
            pag.refresh ()
