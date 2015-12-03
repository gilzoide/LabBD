/**
 * SCC0241 - Laboratório de Bases de Dados - Turma 3
 * Trabalho Prático 4
 *
 * Gil Barbosa Reis 8532248
 * Raul Zaninetti Rosa 8517310
 *
 * Script Subprograma
 */
/*
para executar corretamente :
1 - criação de  tabelas
2 - criação dos gatilhos
3 - inserção de dados
4 - execução de funções e procedimentos
*/
/* Funcao que recebe uma data de nascimento e um intervalo de anos e verifica
  se a pessoa com aquela data de nascimento tem a idade entre o intervalo setado */
CREATE OR REPLACE FUNCTION idade_candidato
    (dataNasc IN DATE,
    idadeInicio IN NUMBER,
    idadeFim IN NUMBER)
    RETURN NUMBER
IS
  dia NUMBER;
  mes NUMBER;
  ano NUMBER;
  anoAtual NUMBER;
  mesAtual NUMBER;
  diaAtual NUMBER;
  saida NUMBER;
BEGIN  
  dia := EXTRACT(DAY FROM dataNasc);
  mes := EXTRACT(MONTH FROM dataNasc);
  ano := EXTRACT(YEAR FROM dataNasc);

  diaAtual := EXTRACT(DAY FROM SYSDATE);
  mesAtual := EXTRACT(MONTH FROM SYSDATE);
  anoAtual := EXTRACT(YEAR FROM SYSDATE);
 
  anoAtual := anoAtual - ano;

  IF (((diaAtual - dia) < 0) AND ((mesAtual - mes) = 0)) OR ((mesAtual - mes) < 0)
    THEN anoAtual := anoAtual - 1;
  END IF;

  IF anoAtual >= idadeInicio AND anoAtual <= idadeFim
    THEN saida := 1;
  ELSE
    saida := 0;
  END IF;
  RETURN saida;
END idade_candidato;
/

/* Calcula o desvio padrão dos votos de todos os candidatos */
CREATE OR REPLACE FUNCTION desvio_padrao
    (idadeInicial IN NUMBER,
     idadeFinal IN NUMBER)
   RETURN NUMBER
IS
saida NUMBER;
media NUMBER;
somatorio NUMBER;
qtd NUMBER;
CURSOR cursor_candidato IS
  SELECT nroVotos FROM candidato JOIN pessoa ON candidato.nroTitEleitor = pessoa.nroTitEleitor
    WHERE idade_candidato(pessoa.dataNasc, idadeInicial, idadeFinal) = 1;
  variavel_cursor cursor_candidato%Rowtype;
BEGIN
somatorio := 0;
SELECT AVG(nroVotos) INTO media FROM candidato  JOIN pessoa ON candidato.nroTitEleitor = pessoa.nroTitEleitor
    WHERE idade_candidato(pessoa.dataNasc, idadeInicial, idadeFinal) = 1;
OPEN cursor_candidato;
LOOP
  FETCH cursor_candidato INTO variavel_cursor;
  EXIT WHEN cursor_candidato%NotFound;
  somatorio := somatorio + POWER((variavel_cursor.nroVotos - media),2);
END LOOP;
SELECT COUNT(candidato.nroTitEleitor) INTO qtd FROM candidato JOIN pessoa ON candidato.nroTitEleitor = pessoa.nroTitEleitor
    WHERE idade_candidato(pessoa.dataNasc, idadeInicial, idadeFinal) = 1;

saida := POWER(somatorio/(qtd - 1),0.5);
CLOSE cursor_candidato;
saida := ROUND(saida,10);
RETURN saida;
EXCEPTION
  WHEN ZERO_DIVIDE
    THEN RETURN 0;
END desvio_padrao;
/

/* Gera um relatório contendo informações sobre candidatos com idade entre idadeInicial e idadeFinal anos, e a soma e média de votos por candidato */
CREATE OR REPLACE PACKAGE relatorios IS
  PROCEDURE gera_relatorio (idadeInicial IN NUMBER, idadeFinal IN NUMBER);
