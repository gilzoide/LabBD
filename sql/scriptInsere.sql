DROP SEQUENCE seq_zona;
DROP SEQUENCE seq_secao;
DROP SEQUENCE seq_urna;
DROP SEQUENCE seq_partido;
DROP SEQUENCE seq_votoCandidato;
DROP SEQUENCE seq_votoPartido;

-- Zona: nroZona, estadoZona, endZona, qtdEleitoresZ(derivado)
CREATE SEQUENCE seq_zona START WITH 1;
INSERT INTO zona(nroZona, estadoZona, endZona, qtdEleitoresZ) VALUES (seq_zona.nextval, 'SP', 'RUA JOAO PASSALACQUA, 207,BELA VISTA',0); 
INSERT INTO zona(nroZona, estadoZona, endZona, qtdEleitoresZ) VALUES (seq_zona.nextval, 'SP', 'AV. PAULISTA, 900,BELA VISTA',0); 
INSERT INTO zona(nroZona, estadoZona, endZona, qtdEleitoresZ) VALUES (seq_zona.nextval, 'SP', 'AV. HIGIENOPOLIS, 996, HIGIENOPOLIS',0); 

-- Secao: nroZona, estadoZona, nroSecao, localSecao, qtdEleitoresS(derivado)
CREATE SEQUENCE seq_secao START WITH 1;
INSERT INTO secao(nroZona, estadoZona, nroSecao, localSecao, qtdEleitoresS) VALUES  (1, 'SP', seq_secao.nextval, 'Sala 1',0);
INSERT INTO secao(nroZona, estadoZona, nroSecao, localSecao, qtdEleitoresS) VALUES  (2, 'SP', seq_secao.nextval, 'Sala 2',0);
INSERT INTO secao(nroZona, estadoZona, nroSecao, localSecao, qtdEleitoresS) VALUES  (3, 'SP', seq_secao.nextval, 'Sala 3',0);
INSERT INTO secao(nroZona, estadoZona, nroSecao, localSecao, qtdEleitoresS) VALUES  (1, 'SP', seq_secao.nextval, 'Sala 4',0);
INSERT INTO secao(nroZona, estadoZona, nroSecao, localSecao, qtdEleitoresS) VALUES  (2, 'SP', seq_secao.nextval, 'Sala 5',0);
INSERT INTO secao(nroZona, estadoZona, nroSecao, localSecao, qtdEleitoresS) VALUES  (3, 'SP', seq_secao.nextval, 'Sala 6',0);
INSERT INTO secao(nroZona, estadoZona, nroSecao, localSecao, qtdEleitoresS) VALUES  (1, 'SP', seq_secao.nextval, 'Sala 7',0);

