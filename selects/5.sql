-- 5. Liste a soma de votos a candidatos por partido, para partidos
-- com mais de 20 votos
SELECT P.siglaPartido AS "Partido", SUM (C.nroVotos) AS "Número de Votos"
  FROM Candidato C
    JOIN VotoCandidato V ON C.nroTitEleitor = V.nroTitEleitor
    JOIN Filia F ON C.nroTitEleitor = F.nroTitEleitor
    JOIN Partido P ON F.nroPartido = P.nroPartido
  GROUP BY P.siglaPartido, P.nroVotosP
  HAVING SUM (C.nroVotos) >= 20
  ORDER BY SUM (C.nroVotos) DESC;
