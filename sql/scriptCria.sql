/**
 * SCC0241 - Laborat�rio de Bases de Dados - Turma 3
 * Trabalho Pr�tico 1
 *
 * Gil Barbosa Reis 8532248
 * Raul Zaninetti Rosa 8517310
 *
 * Script de criacao de dados no esquema elei��es
 */


/* Altera configura��es importante da se��o */
ALTER SESSION SET NLS_LANGUAGE= 'PORTUGUESE' NLS_TERRITORY= 'BRAZIL';
ALTER SESSION SET deferred_segment_creation = FALSE;

/* Comandos para remover as tabelas */
DROP TABLE votocandidato;
DROP TABLE votopartido;
DROP TABLE funcionario;
DROP TABLE ehvicede;
DROP TABLE candidato;
DROP TABLE filia;
DROP TABLE partido;
DROP TABLE pessoa;
DROP TABLE urna;
DROP TABLE secao;
DROP TABLE zona;


/**
* Tabela zona
* @nroZona, estadoZona     chave primaria
* @endZona                 endere�o da zona eleitoral
* @qtdEleitoresZ           quantidade de eleitores naquela zona 
* @pk_zona                 restri��o da chave prim�ria
*/
CREATE TABLE zona(
  nroZona NUMBER(5) NOT NULL,
  estadoZona CHAR(2) NOT NULL,
  endZona VARCHAR2(40),
  qtdEleitoresZ NUMBER DEFAULT 0,
  CONSTRAINT pk_zona PRIMARY KEY (nroZona, estadoZona)
);


/**
* Tabela secao
* @nroZona, estadoZona, nroSecao      chave primaria
* @endZona                            endere�o da zona eleitoral
* @localSecao                         localiza��o da secao
* @qtdEleitoresS                      numero de eleitores em uma determinada secao
* @pk_secao                           restri��o da chave prim�ria
* @fk_secao                           restri��o da chave estrangeira vinda da tabela zona
*/

CREATE TABLE secao(
  nroZona NUMBER(5) NOT NULL,
  estadoZona CHAR(2) NOT NULL,
  nroSecao NUMBER(3) NOT NULL,
  localSecao VARCHAR2(30),
  qtdEleitoresS NUMBER DEFAULT 0,
  CONSTRAINT pk_secao PRIMARY KEY (nroZona, estadoZona, nroSecao),
  CONSTRAINT fk_secao FOREIGN KEY (nroZona, estadoZona) REFERENCES zona (nroZona, estadoZona)
);

/**
* Tabela urna
* @nroZona, estadoZona, nroSecao, nroUrna      chave primaria
* @modelo                                      modelo da urna
* @tipoUrna                                    uma urna pode ser do tipo manual ou eletronica
* @pk_urna                                     restri��o da chave prim�ria
* @fk_urna                                     restri��o da chave estrangeira vinda da tabela secao
* @ch_urna                                     checagem se o tipoUrna esta nos tipos permitidos
*/

CREATE TABLE urna(
  nroZona NUMBER(5) NOT NULL,
  estadoZona CHAR(2) NOT NULL,
  nroSecao NUMBER(3) NOT NULL,
  nroUrna NUMBER(10) NOT NULL,
  modelo CHAR(1),
  tipoUrna VARCHAR2(10),
  CONSTRAINT pk_urna PRIMARY KEY (nroZona, estadoZona, nroSecao, nroUrna),
  CONSTRAINT fk_urna FOREIGN KEY (nroZona, estadoZona, nroSecao) REFERENCES secao (nroZona, estadoZona, nroSecao),
  CONSTRAINT ch_urna CHECK (LOWER (tipoUrna) IN ('manual','eletronica'))
);


/**
* Tabela pessoa
* @nroTilEleitor      chave primaria
* @nomePessoa         nome da pessoa cadastrada
* @endPessoa          endere�o da pessoa
* @dataNasc           data de nascimento
* @escolaridade       escolaridade da pessoa
* @tipoPessoa         tipo pessoa
* @nroZona            numero da zona de voto
* @estadoZona         estado que se encontra a zona de votacao
* @nroSecao           numero de secao
* @pk_pessoa          restri��o da chave prim�ria
* @fk_pessoa          restri��o da chave estrangeira vinda da tabela secao
*/

