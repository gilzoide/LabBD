-- 4. Liste os nomes e nomes fantasia dos candidatos do estado de
-- São Paulo que possuem vice
SELECT P.nomePessoa AS "Nome", C.nomeFantasia AS "Nome Fantasia"
  FROM Candidato C
    JOIN Pessoa P ON C.nroTitEleitor = P.nroTitEleitor
  WHERE P.estadoZona = 'SP'
    AND EXISTS (
      SELECT *
        FROM EhViceDe E
        WHERE E.nroTitEleitorPrincipal = C.nroTitEleitor
    );
