--a: Quais as peças com custo unitário inferior a 10€ e cujo código contém ‘98’?
select *
from Peca 
where custoUnitario < 10 and codigo like '%98%';
--b: Quais as matrículas dos carros que foram reparados no mês de Setembro de
    --2010, i.e., cuja reparação terminou nesse mês?
SELECT matricula
FROM Carro, Reparacao
WHERE Carro.idCarro=Reparacao.idCarro AND 
    strftime('%m', dataFim) = '09' AND strftime('%Y', dataFim) = '2010'; 
--c: Quais os nomes dos clientes proprietários de carros que utilizaram peças
    --com custo unitário superior a 10€? Apresente o resultado ordenado por
    --ordem descendente do custo unitário.
SELECT nome 
FROM Cliente, Carro, Reparacao, ReparacaoPeca, Peca 
WHERE Cliente.idCliente=Carro.idCliente AND 
    Carro.idCarro=Reparacao.idCarro AND 
    Reparacao.idReparacao=ReparacaoPeca.idReparacao 
    AND ReparacaoPeca.idPeca=Peca.idPeca 
    AND custoUnitario>10 
ORDER BY custoUnitario DESC; 
--d: Quais os nomes dos clientes que não têm (tanto quanto se saiba) carro?
SELECT nome 
FROM Cliente WHERE idCliente NOT IN (SELECT idCliente FROM Carro);
--e: Qual o número de reparações feitas a cada carro?
SELECT idCarro, count(*) AS numReparacoes 
FROM Reparacao 
GROUP BY idCarro;
--f: Qual o número de dias em que cada carro esteve em reparação?
SELECT idCarro, sum(CAST((julianday(dataFim) - julianday(dataInicio)) AS INTEGER)) AS numDias 
FROM Reparacao 
GROUP BY idCarro;
--ou 
SELECT matricula, SUM(strftime('%d',dataFim)- strftime('%d',dataInicio)) AS numDias
FROM Carro, Reparacao 
WHERE Carro.idCarro=reparacao.idCarro 
GROUP BY matricula; 
--g: Qual o custo unitário médio, o valor total e o número de unidades das peças,
    --bem como o valor da peça mais cara e da mais barata?
select AVG(custoUnitario) AS custoUnitarioMedio,
    SUM(custoUnitario * quantidade) AS valorTotal,
    SUM(quantidade) AS quantidadeTotal,
    MAX(custoUnitario) AS maisCara,
    MIN(custoUnitario) as maisBarata
from Peca;
--prof views -> included in the end of oficina.sql file
--h: Qual a especialidade que foi utilizada mais vezes nas reparações dos carros de cada marca?
-- to do later :)
--i: Qual o preço total de cada reparação?
select * 
from PrecoReparacao;
--j: Qual o preço total das reparações com custo total superior a 60€?
select * 
from PrecoReparacao
where preco > 60;
--k: Qual o proprietário do carro que teve a reparação mais cara?
SELECT nome AS proprietarioComReparacaoMaisCara
FROM Cliente, Carro, Reparacao, PrecoReparacao 
WHERE Cliente.idCliente=Carro.idCliente AND 
    Carro.idCarro=Reparacao.idCarro AND 
    Reparacao.idReparacao=PrecoReparacao.idReparacao AND 
    PrecoReparacao.preco = (SELECT MAX(preco) FROM PrecoReparacao); 
--l: Qual a matrícula do carro com a segunda reparação mais cara?
SELECT matricula 
FROM Carro, Reparacao, PrecoReparacao 
WHERE Carro.idCarro=Reparacao.idCarro AND 
    Reparacao.idReparacao=PrecoReparacao.idReparacao AND 
    PrecoReparacao.preco = (
        SELECT MAX(preco) 
        FROM PrecoReparacao 
        WHERE preco NOT IN (SELECT MAX(preco) FROM PrecoReparacao)); 
--m: Quais são as três reparações mais caras (ordenadas por ordem decrescente de preço)?
SELECT *
FROM PrecoReparacao 
ORDER BY preco DESC 
LIMIT 3; 
--n: Quais os nomes dos clientes responsáveis por reparações de carros e
    --respetivos proprietários (só para os casos em que não são coincidentes)?
SELECT C1.nome "Proprietário", C2.nome "Cliente" 
FROM Cliente C1, Cliente C2, Carro, Reparacao 
WHERE Reparacao.idCarro=Carro.idCarro AND 
    Carro.idCliente=C1.idCliente AND 
    Reparacao.idCliente=C2.idCliente AND 
    C1.idCliente<>C2.idCliente; 
--o: Quais as localidades onde mora alguém, seja ele cliente ou funcionário?

--p: Quais as localidades onde moram clientes e funcionários?

--q: Quais as peças compatíveis com modelos da Volvo cujo preço é maior do que
    --o de qualquer peça compatível com modelos da Renault?
SELECT idPeca, codigo 
FROM PecaMarca 
WHERE nome LIKE 'Volvo' AND 
    idPeca NOT IN (
        SELECT PM1.idPeca 
        FROM PecaMarca PM1, PecaMarca PM2 
        WHERE PM1.nome LIKE 'Volvo' AND 
            PM2.nome LIKE 'Renault' AND 
            PM1.custoUnitario <= PM2.custoUnitario); 
--r: Quais as peças compatíveis com modelos da Volvo cujo preço é maior do que
    --o de alguma peça compatível com modelos da Renault?
SELECT idPeca, codigo 
FROM PecaMarca 
WHERE nome LIKE 'Volvo' AND 
    idPeca IN (
        SELECT PM1.idPeca 
        FROM PecaMarca PM1, PecaMarca PM2 
        WHERE PM1.nome LIKE 'Volvo' AND 
            PM2.nome LIKE 'Renault' AND 
            PM1.custoUnitario > PM2.custoUnitario); 
--s: Quais as matriculas dos carros que foram reparados mais do que uma vez?

--t: Quais as datas de início e de fim e nome do proprietário das reparações
    --feitas por carros que foram reparados mais do que uma vez?

--u: Quais as reparações que envolveram todas as especialidades?

--v: Calcule as durações de cada reparação, contabilizando até à data atual os não entregues.

--w: Substitua Renault por Top, Volvo por Down e os restantes por NoWay.
