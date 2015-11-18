
/**
 * SCC0241 - Laboratório de Bases de Dados - Turma 3
 * Trabalho Prático 3
 *
 * Gil Barbosa Reis 8532248
 * Raul Zaninetti Rosa 8517310
 *
 * Script PL-SQL
 */


--atualização de tabela
/*  Esse bloco de PL/SQL atualiza todos os atributos derivados necessários
  RESULTADO:
  Número de eleitores nas zonas atualizado
  Número de eleitores nas seções atualizado
  Número de votos a candidatos atualizado
  Número de votos a partidos atualizado
*/
BEGIN
  -- Atualiza a quantidade de eleitores das Zonas
  -- 
  -- Quantidade de eleitores nas Zonas é calculada a partir da
  -- junção entre as tabelas Pessoa e Zona, onde é usada a função
  -- 'COUNT' para contabilizar quantas pessoas votam em uma determinada Zona
  UPDATE Zona Z
    SET Z.qtdEleitoresZ = (
      SELECT COUNT (*)
        FROM Pessoa P JOIN Zona ZZ ON P.nroZona = ZZ.nroZona
          AND P.estadoZona = ZZ.estadoZona
        WHERE Z.nroZona = ZZ.nroZona
      );
  dbms_output.put_line ('Número de eleitores nas zonas atualizado');
  
  -- Atualiza a quantidade de eleitores das Seções
  -- 
  -- Quantidade de eleitores nas Seções é calculada a partir da
  -- junção entre as tabelas Pessoa e Secao, onde é usada a função
  -- 'COUNT' para contabilizar quantas pessoas votam em uma determinada Seção
  UPDATE Secao S
    SET S.qtdEleitoresS = (
      SELECT COUNT (*)
        FROM Pessoa P JOIN Secao SS ON P.nroZona = SS.nroZona
          AND P.estadoZona = SS.estadoZona
          AND P.nroSecao = SS.nroSecao
        WHERE S.nroSecao = SS.nroSecao
      );
  dbms_output.put_line ('Número de eleitores nas seções atualizado');
      
  -- Atualiza a quantidade de votos de cada Candidato
  --
  -- Quantidade de votos de cada Candidato é calculada a partir da
  -- junção entre as tabelas VotoCandidato e Candidato, onde é usada a função
  -- 'COUNT' para contabilizar quantos votos cada Candidato recebeu
  UPDATE Candidato C
    SET C.nroVotos = (
      SELECT COUNT (*)
        FROM VotoCandidato V JOIN Candidato CC ON V.nroTitEleitor = CC.nroTitEleitor
        WHERE C.nroTitEleitor = CC.nroTitEleitor
    );
  dbms_output.put_line ('Número de votos a candidatos atualizado');
  
  -- Atualiza a quantidade de votos de cada Partido
  --
  -- Quantidade de votos de cada Partido é calculada a partir da
  -- junção entre as tabelas VotoPartido e Partido, onde é usada a função
  -- 'COUNT' para contabilizar quantos votos cada Partido recebeu
  UPDATE Partido P
    SET P.nroVotosP = (
      SELECT COUNT (*)
        FROM VotoPartido V JOIN Partido PP ON V.nroPartido = PP.nroPartido
        WHERE P.nroPartido = PP.nroPartido
    );
  dbms_output.put_line ('Número de votos a partidos atualizado');
END;

--criação de tabela
/* 
Busco todos os nomes de candidato e seus respectivos nomes fantasia e atribuo uma popularidade para cada um deles.
Popularidade é a porcentagem dos votos de determinado candidato em relação ao total de votos da eleição.
RESULTADO:
Abelardo Rausch Alcantara    Zé da Padaria    8%
Abilio Clemente Filho    Seu Juca    8%
Aderval Alves Coqueiro    Cumpadi Weslei    6%
Adriano Fonseca Filho        10%
Afonso Henrique Martins Saldanha    Marlene    12%
Albertino Jose de Oliveira    Lindita    6%
Alberto Aleixo    Florzita    2%
Alceri Maria Gomes da Silva    Docita    6%
Aldo de Sa Brito Souza Neto        6%
Alex de Paula Xavier Pereira    Mãe Joana    6%
Alexander Jose Ibsen Voeroes    Lambreta    6%
Alexandre Vannucchi Leme    Cunha    4%
Alfeu de Alcântara Monteiro        2%
Almir Custódio de Lima        0%
Aluísio Palhano Pedreira Ferreira    Dona Marina    8%
Amaro Luíz de Carvalho    Paçoca    6%
Ana Maria Nacinovic Corrêa    Patati    4%
*/

DROP TABLE popularidade;
DECLARE
  count_votos NUMBER;
  CURSOR cursor_candidato IS
    SELECT nomeFantasia, nomePessoa, nroVotos 
      FROM candidato JOIN pessoa 
      ON candidato.nroTitEleitor = pessoa.nroTitEleitor;
  nome_candidato cursor_candidato%Rowtype;
  divisao_zero EXCEPTION;
BEGIN
  EXECUTE IMMEDIATE 'CREATE TABLE popularidade (nomePessoa VARCHAR2(50), nomeFantasia VARCHAR2(50), popularidade VARCHAR2(4))';
  SELECT SUM(nroVotos) INTO count_votos FROM candidato; 
  IF count_votos = 0 THEN 
    RAISE divisao_zero;
  END IF;
  OPEN cursor_candidato;
    LOOP
      FETCH cursor_candidato INTO nome_candidato;
      EXIT WHEN cursor_candidato%NotFound;
      EXECUTE IMMEDIATE 'INSERT INTO popularidade VALUES(:b1,:b2,:b3)' USING nome_candidato.nomePessoa, nome_candidato.nomeFantasia, (nome_candidato.nroVotos/count_votos)*100 || '%';
      --dbms_output.put_line(nome_candidato.nomePessoa || ' -> ' || nome_candidato.nomeFantasia);
    END LOOP;
  CLOSE cursor_candidato;
EXCEPTION 
  WHEN divisao_zero 
    THEN dbms_output.put_line('Não é possível fazer a busca pois nao existem votos cadastrados.');
END;
--faz um select para mostrar a tabela
SELECT * FROM popularidade;

/*  
    terceiro problema
    comando pl-sql que busca nome e nome fantasia dos eleitos que tiveram 
    votos em todas as zonas eleitoras e que nao tem nome fantasia nulo
    
    RESULTADO:
    Afonso Henrique Martins Saldanha com o apelido de Marlene
    Alex de Paula Xavier Pereira com o apelido de Mãe Joana

*/
DECLARE
  CURSOR cursor_c IS
    SELECT P.nomePessoa, C.nomeFantasia
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
BEGIN
  FOR linha IN cursor_c
  LOOP
    IF linha.nomeFantasia IS NOT NULL THEN
      dbms_output.put_line(linha.nomePessoa || ' com o apelido de ' || linha.nomeFantasia);
    END IF;
  END LOOP;
END;