-- Urna: nroZona, estadoZona, nroSecao, nroUrna, modelo, tipoUrna
CREATE SEQUENCE seq_urna START WITH 1;
INSERT INTO urna(nroZona, estadoZona, nroSecao, nroUrna, modelo, tipoUrna) VALUES (1, 'SP', 1, seq_urna.nextval, 'A', 'eletronica');
INSERT INTO urna(nroZona, estadoZona, nroSecao, nroUrna, modelo, tipoUrna) VALUES (2, 'SP', 2, seq_urna.nextval, 'A', 'manual');
INSERT INTO urna(nroZona, estadoZona, nroSecao, nroUrna, modelo, tipoUrna) VALUES (3, 'SP', 3, seq_urna.nextval, 'A', 'eletronica');
INSERT INTO urna(nroZona, estadoZona, nroSecao, nroUrna, modelo, tipoUrna) VALUES (1, 'SP', 4, seq_urna.nextval, 'A', 'manual');
INSERT INTO urna(nroZona, estadoZona, nroSecao, nroUrna, modelo, tipoUrna) VALUES (2, 'SP', 5, seq_urna.nextval, 'A', 'eletronica');
INSERT INTO urna(nroZona, estadoZona, nroSecao, nroUrna, modelo, tipoUrna) VALUES (3, 'SP', 6, seq_urna.nextval, 'A', 'manual');
INSERT INTO urna(nroZona, estadoZona, nroSecao, nroUrna, modelo, tipoUrna) VALUES (1, 'SP', 7, seq_urna.nextval, 'B', 'eletronica');
INSERT INTO urna(nroZona, estadoZona, nroSecao, nroUrna, modelo, tipoUrna) VALUES (2, 'SP', 2, seq_urna.nextval, 'B', 'manual');
INSERT INTO urna(nroZona, estadoZona, nroSecao, nroUrna, modelo, tipoUrna) VALUES (3, 'SP', 3, seq_urna.nextval, 'B', 'eletronica');
INSERT INTO urna(nroZona, estadoZona, nroSecao, nroUrna, modelo, tipoUrna) VALUES (1, 'SP', 4, seq_urna.nextval, 'A', 'manual');
INSERT INTO urna(nroZona, estadoZona, nroSecao, nroUrna, modelo, tipoUrna) VALUES (2, 'SP', 5, seq_urna.nextval, 'A', 'eletronica');
INSERT INTO urna(nroZona, estadoZona, nroSecao, nroUrna, modelo, tipoUrna) VALUES (3, 'SP', 6, seq_urna.nextval, 'A', 'manual');
INSERT INTO urna(nroZona, estadoZona, nroSecao, nroUrna, modelo, tipoUrna) VALUES (1, 'SP', 7, seq_urna.nextval, 'B', 'eletronica');
INSERT INTO urna(nroZona, estadoZona, nroSecao, nroUrna, modelo, tipoUrna) VALUES (2, 'SP', 5, seq_urna.nextval, 'B', 'manual');
INSERT INTO urna(nroZona, estadoZona, nroSecao, nroUrna, modelo, tipoUrna) VALUES (3, 'SP', 6, seq_urna.nextval, 'B', 'eletronica');
INSERT INTO urna(nroZona, estadoZona, nroSecao, nroUrna, modelo, tipoUrna) VALUES (1, 'SP', 7, seq_urna.nextval, 'C', 'manual');

