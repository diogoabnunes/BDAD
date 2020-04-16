--1
select nr
from Aluno;

--2
select cod, Design
from Cadeira
where curso = 'AC';

--3
select distinct Aluno.nome
from Aluno, Prof
where Aluno.nome=Prof.nome; 

--4
select distinct nome 
from Aluno
EXCEPT 
select distinct nome 
from Prof;

--5
select distinct nome 
from Aluno 
UNION 
select distinct nome 
from Prof;

--6
select distinct nome 
from Aluno, Prova
where cod = 'TS1';

--7
select distinct nome
from Aluno NATURAL JOIN Prova NATURAL JOIN Cadeira
where curso = 'IS'; 

--8
select distinct nome
from Aluno
where nr NOT IN
(select nr AS alunonr
from Aluno, Cadeira
where curso='IS' AND NOT (cod IN (SELECT cod FROM Prova WHERE nota>=10 AND nr=alunonr)) ); 

--9
select max(nota)
from Prova;

--10
select avg(nota)
from Prova
where cod = 'BD';

--11
select count(*)
from Aluno;

--12
select curso, count(*)
from Cadeira
group by curso;

--13
select Aluno.nome, count(*)
from Aluno NATURAL JOIN Prova
group by Aluno.nome;

--14
select avg(nProvas)
from
(select nr, count(*) as nProvas
from Prova
group by nr);

--15
select nome, avg(nota)
from
(select nr, max(nota) AS nota
from Prova
group by nr, cod)
NATURAL JOIN Aluno
where nota >= 10
group by nr; 

--16
select A.cod, nome, maxNota
from (select cod, MAX(nota) maxNota from Prova group by cod) A, Prova, Aluno
where A.cod = Prova.cod AND nota=maxNota AND Prova.nr=Aluno.nr; 

--17