END relatorios;
/

CREATE OR REPLACE PACKAGE BODY relatorios IS

  PROCEDURE gera_relatorio
    (idadeInicial IN NUMBER,
     idadeFinal IN NUMBER)
  IS
  dataNasc DATE;
  numero_votos NUMBER;
  media_votos NUMBER;
  CURSOR cursor_candidato IS
    SELECT pessoa.nomePessoa, candidato.nomeFantasia, pessoa.endPessoa, pessoa.dataNasc
      FROM pessoa JOIN candidato ON candidato.nroTitEleitor = pessoa.nroTitEleitor
      WHERE idade_candidato(pessoa.dataNasc, idadeInicial, IdadeFinal) = 1;
  variavel_cursor cursor_candidato%Rowtype;
  
  BEGIN
   dbms_output.put_line('--------------------------------------------------------------------------------------------------------------');
    SELECT COALESCE(SUM(candidato.nroVotos),0) INTO numero_votos FROM candidato JOIN pessoa ON candidato.nroTitEleitor = pessoa.nroTitEleitor
      WHERE idade_candidato(pessoa.dataNasc, idadeInicial, IdadeFinal) = 1;
    SELECT COALESCE(AVG(candidato.nroVotos),0) INTO media_votos FROM candidato JOIN pessoa ON candidato.nroTitEleitor = pessoa.nroTitEleitor
      WHERE idade_candidato(pessoa.dataNasc, idadeInicial, IdadeFinal) = 1;
  
    dbms_output.put_line( RPAD ('Nome Candidato', 40) || RPAD ('Nome Fantasia', 30) || RPAD ('Endereço', 25) || 'Data Nascimento');
    dbms_output.put_line('______________________________________________________________________________________________________________');
    OPEN cursor_candidato;
    LOOP
      FETCH cursor_candidato INTO variavel_cursor;
      EXIT WHEN cursor_candidato%NotFound;
      dbms_output.put_line(RPAD (variavel_cursor.nomePessoa, 40) || RPAD (COALESCE (variavel_cursor.nomeFantasia, ' '), 30) || RPAD (variavel_cursor.endPessoa, 25) || variavel_cursor.dataNasc);
    END LOOP;
    CLOSE cursor_candidato;
    dbms_output.put_line('______________________________________________________________________________________________________________');
    dbms_output.put_line('Numero total de votos: ' || RPAD (numero_votos, 16) || ' Média de votos: ' || RTRIM (RPAD (ROUND(media_votos,10), 13), '0') || ' Desvio Padrão: ' || RTRIM (RPAD (desvio_padrao(idadeInicial, idadeFinal), 25), '0'));
    dbms_output.put_line('--------------------------------------------------------------------------------------------------------------');
    dbms_output.put_line(' ');
    dbms_output.put_line(' ');
  END;
END;
/