-- Pessoa: nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao
--pessoa
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000001, 'Abelardo Rausch Alcantara', 'Teofilo Otoni, MG', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 1, 'SP', 1);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000002, 'Abilio Clemente Filho', 'Santos, SP', TO_DATE('10/4/1971 ','dd/mm/yyyy'), 'ensino superior', 'fisica', 2, 'SP', 2);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000003, 'Aderval Alves Coqueiro', 'Aracatu, BA', TO_DATE('18/7/1937','dd/mm/yyyy'), 'ensino fundamental', 'fisica', 3, 'SP', 3);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000004, 'Adriano Fonseca Filho', 'Ponte Nova, MG', TO_DATE('18/12/1945','dd/mm/yyyy'), 'ensino superior', 'fisica', 1, 'SP', 4);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000005, 'Afonso Henrique Martins Saldanha', 'Olinda, PE', TO_DATE('22/9/1918','dd/mm/yyyy'), 'ensino superior', 'fisica', 2, 'SP', 5);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000006, 'Albertino Jose de Oliveira', 'Engenho Sao Jose, PE', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 3, 'SP', 6);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000007, 'Alberto Aleixo', 'Rio de Janeiro, RJ', TO_DATE('7/8/1975 ','dd/mm/yyyy'), 'ensino medio', 'fisica', 1, 'SP', 7);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000008, 'Alceri Maria Gomes da Silva', 'Porto Alegre, RS', TO_DATE('25/5/1943','dd/mm/yyyy'), 'ensino fundamental', 'fisica', 2, 'SP', 5);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000009, 'Aldo de Sa Brito Souza Neto', 'Rio de Janeiro, RJ', TO_DATE('20/1/1951','dd/mm/yyyy'), 'ensino superior', 'fisica', 3, 'SP', 3);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000010, 'Alex de Paula Xavier Pereira', 'Rio de Janeiro, RJ', TO_DATE('9/8/1949','dd/mm/yyyy'), 'ensino medio', 'fisica', 1, 'SP', 1);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000011, 'Alexander Jose Ibsen Voeroes', 'Sorocaba, SP', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 2, 'SP', 2);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000012, 'Alexandre Vannucchi Leme', 'Santiago, Chile', TO_DATE('5/7/1952','dd/mm/yyyy'), 'ensino superior', 'fisica', 3, 'SP', 6);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000013, 'Alfeu de Alcântara Monteiro', 'Canoas, RS', TO_DATE('4/4/1964 ','dd/mm/yyyy'), 'ensino fundamental', 'fisica', 2, 'SP', 5);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000014, 'Almir Custódio de Lima', 'Recife, PE', TO_DATE('24/5/1950','dd/mm/yyyy'), 'ensino fundamental', 'fisica', 1, 'SP', 1);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000015, 'Aluísio Palhano Pedreira Ferreira', 'Pirajuí, SP', TO_DATE('5/9/1922','dd/mm/yyyy'), 'ensino superior', 'fisica', 2, 'SP', 2);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000016, 'Amaro Luíz de Carvalho', 'Recife, PE', TO_DATE('22/8/1971 ','dd/mm/yyyy'), 'ensino superior', 'fisica', 2, 'SP', 5);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000017, 'Ana Maria Nacinovic Corrêa', 'Rio de Janeiro, RJ', TO_DATE('25/3/1947','dd/mm/yyyy'), 'ensino superior', 'fisica', 3, 'SP', 3);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000018, 'Ana Rosa Kucinski Silva', 'Sao Paulo, SP', TO_DATE('12/1/1942','dd/mm/yyyy'), 'ensino superior', 'fisica', 2, 'SP', 5);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000019, 'Anatalia de Souza Melo Alves', 'Frutuoso Gomes, PE', TO_DATE('9/7/1945','dd/mm/yyyy'), 'ensino fundamental', 'fisica', 3, 'SP', 6);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000020, 'Andre Grabois', 'Rio de Janeiro, RJ', TO_DATE('3/7/1946','dd/mm/yyyy'), 'ensino medio', 'fisica', 1, 'SP', 7);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000021, 'Angelo Arroyo', 'Sao Paulo, SP', TO_DATE('6/11/1928','dd/mm/yyyy'), 'ensino superior', 'fisica', 1, 'SP', 1);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000022, 'Angelo Cardoso da Silva', 'Porto Alegre, RS ', TO_DATE('23/4/1970','dd/mm/yyyy'), 'ensino fundamental', 'fisica', 3, 'SP', 3);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000023, 'Angelo Pezzuti da Silva', 'Araxa, MG', TO_DATE('27/4/1946','dd/mm/yyyy'), 'ensino medio', 'fisica', 1, 'SP', 4);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000024, 'Antogildo Pacoal Vianna', 'Araxa , MG', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 2, 'SP', 2);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000025, 'Antônio Alfredo de Lima', 'Belo Horizonte, MG', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 2, 'SP', 5);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000026, 'Antônio Benetazzo', 'Sao Paulo, SP', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 1, 'SP', 7);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000027, 'Antônio Carlos Bicalho Lana', 'Sao Paulo, SP', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 3, 'SP', 6);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000028, 'Antônio Carlos Monteiro Teixeira', 'Ribeirao Preto, SP', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 1, 'SP', 1);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000029, 'Antônio Carlos Nogueira Cabral', 'Limeira, SP', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 1, 'SP', 4);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000030, 'Antônio Carlos Silveira Alves', 'Campinas, SP', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 2, 'SP', 2);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000031, 'Antônio de Pádua Costaa', 'Serra Negra, SP', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 3, 'SP', 3);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000032, 'Antônio dos Três Reis Oliveira', 'Ibitinga, SP', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 1, 'SP', 4);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000033, 'Antônio Ferreira Pinto', 'Jacutinga, MG', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 2, 'SP', 5);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000034, 'Antônio Guilherme Ribeiro Ribas', 'Salvador, BA', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 3, 'SP', 6);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000035, 'Antônio Henrique Pereira Neto', 'Salvador, BA', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 1, 'SP', 1);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000036, 'Antônio Joaquim Machado', 'Sao Paulo, SP', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 2, 'SP', 2);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000037, 'Antonio Marcos Pinto de Oliveira', 'Sao Paulo, SP', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 3, 'SP', 3);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000038, 'Antônio Raymundo Lucena', 'Sao Paulo, SP', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 1, 'SP', 4);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000039, 'Antônio Sérgio de Mattos', 'Sao Paulo, SP', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 2, 'SP', 5);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000040, 'Antônio Teodoro de Castro', 'Sao Paulo, SP', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 3, 'SP', 6);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000041, 'Ari da Rocha Miranda', 'Sao Paulo, SP', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 1, 'SP', 7);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000042, 'Ari de Oliveira Mendes Cunha', 'Sao Paulo, SP', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 1, 'SP', 1);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000043, 'Arildo Valadão', 'Teófilo Otoni, MG', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 2, 'SP', 2);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000044, 'Armando Teixeira Frutuosoa', 'Sao Paulo, SP', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 3, 'SP', 3);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000045, 'Arnaldo Cardoso Rocha', 'Sao Paulo, SP', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 1, 'SP', 4);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000046, 'Arno Preis', 'Teófilo Otoni, MG', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 2, 'SP', 5);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000047, 'Ary Abreu Lima da Rosa', 'Sao Paulo, SP', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 3, 'SP', 6);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000048, 'Augusto Soares da Cunha', 'Sao Paulo, SP', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 1, 'SP', 7);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000049, 'Áurea Eliza Pereira Valadão', 'Sao Paulo, SP', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 1, 'SP', 1);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000050, 'Aurora Maria Nascimento Furtado', 'Rio de Janeiro, RJ', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 2, 'SP', 2);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000051, 'Avelmar Moreira de Barros', 'Rio de Janeiro, RJ', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 3, 'SP', 3);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000052, 'Aylton Adalberto Mortati', 'Rio de Janeiro, RJ', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 1, 'SP', 4);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000053, 'Benedito Gonçalves', 'Rio de Janeiro, RJ', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 2, 'SP', 5);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000054, 'Benedito Pereira Serra', 'Rio de Janeiro, RJ', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 3, 'SP', 6);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000055, 'Bergson Gurjão Farias', 'Rio de Janeiro, RJ', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 1, 'SP', 7);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000056, 'Bernardino Saraiva', 'Rio de Janeiro, RJ', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 1, 'SP', 1);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000057, 'Boanerges de Souza Massa', 'Rio de Janeiro, RJ', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 2, 'SP', 2);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000058, 'Caiuby Alves de Castro', 'Rio de Janeiro, RJ', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 3, 'SP', 3);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000059, 'Carlos Alberto Soares de Freitas', 'Rio de Janeiro, RJ', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 1, 'SP', 4);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000060, 'Carlos Eduardo Pires Fleury', 'Rio de Janeiro, RJ', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 2, 'SP', 5);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000061, 'Carlos Lamarca', 'Rio de Janeiro, RJ', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 3, 'SP', 6);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000062, 'Carlos Marighella', 'Salvador, BA', TO_DATE('5/12/1911','dd/mm/yyyy'), 'ensino medio', 'fisica', 1, 'SP', 7);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000063, 'Carlos Nicolau Danielli', 'Rio de Janeiro, RJ', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 1, 'SP', 1);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000064, 'Carlos Roberto Zanirato', 'Rio de Janeiro, RJ', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 2, 'SP', 2);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000065, 'Carlos Schirmer', 'Rio de Janeiro, RJ', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 3, 'SP', 3);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000066, 'Carmem Jacomini', 'Rio de Janeiro, RJ', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 1, 'SP', 4);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000067, 'Cassimiro Luiz de Freitas', 'Rio de Janeiro, RJ', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 2, 'SP', 5);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000068, 'Catarina Abi-Eçab', 'Rio de Janeiro, RJ', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 3, 'SP', 6);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000069, 'Célio Augusto Guedes', 'Teófilo Otoni, MG', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 1, 'SP', 7);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000070, 'Celso Gilberto de Oliveira', 'Belo Horizonte, MG', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 2, 'SP', 2);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000071, 'Chael Charles Schreier', 'Belo Horizonte, MG', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 2, 'SP', 2);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000072, 'Cilon da Cunha Brun', 'Sao Paulo, SP', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 3, 'SP', 3);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000073, 'Ciro Flávio Salasar Oliveira', 'Sao Paulo, SP', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 1, 'SP', 4);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000074, 'Cloves Dias Amorim', 'Sao Paulo, SP', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 2, 'SP', 5);  
INSERT INTO pessoa(nroTitEleitor, nomePessoa, endPessoa, dataNasc, escolaridade, tipoPessoa, nroZona, estadoZona, nroSecao)
  VALUES (000000000075, 'Custódio Saraiva Neto', 'Sao Paulo, SP', TO_DATE('5/8/1927','dd/mm/yyyy'), 'ensino medio', 'fisica', 3, 'SP', 6);  
  