CREATE TABLE pessoa(
  nroTitEleitor NUMBER(12) NOT NULL,
  nomePessoa VARCHAR2(40) NOT NULL,
  endPessoa VARCHAR2(60),
  dataNasc DATE,
  escolaridade VARCHAR2(30),
  tipoPessoa VARCHAR2(20),
  nroZona NUMBER(5),
  estadoZona CHAR(2),
  nroSecao NUMBER(3),
  CONSTRAINT pk_pessoa PRIMARY KEY (nroTitEleitor),
  CONSTRAINT fk_pessoa FOREIGN KEY (nroZona, estadoZona, nroSecao) REFERENCES secao (nroZona, estadoZona, nroSecao)
);

/**
* Tabela partido
* @nroPartido     chave primaria
* @nomePartido    nome do partido
* @siglaPartido   sigla do partido
* @nroVotosP      numero de votos do partido
* @pk_partido     restri��o de chave prim�ria
*/
CREATE TABLE partido(
  nroPartido NUMBER(5) NOT NULL,
  nomePartido VARCHAR2(50) NOT NULL,
  siglaPartido VARCHAR2(4),
  nroVotosP NUMBER DEFAULT 0,
  CONSTRAINT pk_partido PRIMARY KEY (nroPartido)
);

/**
* Tabela  filia
* @nroTitEleitor      chave prim�ria
* @nroPartido         numero do partido
* @pk_filia           restri��o de chave prim�ria
* @fk_filia_eleitor   restri��o de chave estrangeira vinda de pessoa
* @fk_filia_partido   restri��o de chave estrangeira vinda de partido
*/

CREATE TABLE filia(
  nroTitEleitor NUMBER(14) NOT NULL,
  nroPartido NUMBER(5) NOT NULL,
  CONSTRAINT pk_filia PRIMARY KEY (nroTitEleitor),
  CONSTRAINT fk_filia_eleitor FOREIGN KEY (nroTitEleitor) REFERENCES pessoa (nroTitEleitor),
  CONSTRAINT fk_filia_partido FOREIGN KEY (nroPArtido) REFERENCES partido (nroPartido)
);

/**
* Tabela candidato
* @nroTitEleitor    chave primaria
* @nomeFantasia     nome fantasia do candidato
* @nroCandidato     numero candidato
* @cargoCandidato   cargo candidato
* @nroVotos         numero de votos
* @pk_candidato     restri��o de chave primaria
* @fk_candidato     restri��o de chave estrangeira vinda de pessoa
* @ch_candidato     verifica��o se no campo cargoCandidato foi inserido apenas os tipos propostos 
*/
CREATE TABLE candidato(
  nroTitEleitor NUMBER(14) NOT NULL,
  nomeFantasia VARCHAR2(40),
  nroCandidato NUMBER(5) NOT NULL,
  cargoCandidato VARCHAR2(20),
  nroVotos NUMBER DEFAULT 0,
  CONSTRAINT pk_candidato PRIMARY KEY (nroTitEleitor),
  CONSTRAINT fk_candidato FOREIGN KEY (nroTitEleitor) REFERENCES pessoa (nroTitEleitor),
  CONSTRAINT ch_candidato CHECK (LOWER (cargoCandidato) IN ('presidente','vice-presidente','governador','vice-governador','prefeito','vice-prefeito','vereador'))
);

/**
* Tabela ehViceDe
* @nroTitEleitorPrincipal     chave primaria
* @nroTitEleitorVice          numero do titulo de eleitor do vice candidato
* @pk_ehViceDe                restri��o de chave prim�ria
* @fk_ehViceDe_principal      restri��o de chave estrangeira vinda de candidato
* @fk_ehViceDe_vice           restri��o de chave estrangeira vinda de candidato
*/

