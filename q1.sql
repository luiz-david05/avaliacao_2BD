CREATE TABLE CD (
    id_cd SERIAL PRIMARY KEY,
    nome_cd VARCHAR(45) NOT NULL,
    data_compra DATE NOT NULL,
    valor_pago DECIMAL(10,2) NOT NULL,
    local_compra VARCHAR(45) NOT NULL,
    album CHAR(1) NOT NULL CHECK (album IN ('S', 'N')),
    artista VARCHAR(45) NOT NULL
);

CREATE TABLE musica (
    id SERIAL PRIMARY KEY,
    cd_id INT NOT NULL,
    nome_msc VARCHAR(45) NOT NULL,
    duracao INT NOT NULL, -- em segundos
    FOREIGN KEY (cd_id) REFERENCES CD(id_cd)
);  

-- inserções

INSERT INTO CD (nome_cd, data_compra, valor_pago, local_compra, album, artista) VALUES ('Na Pegada do Arrocha', '2025-02-12', 30.00, 'Loja1', 'S', 'Os Clones');

INSERT INTO musica (cd_id, nome_msc, duracao) VALUES (1, 'Mulher Safada', 284);
INSERT INTO musica (cd_id, nome_msc, duracao) VALUES (1, 'Que Mal Te Fiz Eu', 250);

INSERT INTO CD (nome_cd, data_compra, valor_pago, local_compra, album, artista) VALUES ('Minha Santa Ines - Nosso Rei', '2025-02-13', 40.00, 'Loja1', 'S', 'Raimundo Soldado');

INSERT INTO musica (cd_id, nome_msc, duracao) VALUES (2, 'Hoje Eu Vou Me Embriagar', 286);
INSERT INTO musica (cd_id, nome_msc, duracao) VALUES (2, 'Meu Pai Ta Duro', 145);

INSERT INTO CD (nome_cd, data_compra, valor_pago, local_compra, album, artista) VALUES ('Reginaldo Rossi - Perfil', '2025-02-14', 50.00, 'Loja1', 'S', 'Reginaldo Rossi');

INSERT INTO musica (cd_id, nome_msc, duracao) VALUES (3, 'Meu Fracasso', 158);
INSERT INTO musica (cd_id, nome_msc, duracao) VALUES (3, 'A Raposa e as Uvas', 231);
INSERT INTO musica (cd_id, nome_msc, duracao) VALUES (3, 'Garçom', 245);
INSERT INTO musica (cd_id, nome_msc, duracao) VALUES (3, 'Leviana', 254);
INSERT INTO musica (cd_id, nome_msc, duracao) VALUES (3, 'Em Plena Lua de Mel', 265);

INSERT INTO CD (nome_cd, data_compra, valor_pago, local_compra, album, artista) VALUES ('20 Super Sucessos', '2025-02-15', 60.00, 'Loja1', 'S', 'Bartô Galeno');

INSERT INTO musica (cd_id, nome_msc, duracao) VALUES (4, 'Saudade de Rosa', 186);
INSERT INTO musica (cd_id, nome_msc, duracao) VALUES (4, 'No Toca-Fita do Meu Carro', 217);

INSERT INTO CD (nome_cd, data_compra, valor_pago, local_compra, album, artista) VALUES ('Bruno E Marrone Ao Vivo', '2025-02-16', 70.00, 'Loja1', 'S', 'Bruno E Marrone');

INSERT INTO musica (cd_id, nome_msc, duracao) VALUES (5, 'Dormi na Praça', 198);
INSERT INTO musica (cd_id, nome_msc, duracao) VALUES (5, 'Boate Azul', 217);
INSERT INTO musica (cd_id, nome_msc, duracao) VALUES (5, 'Por Um Minuto', 231);
INSERT INTO musica (cd_id, nome_msc, duracao) VALUES (5, 'Te Amar foi Ilusao', 245);
-- consultas

-- a) Mostrar os campos nome e data da compra de todos os CDs ordenados por nome

SELECT nome_cd, data_compra FROM CD ORDER BY nome_cd;

-- b) Mostrar os campos nome e data da compra dos CDs classificados por data da compra em ordem crescente

SELECT nome_cd, data_compra FROM CD ORDER BY data_compra;

-- c) Mostrar o total gasto com a compra dos CDs

SELECT SUM(valor_pago) FROM CD;

-- d) Mostrar o nome do CD e o nome das músicas de todos os CDs

SELECT CD.nome_cd, musica.nome_msc FROM CD, musica WHERE CD.id_cd = musica.cd_id;


-- e) Mostrar o nome (musica) e o artista de todas as músicas

SELECT musica.nome_msc, CD.artista FROM CD, musica WHERE CD.id_cd = musica.cd_id;

-- f) Mostrar o tempo total de músicas cadastradas

SELECT SUM(duracao) FROM musica;

-- g) Mostrar o número, nome e tempo das músicas do CD com o código 5 por ordem de número

SELECT id, nome_msc, duracao FROM musica WHERE cd_id = 5 ORDER BY id;

-- h) Mostrar o número, nome e tempo das músicas do CD com o nome “Reginaldo Rossi – Perfil” por ordem de nome

SELECT musica.id, musica.nome_msc, musica.duracao FROM CD, musica WHERE CD.id_cd = musica.cd_id AND CD.nome_cd = 'Reginaldo Rossi - Perfil' ORDER BY musica.nome_msc;


-- i) Mostrar o tempo total de músicas por CD

SELECT CD.nome_cd, SUM(musica.duracao) FROM CD, musica WHERE CD.id_cd = musica.cd_id GROUP BY CD.nome_cd;


-- j) Mostrar a quantidade de músicas cadastradas

SELECT COUNT(*) FROM musica;


-- k) Mostrar a média de duração das músicas cadastradas

SELECT AVG(duracao) FROM musica;


-- l) Mostrar a quantidade de CDs

SELECT COUNT(*) FROM CD;


-- m) Mostrar o nome das músicas do artista Reginaldo Rossi

SELECT musica.nome_msc FROM CD, musica WHERE CD.id_cd = musica.cd_id AND CD.artista = 'Reginaldo Rossi';


-- n) Mostrar a quantidade de músicas por CDs

SELECT CD.nome_cd, COUNT(*) FROM CD, musica WHERE CD.id_cd = musica.cd_id GROUP BY CD.nome_cd;

-- update para a questao o)
UPDATE CD
SET local_compra = 'Submarino.com'
WHERE nome_cd = 'Reginaldo Rossi - Perfil';


-- o) Mostrar o nome de todos os CDs comprados no “Submarino.com”

SELECT nome_cd FROM CD WHERE local_compra = 'Submarino.com';


-- p) Mostrar uma listagem de músicas em ordem alfabética

SELECT nome_msc FROM musica ORDER BY nome_msc;


-- q) Mostrar todos os CDs que são álbuns

SELECT nome_cd FROM CD WHERE album = 'S';


-- r) Mostrar o CD que custou mais caro

SELECT nome_cd FROM CD WHERE valor_pago = (SELECT MAX(valor_pago) FROM CD);


-- update para a questao s)

UPDATE CD
SET data_compra = '2024-07-01'
WHERE nome_cd = 'Na Pegada do Arrocha';


-- s) Mostrar os CDs comprados em julho de 2024

SELECT nome_cd FROM CD WHERE data_compra BETWEEN '2024-07-01' AND '2024-07-31';


-- t) Mostrar os CDs cujo valor pago esteja entre R$ 30,00 e R$ 50,00

SELECT nome_cd FROM CD WHERE valor_pago BETWEEN 30.00 AND 50.00;