-- Partido: nroPartido, nomePartido, siglaPartido, nroVotosP(derivado)
CREATE SEQUENCE seq_partido START WITH 1;
INSERT INTO Partido (nroPartido, nomePartido, siglaPartido,nroVotosP) VALUES (seq_partido.nextval, 'Partido Legal', 'PL',0);
INSERT INTO Partido (nroPartido, nomePartido, siglaPartido,nroVotosP) VALUES (seq_partido.nextval, 'Partido Maratonista Gentil', 'PMG',0);
INSERT INTO Partido (nroPartido, nomePartido, siglaPartido,nroVotosP) VALUES (seq_partido.nextval, 'Partido Banco de Dados', 'PBD',0);
INSERT INTO Partido (nroPartido, nomePartido, siglaPartido,nroVotosP) VALUES (seq_partido.nextval, 'Partido De Boas', 'PDB',0);
INSERT INTO Partido (nroPartido, nomePartido, siglaPartido,nroVotosP) VALUES (seq_partido.nextval, 'Partido Chocolate e Caramelo', 'PCC',0);
INSERT INTO Partido (nroPartido, nomePartido, siglaPartido,nroVotosP) VALUES (seq_partido.nextval, 'Partido do Trabalho Engrandecedor', 'PTE',0);

-- Filia: nroTitEleitor, nroPartido
INSERT INTO filia(nroTitEleitor, nroPartido) VALUES (000000000001, 1);
INSERT INTO filia(nroTitEleitor, nroPartido) VALUES (000000000002, 2);
INSERT INTO filia(nroTitEleitor, nroPartido) VALUES (000000000003, 3);
INSERT INTO filia(nroTitEleitor, nroPartido) VALUES (000000000004, 4);
INSERT INTO filia(nroTitEleitor, nroPartido) VALUES (000000000005, 5);
INSERT INTO filia(nroTitEleitor, nroPartido) VALUES (000000000006, 6);
INSERT INTO filia(nroTitEleitor, nroPartido) VALUES (000000000007, 1);
INSERT INTO filia(nroTitEleitor, nroPartido) VALUES (000000000008, 2);
INSERT INTO filia(nroTitEleitor, nroPartido) VALUES (000000000009, 3);
INSERT INTO filia(nroTitEleitor, nroPartido) VALUES (000000000010, 4);
INSERT INTO filia(nroTitEleitor, nroPartido) VALUES (000000000011, 5);
INSERT INTO filia(nroTitEleitor, nroPartido) VALUES (000000000012, 6);
INSERT INTO filia(nroTitEleitor, nroPartido) VALUES (000000000013, 1);

