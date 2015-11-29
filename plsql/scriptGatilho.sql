/**
 * SCC0241 - Laboratório de Bases de Dados - Turma 3
 * Trabalho Prático 4
 *
 * Gil Barbosa Reis 8532248
 * Raul Zaninetti Rosa 8517310
 *
 * Script Gatilho
 */

--primeiros gatilhos
/*
para executar corretamente :
1 - criação de  tabelas
2 - criação dos gatilhos
3 - inserção de dados
4 - execução de funções e procedimentos
*/
/* Trigger que atualiza o atributo nroVotos da tabela VotoCandidato */
CREATE OR REPLACE TRIGGER atualiza_voto_candidato
  AFTER INSERT OR DELETE ON votoCandidato
  REFERENCING OLD AS antigo NEW AS novo
  FOR EACH ROW
  BEGIN
  IF inserting
  THEN UPDATE candidato SET nroVotos = nroVotos + 1
    WHERE :novo.nroTitEleitor = candidato.nroTitEleitor;
  ELSIF deleting
  THEN UPDATE candidato SET nroVotos = nroVotos - 1
    WHERE :antigo.nroTitEleitor = candidato.nroTitEleitor;
  END IF;
END;
/

/* Trigger que atualiza o atributo nroVotosP da tabela VotoPartido */
CREATE OR REPLACE TRIGGER atualiza_voto_partido
  AFTER INSERT OR DELETE ON votoPartido
  REFERENCING OLD AS antigo NEW AS novo
  FOR EACH ROW
  BEGIN
  IF inserting
  THEN UPDATE partido SET nroVotosP = nroVotosP + 1
    WHERE :novo.nroPartido = partido.nroPartido;
  ELSIF deleting
  THEN UPDATE partido SET nroVotosP = nroVotosP - 1
    WHERE :antigo.nroPartido = partido.nroPartido;
  END IF;
END;
/

/* Trigger que atualiza o atributo qtdEleitoresZ da table Zona quando modificando uma Pessoa */
CREATE OR REPLACE TRIGGER atualiza_pessoa_zona
  AFTER INSERT OR DELETE OR UPDATE OF nroZona,estadoZona
  ON pessoa
  REFERENCING OLD AS antigo NEW AS novo
  FOR EACH ROW
  BEGIN
  IF inserting
    THEN UPDATE zona SET qtdEleitoresZ = qtdEleitoresZ + 1
      WHERE :novo.nroZona = zona.nroZona
      AND :novo.estadoZona = zona.estadoZona;
  ELSIF deleting
    THEN UPDATE zona SET qtdEleitoresZ = qtdEleitoresZ - 1
       WHERE :antigo.nroZona = zona.nroZona
       AND :antigo.estadoZona = zona.estadoZona;
  ELSIF updating THEN
    IF :novo.nroZona <> :antigo.nroZona
       THEN UPDATE zona SET qtdEleitoresZ = qtdEleitoresZ + 1
           WHERE :novo.nroZona = zona.nroZona
           AND :novo.estadoZona = zona.estadoZona;
        UPDATE zona SET qtdEleitoresZ = qtdEleitoresZ - 1
           WHERE :antigo.nroZona = zona.nroZona
           AND :antigo.estadoZona = zona.estadoZona;
    END IF;
    IF :novo.estadoZona <> :antigo.estadoZona
       THEN UPDATE zona SET qtdEleitoresZ = qtdEleitoresZ + 1
           WHERE :novo.nroZona = zona.nroZona
           AND :novo.estadoZona = zona.estadoZona;
        UPDATE zona SET qtdEleitoresZ = qtdEleitoresZ - 1
           WHERE :antigo.nroZona = zona.nroZona
           AND :antigo.estadoZona = zona.estadoZona;
    END IF;
  END IF;
END;
/

