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
