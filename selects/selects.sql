-- Ideias de selects

-- 1. Liste os nomes e nomes fantasia dos candidatos que tiveram votos
-- registrados em todas as zonas eleitorais. (divisão, MINUS)
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

-- 2. listar nome das pessoas que tenham filiação no partido PDB ou PMG e
-- zona eleitoral seja igual a 1 ou 2
SELECT pessoa.nomePessoa AS "Nome" 
  FROM pessoa
    JOIN filia ON pessoa.nroTitEleitor = filia.nroTitEleitor
    JOIN partido ON filia.nroPartido = partido.nroPartido
  WHERE partido.siglaPartido IN ('PMG', 'PDB') AND pessoa.nroZona IN (1, 2);