/* Trigger que atualiza o atributo qtdEleitoresS da table Secao quando modificando uma Pessoa */
CREATE OR REPLACE TRIGGER atualiza_pessoa_secao
  AFTER INSERT OR DELETE OR UPDATE OF nroZona,estadoZona, nroSecao
  ON pessoa
  REFERENCING OLD AS antigo NEW AS novo
  FOR EACH ROW
  BEGIN
  IF inserting
    THEN UPDATE secao SET qtdEleitoresS = qtdEleitoresS + 1
      WHERE :novo.nroZona = secao.nroZona
      AND :novo.estadoZona = secao.estadoZona
      AND :novo.nroSecao = secao.nroSecao;
  ELSIF deleting
    THEN UPDATE secao SET qtdEleitoresS = qtdEleitoresS - 1
       WHERE :antigo.nroZona = secao.nroZona
       AND :antigo.estadoZona = secao.estadoZona
       AND :antigo.nroSecao = secao.nroSecao;
  ELSIF updating THEN
    IF :novo.nroZona <> :antigo.nroZona
       THEN UPDATE secao SET qtdEleitoresS = qtdEleitoresS + 1
           WHERE :novo.nroZona = secao.nroZona
           AND :novo.estadoZona = secao.estadoZona
           AND :novo.nroSecao = secao.nroSecao;
        UPDATE secao SET qtdEleitoresS = qtdEleitoresS - 1
           WHERE :antigo.nroZona = secao.nroZona
           AND :antigo.estadoZona = secao.estadoZona
           AND :antigo.nroSecao = secao.nroSecao;
    END IF;
    IF :novo.estadoZona <> :antigo.estadoZona
       THEN UPDATE secao SET qtdEleitoresS = qtdEleitoresS + 1
           WHERE :novo.nroZona = secao.nroZona
           AND :novo.estadoZona = secao.estadoZona
           AND :novo.nroSecao = secao.nroSecao;
        UPDATE secao SET qtdEleitoresS = qtdEleitoresS - 1
           WHERE :antigo.nroZona = secao.nroZona
           AND :antigo.estadoZona = secao.estadoZona
           AND :antigo.nroSecao = secao.nroSecao;
    END IF;
    IF :novo.nroSecao <> :antigo.nroSecao
       THEN UPDATE secao SET qtdEleitoresS = qtdEleitoresS + 1
           WHERE :novo.nroZona = secao.nroZona
           AND :novo.estadoZona = secao.estadoZona
           AND :novo.nroSecao = secao.nroSecao;
        UPDATE secao SET qtdEleitoresS = qtdEleitoresS - 1
           WHERE :antigo.nroZona = secao.nroZona
           AND :antigo.estadoZona = secao.estadoZona
           AND :antigo.nroSecao = secao.nroSecao;
    END IF;
  END IF;
END;
/
/* selects para mostrar que os gatilhos funcionaram
  precisam ser rodados depois de dar os inserts */
  SELECT nroVotosP FROM partido;
  SELECT nroVotos FROM candidato;
  SELECT qtdEleitoresZ FROM zona;
  SELECT qtdEleitoresS FROM secao;


 



--gatilho de tabela mutante

/* criação de um gatilho comum que gera tabela mutante
O gatilho tenta ao mesmo tempo que esta sendo inserido na tabela urna um tipo de urna manual, transformá-la em automática usando o comando update (gerando assim tabela mutante ao tentar inserir). */
CREATE OR REPLACE TRIGGER atualiza_urna AFTER INSERT ON urna
FOR EACH ROW
BEGIN
    IF :new.tipoUrna = 'manual' THEN
      UPDATE urna
      SET tipoUrna = 'automatico'
      WHERE nroZona = :new.nroZona
      AND estadoZona = :new.estadoZona
      AND nroSecao = :new.nroSecao
      AND nroUrna = :new.nroUrna
      AND modelo = :new.modelo;
    END IF;
END;
/
--tentar inserir uma nova tupla na tabela urna para mostrar o erro de tabela mutante
INSERT INTO urna VALUES(1,'SP',1,20,'A','manual');

-- drop nesse trigger para poder criar o proximo
DROP TRIGGER atualiza_urna;

--gatilho que resolve o problema de tabela mutante
CREATE OR REPLACE TRIGGER atualiza_urnac FOR INSERT ON urna
COMPOUND TRIGGER
  aux_nroZona urna.nroZona%TYPE;
  aux_estadoZona urna.estadoZona%TYPE;
  aux_nroSecao urna.nroSecao%TYPE;
  aux_nroUrna urna.nroUrna%TYPE;
  aux_modelo urna.modelo%TYPE;
AFTER EACH ROW IS
BEGIN
  IF :new.tipoUrna = 'manual' THEN
    dbms_output.put_line('show manual');
    aux_nroZona := :new.nroZona;
    aux_estadoZona := :new.estadoZona;
    aux_nroSecao := :new.nroSecao;
    aux_nroUrna := :new.nroUrna;
    aux_modelo := :new.modelo;
  END IF;
END AFTER EACH ROW;
AFTER STATEMENT IS
BEGIN
  dbms_output.put_line('show show');
    UPDATE urna
    SET tipoUrna = 'eletronica'
    WHERE nroZona = aux_nroZona
    AND estadoZona = aux_estadoZona
    AND nroSecao = aux_nroSecao     
    AND nroUrna = aux_nroUrna
    AND modelo = aux_modelo;
END AFTER STATEMENT;
END;
/
/*faz a mesma inserção tentada la em cima. porém agora ela funciona e faz a atualização de urna manual para automática */ 
INSERT INTO urna VALUES(1,'SP',1,20,'A','manual');

--select para mostrar que o insert funcionou certo
SELECT nroZona, estadoZona, nroSecao, nroUrna, modelo, tipoUrna FROM urna;

--resultado do select 
/*
1    SP    1    1    A    eletronica
2    SP    2    2    A    manual
3    SP    3    3    A    eletronica
1    SP    4    4    A    manual
2    SP    5    5    A    eletronica
3    SP    6    6    A    manual
1    SP    7    7    B    eletronica
2    SP    2    8    B    manual
3    SP    3    9    B    eletronica
1    SP    4    10    A    manual
2    SP    5    11    A    eletronica
3    SP    6    12    A    manual
1    SP    7    13    B    eletronica
2    SP    5    14    B    manual
3    SP    6    15    B    eletronica
1    SP    7    16    C    manual
1    SP    1    20    A    automatica */