-- Candidato: nroTitEleitor, nomeFantasia, nroCandidato, cargoCandidato, nroVotos(derivado)
INSERT INTO Candidato (nroTitEleitor, nomeFantasia, nroCandidato, cargoCandidato,nroVotos) VALUES (1,  'Zé da Padaria',  25630, 'vereador',0);
INSERT INTO Candidato (nroTitEleitor, nomeFantasia, nroCandidato, cargoCandidato,nroVotos) VALUES (2,  'Seu Juca',       43,    'governador',0);
INSERT INTO Candidato (nroTitEleitor, nomeFantasia, nroCandidato, cargoCandidato,nroVotos) VALUES (3,  'Cumpadi Weslei', 25,    'vice-prefeito',0);
INSERT INTO Candidato (nroTitEleitor, nomeFantasia, nroCandidato, cargoCandidato,nroVotos) VALUES (4,  NULL,             85932, 'vereador',0);
INSERT INTO Candidato (nroTitEleitor, nomeFantasia, nroCandidato, cargoCandidato,nroVotos) VALUES (5,  'Marlene',        86,    'vice-presidente',0);
INSERT INTO Candidato (nroTitEleitor, nomeFantasia, nroCandidato, cargoCandidato,nroVotos) VALUES (6,  'Lindita',        25,    'governador',0);
INSERT INTO Candidato (nroTitEleitor, nomeFantasia, nroCandidato, cargoCandidato,nroVotos) VALUES (7,  'Florzita',       25,    'prefeito',0);
INSERT INTO Candidato (nroTitEleitor, nomeFantasia, nroCandidato, cargoCandidato,nroVotos) VALUES (8,  'Docita',         25,    'presidente',0);
INSERT INTO Candidato (nroTitEleitor, nomeFantasia, nroCandidato, cargoCandidato,nroVotos) VALUES (9,  NULL,             43,    'vice-governador',0);
INSERT INTO Candidato (nroTitEleitor, nomeFantasia, nroCandidato, cargoCandidato,nroVotos) VALUES (10, 'Mãe Joana',      42,    'prefeito',0);
INSERT INTO Candidato (nroTitEleitor, nomeFantasia, nroCandidato, cargoCandidato,nroVotos) VALUES (11, 'Lambreta',       86,    'presidente',0);
INSERT INTO Candidato (nroTitEleitor, nomeFantasia, nroCandidato, cargoCandidato,nroVotos) VALUES (12, 'Cunha',          55521, 'vereador',0);
INSERT INTO Candidato (nroTitEleitor, nomeFantasia, nroCandidato, cargoCandidato,nroVotos) VALUES (13, NULL,             97,    'vice-governador',0);
INSERT INTO Candidato (nroTitEleitor, nomeFantasia, nroCandidato, cargoCandidato,nroVotos) VALUES (14, NULL,             97,    'governador',0);
INSERT INTO Candidato (nroTitEleitor, nomeFantasia, nroCandidato, cargoCandidato,nroVotos) VALUES (15, 'Dona Marina',    50,    'prefeito',0);
INSERT INTO Candidato (nroTitEleitor, nomeFantasia, nroCandidato, cargoCandidato,nroVotos) VALUES (16, 'Paçoca',         42,    'vice-prefeito',0);
INSERT INTO Candidato (nroTitEleitor, nomeFantasia, nroCandidato, cargoCandidato,nroVotos) VALUES (17, 'Patati',         30,    'vice-presidente',0);