/*chama o procedure para diferentes faixas etárias */
/* Saida Esperada
--------------------------------------------------------------------------------------------------------------
Nome Candidato                          Nome Fantasia                 Endereço                 Data Nascimento
_____________________________________________________________________________________________________________
_____________________________________________________________________________________________________________
Numero total de votos: 0                Média de votos: 0             Desvio Padrão: 0                        
--------------------------------------------------------------------------------------------------------------
 
 
--------------------------------------------------------------------------------------------------------------
Nome Candidato                          Nome Fantasia                 Endereço                 Data Nascimento
_____________________________________________________________________________________________________________
Abilio Clemente Filho                   Seu Juca                      Santos, SP               10-APR-71
Alberto Aleixo                          Florzita                      Rio de Janeiro, RJ       07-AUG-75
Alfeu de Alc�ntara Monteiro                                           Canoas, RS               04-APR-64
Amaro Lu�z de Carvalho                  Pa�oca                        Recife, PE               22-AUG-71
_____________________________________________________________________________________________________________
Numero total de votos: 9                Média de votos: 2.25          Desvio Padrão: 1.5                      
--------------------------------------------------------------------------------------------------------------
 
 
--------------------------------------------------------------------------------------------------------------
Nome Candidato                          Nome Fantasia                 Endereço                 Data Nascimento
_____________________________________________________________________________________________________________
Abelardo Rausch Alcantara               Z� da Padaria                 Teofilo Otoni, MG        05-AUG-27
Aderval Alves Coqueiro                  Cumpadi Weslei                Aracatu, BA              18-JUL-37
Adriano Fonseca Filho                                                 Ponte Nova, MG           18-DEC-45
Afonso Henrique Martins Saldanha        Marlene                       Olinda, PE               22-SEP-18
Albertino Jose de Oliveira              Lindita                       Engenho Sao Jose, PE     05-AUG-27
Alceri Maria Gomes da Silva             Docita                        Porto Alegre, RS         25-MAY-43
Aldo de Sa Brito Souza Neto                                           Rio de Janeiro, RJ       20-JAN-51
Alex de Paula Xavier Pereira            M�e Joana                     Rio de Janeiro, RJ       09-AUG-49
Alexander Jose Ibsen Voeroes            Lambreta                      Sorocaba, SP             05-AUG-27
Alexandre Vannucchi Leme                Cunha                         Santiago, Chile          05-JUL-52
Almir Cust�dio de Lima                                                Recife, PE               24-MAY-50
Alu�sio Palhano Pedreira Ferreira       Dona Marina                   Piraju�, SP              05-SEP-22
Ana Maria Nacinovic Corr�a              Patati                        Rio de Janeiro, RJ       25-MAR-47
_____________________________________________________________________________________________________________
Numero total de votos: 41               Média de votos: 3.1538461538  Desvio Padrão: 1.4632243987             
--------------------------------------------------------------------------------------------------------------
*/
set serveroutput on;
DECLARE
BEGIN
  relatorios.gera_relatorio(10, 30);
  relatorios.gera_relatorio(40, 60);
  relatorios.gera_relatorio(60, 100);
END;
/


CREATE OR REPLACE PROCEDURE gera_relatorio2
  (escolaridade2 IN VARCHAR2)
IS
  CURSOR cursor_pessoa IS
    SELECT pessoa.nomePessoa, pessoa.endPessoa, pessoa.dataNasc
      FROM pessoa WHERE pessoa.escolaridade = escolaridade2;
  variavel_cursor cursor_pessoa%Rowtype;
  contador_tipo NUMBER;
  contador_total NUMBER;
BEGIN
    SELECT COUNT(pessoa.nroTitEleitor) INTO contador_tipo FROM pessoa WHERE pessoa.escolaridade = escolaridade2;
      
  SELECT COUNT(pessoa.nroTitEleitor) INTO contador_total 
      FROM pessoa;
  dbms_output.put_line('Lista de eleitores com escolaridade : ' || escolaridade2);
  dbms_output.put_line( RPAD ('Nome Pessoa', 40) || RPAD ('Endereço', 25) || 'Data Nascimento');
  dbms_output.put_line('______________________________________________________________________________________________________________');       
  OPEN cursor_pessoa;
    LOOP
    FETCH cursor_pessoa INTO variavel_cursor;
    EXIT WHEN cursor_pessoa%NotFound;
    dbms_output.put_line(RPAD (variavel_cursor.nomePessoa, 40)  || RPAD (variavel_cursor.endPessoa, 25) || variavel_cursor.dataNasc);
  END LOOP;
  CLOSE cursor_pessoa;
  dbms_output.put_line('______________________________________________________________________________________________________________');
  dbms_output.put_line('Numero total de pessoas: ' || RPAD (contador_total, 16) || ' Numero de pessoas com ' || escolaridade2 ||' : ' || RTRIM (RPAD (ROUND(contador_tipo,10), 13), '0'));
  dbms_output.put_line('--------------------------------------------------------------------------------------------------------------');
  dbms_output.put_line(' ');
  dbms_output.put_line(' ');
END gera_relatorio2;
/

set serveroutput on;
DECLARE
BEGIN
gera_relatorio2('ensino medio');
END;
/