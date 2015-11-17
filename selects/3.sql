-- listar por escolaridade a quantidade de pessoas em cada cargo
SELECT pessoa.escolaridade AS "Escolaridade", funcionario.cargoFunc AS "Cargo", COUNT (pessoa.nroTitEleitor) AS "Numero de Pessoas"
  FROM pessoa
    JOIN funcionario ON pessoa.nroTitEleitor = funcionario.nroTitEleitor
  GROUP BY ROLLUP (pessoa.escolaridade, funcionario.cargoFunc);