CREATE TABLE ehViceDe(
  nroTitEleitorPrincipal NUMBER(14) NOT NULL,
  nroTitEleitorVice NUMBER(14) NOT NULL,
  CONSTRAINT pk_ehViceDe PRIMARY KEY (nroTitEleitorPrincipal),
  CONSTRAINT fk_ehViceDe_principal FOREIGN KEY (nroTitEleitorPrincipal) REFERENCES candidato (nroTitEleitor),
  CONSTRAINT fk_ehViceDe_vice FOREIGN KEY (nroTitEleitorVice) REFERENCES candidato (nroTitEleitor)
);

/**
* Tabela funcionario
* @nroTitEleitor            chave primaria
* @cargoFunc               cargo do funcionario
* @nroZona                 numero da zona
* @estadoZona              estado de localiza��o da zona
* @nroSecao                numero de secao
* @pk_funcionario          resri��o de chave primaria
* @fk_funcionario_eleitor  restri��o de chave estrangeira vinda depessoa
* @fk_funcionario          restri��o de chave estrangeira vinda de secao
* @ch_funcionario          verifica se cargoFunc esta entre as possibilidades listadas no CHECK
*/

CREATE TABLE funcionario(
  nroTitEleitor NUMBER(14) NOT NULL,
  cargoFunc VARCHAR2(30) NOT NULL,
  nroZona NUMBER(5) NOT NULL,
  estadoZona CHAR(2) NOT NULL,
  nroSecao NUMBER(3) NOT NULL,
  CONSTRAINT pk_funcionario PRIMARY KEY (nroTitEleitor),
  CONSTRAINT fk_funcionario_eleitor FOREIGN KEY (nroTitEleitor) REFERENCES pessoa (nroTitEleitor),
  CONSTRAINT fk_funcionario FOREIGN KEY (nroZona, estadoZona, nroSecao) REFERENCES secao (nroZona, estadoZona, nroSecao),
  CONSTRAINT ch_funcionario CHECK (LOWER (cargoFunc) IN ('mesario','presidente','secretario','suplente'))
);

/**
* Tabela votoCandidato
* @nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC chaves primaria
* @pk_votoCandidato                                               resri��o de chave primaria
* @fk_votoCandidato_candidato                                     restri��o de chave estrangeira vinda de candidato
* @fk_votoCandidato_urna                                          restri��o de chave estrangeira vinda de urna
*/

CREATE TABLE votoCandidato(
  nroTitEleitor NUMBER(14) NOT NULL,
  nroZona NUMBER(5) NOT NULL,
  estadoZona CHAR(2) NOT NULL,
  nroSecao NUMBER(3) NOT NULL,
  nroUrna NUMBER(10) NOT NULL,
  idVotoC NUMBER NOT NULL,
  CONSTRAINT pk_votoCandidato PRIMARY KEY (nroTitEleitor, nroZona, estadoZona, nroSecao, nroUrna, idVotoC),
  CONSTRAINT fk_votoCandidato_candidato FOREIGN KEY (nroTitEleitor) REFERENCES candidato,
  CONSTRAINT fk_votoCandidato_urna FOREIGN KEY (nroZona, estadoZona, nroSecao, nroUrna) REFERENCES urna (nroZona, estadoZona, nroSecao, nroUrna)
);

/**
* Tabela votoPartido
* @nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP  chaves primarias
* @pk_votoPartido                                               resri��o de chave primaria  
* @fk_votoPartido_partido                                       restri��o de chave estrangeira vinda de partido
* @fk_votoPartido_urna                                          restri��o de chave estrangeira vinda de urna    
*/  

CREATE TABLE votoPartido(
  nroPartido NUMBER(5) NOT NULL,
  nroZona NUMBER(5) NOT NULL,
  estadoZona CHAR(2) NOT NULL,
  nroSecao NUMBER(3) NOT NULL,
  nroUrna NUMBER(10) NOT NULL,
  idVotoP NUMBER NOT NULL,
  CONSTRAINT pk_votoPartido PRIMARY KEY (nroPartido, nroZona, estadoZona, nroSecao, nroUrna, idVotoP),
  CONSTRAINT fk_votoPartido_partido FOREIGN KEY (nroPartido) REFERENCES partido (nroPartido),
  CONSTRAINT fk_votoPartido_urna FOREIGN KEY (nroZona, estadoZona, nroSecao, nroUrna) REFERENCES urna (nroZona, estadoZona, nroSecao, nroUrna)
);



