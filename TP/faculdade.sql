PRAGMA foreign_keys=ON;
PRAGMA encoding='UTF-8';
DROP TABLE IF EXISTS Prova;
DROP TABLE IF EXISTS Cadeira;
DROP TABLE IF EXISTS Aluno;
DROP TABLE IF EXISTS Prof;
BEGIN TRANSACTION;
CREATE TABLE Aluno (
	nr	text(3) not null,
	Nome text(50) not null,
	CONSTRAINT aluno_pk PRIMARY KEY (nr)
);
INSERT INTO Aluno VALUES('100','João');
INSERT INTO Aluno VALUES('110','Manuel');
INSERT INTO Aluno VALUES('120','Rui');
INSERT INTO Aluno VALUES('130','Abel');
INSERT INTO Aluno VALUES('140','Fernando');
INSERT INTO Aluno VALUES('150','Ismael');
CREATE TABLE Prof
(	sigla	text(5)	not null,
 	Nome	text(50)	not null,
 	CONSTRAINT prof_pk PRIMARY KEY (sigla)
);
INSERT INTO Prof VALUES('ECO','Eugénio');
INSERT INTO Prof VALUES('FNF','Fernando');
INSERT INTO Prof VALUES('JLS','João');
CREATE TABLE Cadeira
(	cod		text(5)	not null,
 	Design	text(50)	not null,
    curso	text(10)	not null,
    regente	text(5)	REFERENCES Prof(sigla),
 	CONSTRAINT cadeira_pk PRIMARY KEY (cod)
);
INSERT INTO Cadeira VALUES('TS1','Teoria dos Sistemas 1','IS','FNF');
INSERT INTO Cadeira VALUES('BD','Bases de Dados','IS','ECO');
INSERT INTO Cadeira VALUES('EIA','Estruturas de Informação e Algoritmos','IS','ECO');
INSERT INTO Cadeira VALUES('EP','Electrónica de Potência','AC','JLS');
INSERT INTO Cadeira VALUES('IE','Instalações Eléctricas','AC','JLS');
CREATE TABLE Prova
(	nr		text(5)	REFERENCES Aluno(nr),
 	cod		text(50) REFERENCES Cadeira(cod),
    data	date,
    nota	number(2) check (nota>=0 AND nota<=20),
 	CONSTRAINT prova_pk PRIMARY KEY (nr, cod, data)
);
INSERT INTO Prova VALUES('100','TS1','92-02-11',8);
INSERT INTO Prova VALUES('100','TS1','93-02-02',11);
INSERT INTO Prova VALUES('100','BD','93-02-04',17);
INSERT INTO Prova VALUES('100','EIA','92-01-29',16);
INSERT INTO Prova VALUES('100','EIA','93-02-02',13);
INSERT INTO Prova VALUES('110','EP','92-01-30',12);
INSERT INTO Prova VALUES('110','IE','92-02-05',10);
INSERT INTO Prova VALUES('110','IE','93-02-01',14);
INSERT INTO Prova VALUES('120','TS1','93-01-31',15);
INSERT INTO Prova VALUES('120','EP','93-02-04',13);
INSERT INTO Prova VALUES('130','BD','93-02-04',12);
INSERT INTO Prova VALUES('130','EIA','93-02-02',7);
INSERT INTO Prova VALUES('130','TS1','92-02-11',8);
INSERT INTO Prova VALUES('140','TS1','93-01-31',10);
INSERT INTO Prova VALUES('140','TS1','92-02-11',13);
INSERT INTO Prova VALUES('140','EIA','93-02-02',11);
INSERT INTO Prova VALUES('150','TS1','92-02-11',10);
INSERT INTO Prova VALUES('150','EP','93-02-02',11);
INSERT INTO Prova VALUES('150','BD','93-02-04',17);
INSERT INTO Prova VALUES('150','EIA','92-01-29',16);
INSERT INTO Prova VALUES('150','IE','93-02-02',13);
COMMIT;
