--1.Oficina
--a. Se não for especificado o cliente aquando a inserção de uma reparação,
    --assumir que o cliente é o proprietário do carro.
CREATE TRIGGER defaultCliente 
AFTER INSERT ON Reparacao 
FOR EACH ROW 
WHEN (NEW.idCliente ISNULL) 
BEGIN 
UPDATE Reparacao 
    SET idCliente=
    (SELECT MAX(idCliente) FROM Carro WHERE idCarro = NEW.idCarro) WHERE idReparacao=NEW.idReparacao; 
END; 

INSERT INTO Reparacao (dataInicio, dataFim, idCarro)
	VALUES ('2020-05-14', '2020-05-15', 3);
--b. Simultaneamente: impedir a atribuição de peças:
    --(1) não compatíveis com o modelo do carro em reparação;
    --(2) sem stock suficiente para satisfazer a quantidade pretendida na reparação.
CREATE TRIGGER validaPecasReparacao
BEFORE INSERT ON ReparacaoPeca
FOR EACH ROW
BEGIN 
SELECT CASE 
    WHEN ((SELECT COUNT(*) FROM Peca, PecaModelo, Carro, Reparacao
         WHERE Peca.idPeca = PecaModelo.idPeca AND PecaModelo.idModelo = Carro.idModelo 
         AND Carro.idCarro = Reparacao.idCarro AND Reparacao.idReparacao = NEW.idReparacao 
         AND Peca.idPeca = NEW.idPeca AND Peca.quantidade >= NEW.quantidade) = 0) 
THEN RAISE(ABORT, 'Peça ou quantidade invalidos.') END;
END;

INSERT INTO ReparacaoPeca (idReparacao, idPeca, quantidade)
    VALUES (3, 2, 11);
--c. Atualizar automaticamente o stock de peças após inserção de registos na tabela ReparacaoPeca.
CREATE TRIGGER AtualizaStockPecas 
AFTER INSERT ON ReparacaoPeca 
BEGIN 
UPDATE Peca SET quantidade = (quantidade - New.quantidade) 
    WHERE idPeca = New.idPeca; 
END; 

INSERT INTO ReparacaoPeca (idReparacao, idPeca, quantidade)
    VALUES (3, 2, 1);
--d. Quando se inserem registos numa vista com os nomes de todos os modelos e respetivas marcas, 
    --estas inserções sejam propagadas para as tabelas que dão origem à vista.
CREATE TRIGGER insertOnView 
INSTEAD OF INSERT ON modelosMarcas 
FOR EACH ROW 
BEGIN 
INSERT INTO Marca (nome) VALUES (NEW.nomeMarca);
INSERT INTO Modelo (nome, idMarca) SELECT NEW.nomeModelo, max(idMarca) 
    FROM Marca WHERE nome=New.nomeMarca; 
END;

INSERT INTO modelosMarcas (nomeModelo, nomeMarca)
    VALUES('C4 Picasso', 'Citroen');
--ClínicaMédica
--a. Não permitir o utilizador marcar uma consulta caso o número de marcações para esse dia
    -- venha a ultrapassar a disponibilidade desse médico para esse dia.


--b. Não permitir marcar uma consulta com a mesma hora de início de uma outra consulta no 
    --mesmo dia, mesmo médico.
