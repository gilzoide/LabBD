-- 1. Liste os nomes e nomes fantasia dos candidatos que tiveram votos
--    registrados em todas as zonas eleitorais. (divisão,minus)
SELECT P.nomePessoa AS "Nome", C.nomeFantasia AS "Nome Fantasia"
  FROM Candidato C
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
  );

-- 2. Listar nome das pessoas que tenham filiação no partido PDB ou PMG e zona
--    eleitoral seja igual a 1 ou 2.(in)
SELECT pessoa.nomePessoa AS "Nome" 
  FROM pessoa
    JOIN filia ON pessoa.nroTitEleitor = filia.nroTitEleitor
    JOIN partido ON filia.nroPartido = partido.nroPartido
  WHERE partido.siglaPartido IN ('PMG','PDB') AND pessoa.nroZona IN(1,2);


-- 3. Listar por escolaridade a quantidade de pessoas em cada cargo que tenham
--    como localSecao = ‘Sala 1’.(rollup)
SELECT  pessoa.escolaridade AS "Escolaridade",funcionario.cargoFunc AS "Cargo", COUNT(pessoa.nroTitEleitor) AS "Numero de Pessoas"
  FROM pessoa
    JOIN funcionario ON pessoa.nroTitEleitor = funcionario.nroTitEleitor
    JOIN secao ON secao.nroSecao = funcionario.nroSecao
  WHERE secao.localSecao = 'Sala 1'
  GROUP BY ROLLUP(pessoa.escolaridade, funcionario.cargoFunc);


-- 4. Liste os nomes e nomes fantasia dos candidatos do estado de São Paulo
--    que possuem vice. (exists)
SELECT P.nomePessoa AS "Nome", C.nomeFantasia AS "Nome Fantasia"
  FROM Candidato C
    JOIN Pessoa P ON C.nroTitEleitor = P.nroTitEleitor
  WHERE P.estadoZona = 'SP'
    AND EXISTS (
      SELECT *
        FROM EhViceDe E
        WHERE E.nroTitEleitorPrincipal = C.nroTitEleitor
    );


-- 5. Liste a soma de votos a candidatos por partido, para partidos com
--    mais de 20 votos. (sum/group by/having)
SELECT P.siglaPartido AS "Partido", SUM (C.nroVotos) AS "Número de Votos"
  FROM Candidato C
    JOIN VotoCandidato V ON C.nroTitEleitor = V.nroTitEleitor
    JOIN Filia F ON C.nroTitEleitor = F.nroTitEleitor
    JOIN Partido P ON F.nroPartido = P.nroPartido
  GROUP BY P.siglaPartido, P.nroVotosP
  HAVING SUM (C.nroVotos) >= 20
  ORDER BY SUM (C.nroVotos) DESC;
