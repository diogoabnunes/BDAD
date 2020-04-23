--a
select *
from Peca 
where custoUnitario < 10 and codigo like '%98%';
--b
SELECT matricula
FROM Carro, Reparacao
WHERE Carro.idCarro=Reparacao.idCarro AND 
    strftime('%m', dataFim) = '09' AND strftime('%Y', dataFim) = '2010'; 
--c
SELECT nome 
FROM Cliente, Carro, Reparacao, ReparacaoPeca, Peca 
WHERE Cliente.idCliente=Carro.idCliente AND 
    Carro.idCarro=Reparacao.idCarro AND 
    Reparacao.idReparacao=ReparacaoPeca.idReparacao 
    AND ReparacaoPeca.idPeca=Peca.idPeca 
    AND custoUnitario>10 
ORDER BY custoUnitario DESC; 
--d
SELECT nome 
FROM Cliente WHERE idCliente NOT IN (SELECT idCliente FROM Carro);
--e
SELECT idCarro, count(*) AS numReparacoes 
FROM Reparacao 
GROUP BY idCarro;
--f
SELECT idCarro, sum(CAST((julianday(dataFim) - julianday(dataInicio)) AS INTEGER)) AS numDias 
FROM Reparacao 
GROUP BY idCarro;
--ou 
SELECT matricula, SUM(strftime('%d',dataFim)- strftime('%d',dataInicio)) AS numDias
FROM Carro, Reparacao 
WHERE Carro.idCarro=reparacao.idCarro 
GROUP BY matricula; 
--g
select AVG(custoUnitario) AS custoUnitarioMedio,
    SUM(custoUnitario * quantidade) AS valorTotal,
    SUM(quantidade) AS quantidadeTotal,
    MAX(custoUnitario) AS maisCara,
    MIN(custoUnitario) as maisBarata
from Peca;
--prof views
CREATE VIEW PrecoReparacaoFuncionario AS 
    SELECT FuncionarioReparacao.idReparacao AS idReparacao, 
    ifnull(SUM(Especialidade.custoHorario*FuncionarioReparacao.numHoras),0) AS precoFuncionario 
    FROM Especialidade, Funcionario, FuncionarioReparacao 
    WHERE Especialidade.idEspecialidade=Funcionario.idEspecialidade AND 
    Funcionario.idFuncionario=FuncionarioReparacao.idFuncionario 
    GROUP BY FuncionarioReparacao.idReparacao; 
CREATE VIEW PrecoReparacaoPeca AS 
    SELECT ReparacaoPeca.idReparacao AS idReparacao, 
    ifnull(SUM(Peca.custoUnitario*ReparacaoPeca.quantidade),0) AS precoPeca 
    FROM ReparacaoPeca, Peca 
    WHERE ReparacaoPeca.idPeca=Peca.idpeca 
    GROUP BY ReparacaoPeca.idReparacao; 
CREATE VIEW PrecoReparacao AS 
    SELECT ifnull(idReparacao1,idReparacao2) AS idReparacao, 
    ifnull(precoFuncionario,0) + ifnull(precoPeca,0) AS preco 
    FROM 
    (SELECT PrecoReparacaoFuncionario.idReparacao AS idReparacao1, 
    PrecoReparacaoFuncionario.precoFuncionario, PrecoReparacaoPeca.idReparacao AS idReparacao2, 
    PrecoReparacaoPeca.precoPeca 
    FROM PrecoReparacaoFuncionario 
    LEFT JOIN PrecoReparacaoPeca ON PrecoReparacaoFuncionario.idReparacao = PrecoReparacaoPeca.idReparacao 
    UNION ALL 
    SELECT PrecoReparacaoFuncionario.idReparacao AS idReparacao1, 
    PrecoReparacaoFuncionario.precoFuncionario, 
    PrecoReparacaoPeca.idReparacao AS idReparacao2, PrecoReparacaoPeca.precoPeca 
    FROM PrecoReparacaoPeca 
    LEFT JOIN PrecoReparacaoFuncionario ON PrecoReparacaoFuncionario.idReparacao = PrecoReparacaoPeca.idReparacao 
    WHERE PrecoReparacaoFuncionario.idReparacao IS NULL); 
--h
-- to do later :)
--i
select * 
from PrecoReparacao;
--j
select * 
from PrecoReparacao
where preco > 60;
--k
select max(preco) AS reparacaoMaisCara
from PrecoReparacao;
--l
--m
--n
--o
--p
--q
--r
--s
--t
--u
--v
--w