-- EhViceDe: nroTitEleitorPrincipal, nroTitEleitorVice
INSERT INTO EhViceDe (nroTitEleitorPrincipal, nroTitEleitorVice) VALUES (7, 3);
INSERT INTO EhViceDe (nroTitEleitorPrincipal, nroTitEleitorVice) VALUES (11, 5);
INSERT INTO EhViceDe (nroTitEleitorPrincipal, nroTitEleitorVice) VALUES (9, 2);
INSERT INTO EhViceDe (nroTitEleitorPrincipal, nroTitEleitorVice) VALUES (14, 13);
INSERT INTO EhViceDe (nroTitEleitorPrincipal, nroTitEleitorVice) VALUES (10, 16);
INSERT INTO EhViceDe (nroTitEleitorPrincipal, nroTitEleitorVice) VALUES (8, 17);

-- Funcionario: nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (18, 'presidente', 1, 'SP', 1);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (19, 'mesario',    1, 'SP', 1);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (20, 'mesario',    1, 'SP', 1);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (21, 'secretario', 1, 'SP', 1);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (22, 'secretario', 1, 'SP', 1);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (23, 'suplente',   1, 'SP', 1);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (24, 'presidente', 2, 'SP', 2);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (25, 'mesario',    2, 'SP', 2);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (26, 'mesario',    2, 'SP', 2);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (27, 'secretario', 2, 'SP', 2);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (28, 'secretario', 2, 'SP', 2);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (29, 'suplente',   2, 'SP', 2);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (30, 'presidente', 3, 'SP', 3);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (31, 'mesario',    3, 'SP', 3);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (32, 'mesario',    3, 'SP', 3);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (33, 'secretario', 3, 'SP', 3);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (34, 'secretario', 3, 'SP', 3);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (35, 'suplente',   3, 'SP', 3);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (36, 'presidente', 1, 'SP', 4);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (37, 'mesario',    1, 'SP', 4);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (38, 'mesario',    1, 'SP', 4);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (39, 'secretario', 1, 'SP', 4);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (40, 'secretario', 1, 'SP', 4);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (41, 'suplente',   1, 'SP', 4);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (42, 'presidente', 2, 'SP', 5);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (43, 'mesario',    2, 'SP', 5);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (44, 'mesario',    2, 'SP', 5);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (45, 'secretario', 2, 'SP', 5);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (46, 'secretario', 2, 'SP', 5);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (47, 'suplente',   2, 'SP', 5);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (48, 'presidente', 3, 'SP', 6);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (49, 'mesario',    3, 'SP', 6);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (50, 'mesario',    3, 'SP', 6);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (51, 'secretario', 3, 'SP', 6);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (52, 'secretario', 3, 'SP', 6);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (53, 'suplente',   3, 'SP', 6);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (54, 'presidente', 1, 'SP', 7);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (55, 'mesario',    1, 'SP', 7);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (56, 'mesario',    1, 'SP', 7);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (57, 'secretario', 1, 'SP', 7);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (58, 'secretario', 1, 'SP', 7);
INSERT INTO Funcionario (nroTitEleitor, cargoFunc, nroZona, estadoZona, nroSecao) VALUES (59, 'suplente',   1, 'SP', 7);

-- VotoCandidato: nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC
CREATE SEQUENCE seq_votoCandidato START WITH 1;
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (6,  1, 'SP', 1, 1, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (5,  2, 'SP', 2, 2, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (1,  3, 'SP', 3, 3, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (15, 1, 'SP', 4, 4, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (2,  2, 'SP', 5, 5, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (4,  3, 'SP', 6, 6, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (2,  1, 'SP', 7, 7, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (2,  2, 'SP', 2, 8, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (16, 3, 'SP', 3, 9, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (5,  1, 'SP', 4, 10, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (3,  2, 'SP', 5, 11, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (4,  3, 'SP', 6, 12, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (9,  1, 'SP', 7, 13, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (8,  2, 'SP', 5, 14, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (10, 3, 'SP', 6, 15, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (11, 1, 'SP', 7, 16, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (11, 1, 'SP', 1, 1, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (8,  2, 'SP', 2, 2, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (7,  3, 'SP', 3, 3, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (17, 1, 'SP', 4, 4, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (15, 2, 'SP', 5, 5, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (5,  3, 'SP', 6, 6, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (4,  1, 'SP', 7, 7, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (5,  2, 'SP', 2, 8, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (6,  3, 'SP', 3, 9, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (12, 1, 'SP', 4, 10, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (16, 2, 'SP', 5, 11, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (13, 3, 'SP', 6, 12, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (8,  1, 'SP', 7, 13, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (9,  2, 'SP', 5, 14, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (16, 3, 'SP', 6, 15, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (2,  1, 'SP', 7, 16, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (1,  1, 'SP', 1, 1, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (4,  2, 'SP', 2, 2, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (5,  3, 'SP', 3, 3, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (15, 1, 'SP', 4, 4, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (3,  2, 'SP', 5, 5, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (17, 3, 'SP', 6, 6, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (1,  1, 'SP', 7, 7, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (5,  2, 'SP', 2, 8, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (9,  3, 'SP', 3, 9, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (6,  1, 'SP', 4, 10, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (3,  2, 'SP', 5, 11, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (4,  3, 'SP', 6, 12, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (12, 1, 'SP', 7, 13, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (10, 2, 'SP', 5, 14, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (11, 3, 'SP', 6, 15, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (10, 1, 'SP', 7, 16, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (1,  1, 'SP', 1, 1, seq_votoCandidato.nextval);
INSERT INTO VotoCandidato (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC) VALUES (15, 2, 'SP', 2, 2, seq_votoCandidato.nextval);

-- VotoPartido: nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP
CREATE SEQUENCE seq_votoPartido START WITH 1;
INSERT INTO VotoPartido (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP) VALUES (6, 1, 'SP', 1, 1, seq_votoPartido.nextval);
INSERT INTO VotoPartido (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP) VALUES (5, 2, 'SP', 2, 2, seq_votoPartido.nextval);
INSERT INTO VotoPartido (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP) VALUES (1, 3, 'SP', 3, 3, seq_votoPartido.nextval);
INSERT INTO VotoPartido (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP) VALUES (5, 1, 'SP', 4, 4, seq_votoPartido.nextval);
INSERT INTO VotoPartido (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP) VALUES (2, 2, 'SP', 5, 5, seq_votoPartido.nextval);
INSERT INTO VotoPartido (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP) VALUES (4, 3, 'SP', 6, 6, seq_votoPartido.nextval);
INSERT INTO VotoPartido (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP) VALUES (2, 1, 'SP', 7, 7, seq_votoPartido.nextval);
INSERT INTO VotoPartido (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP) VALUES (2, 2, 'SP', 2, 8, seq_votoPartido.nextval);
INSERT INTO VotoPartido (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP) VALUES (6, 3, 'SP', 3, 9, seq_votoPartido.nextval);
INSERT INTO VotoPartido (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP) VALUES (5, 1, 'SP', 4, 10, seq_votoPartido.nextval);
INSERT INTO VotoPartido (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP) VALUES (3, 2, 'SP', 5, 11, seq_votoPartido.nextval);
INSERT INTO VotoPartido (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP) VALUES (4, 3, 'SP', 6, 12, seq_votoPartido.nextval);
INSERT INTO VotoPartido (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP) VALUES (3, 1, 'SP', 7, 13, seq_votoPartido.nextval);
INSERT INTO VotoPartido (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP) VALUES (4, 2, 'SP', 5, 14, seq_votoPartido.nextval);
INSERT INTO VotoPartido (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP) VALUES (1, 3, 'SP', 6, 15, seq_votoPartido.nextval);
INSERT INTO VotoPartido (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP) VALUES (5, 1, 'SP', 7, 16, seq_votoPartido.nextval);
INSERT INTO VotoPartido (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP) VALUES (2, 1, 'SP', 1, 1, seq_votoPartido.nextval);
INSERT INTO VotoPartido (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP) VALUES (4, 2, 'SP', 2, 2, seq_votoPartido.nextval);
INSERT INTO VotoPartido (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP) VALUES (3, 3, 'SP', 3, 3, seq_votoPartido.nextval);
INSERT INTO VotoPartido (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP) VALUES (1, 1, 'SP', 4, 4, seq_votoPartido.nextval);
INSERT INTO VotoPartido (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP) VALUES (4, 2, 'SP', 5, 5, seq_votoPartido.nextval);
INSERT INTO VotoPartido (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP) VALUES (5, 3, 'SP', 6, 6, seq_votoPartido.nextval);
INSERT INTO VotoPartido (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP) VALUES (4, 1, 'SP', 7, 7, seq_votoPartido.nextval);
INSERT INTO VotoPartido (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP) VALUES (5, 2, 'SP', 2, 8, seq_votoPartido.nextval);
INSERT INTO VotoPartido (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP) VALUES (6, 3, 'SP', 3, 9, seq_votoPartido.nextval);
INSERT INTO VotoPartido (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP) VALUES (2, 1, 'SP', 4, 10, seq_votoPartido.nextval);
INSERT INTO VotoPartido (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP) VALUES (4, 2, 'SP', 5, 11, seq_votoPartido.nextval);
INSERT INTO VotoPartido (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP) VALUES (6, 3, 'SP', 6, 12, seq_votoPartido.nextval);
INSERT INTO VotoPartido (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP) VALUES (1, 1, 'SP', 7, 13, seq_votoPartido.nextval);
INSERT INTO VotoPartido (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP) VALUES (6, 2, 'SP', 5, 14, seq_votoPartido.nextval);
INSERT INTO VotoPartido (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP) VALUES (5, 3, 'SP', 6, 15, seq_votoPartido.nextval);
INSERT INTO VotoPartido (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP) VALUES (2, 1, 'SP', 7, 16, seq_votoPartido.nextval);
INSERT INTO VotoPartido (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP) VALUES (1, 1, 'SP', 1, 1, seq_votoPartido.nextval);
INSERT INTO VotoPartido (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP) VALUES (4, 2, 'SP', 2, 2, seq_votoPartido.nextval);
INSERT INTO VotoPartido (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP) VALUES (5, 3, 'SP', 3, 3, seq_votoPartido.nextval);
