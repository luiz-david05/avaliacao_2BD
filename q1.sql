CREATE DATABASE colecaoCD;
USE colecaoCD;

CREATE TABLE CD (
    id_cd INT PRIMARY KEY SERIAL NOT NULL,
    nome_cd VARCHAR(45) NOT NULL,
    data_compra DATE NOT NULL,
    valor_pago DECIMAL(10,2) NOT NULL,
    local_compra VARCHAR(45) NOT NULL,
    album CHAR(1): CHECK (album IN ('S', 'N')) NOT NULL,
    artista VARCHAR(45) NOT NULL
);

CREATE TABLE musica (
    id INT PRIMARY KEY SERIAL NOT NULL,
    cd_id INT NOT NULL,
    nome_msc VARCHAR(45) NOT NULL,
    duracao INT NOT NULL, -- em segundos
    FOREIGN KEY (cd_id) REFERENCES CD(id_cd)
);

-- inserções

INSERT INTO CD (nome_cd, data_compra, valor_pago, local_compra, album, artista) VALUES ('Superunknown', '2025-02-11', 40.00, 'Loja1', 'S', 'Soundgarden');

INSERT INTO musica (cd_id, nome_msc, duracao) VALUES (1, 'Black Hole Sun', 318);

INSERT INTO musica (cd_id, nome_msc, duracao) VALUES (1, 'Fell On Black Days', 283);

-- consultas

-- a) Mostrar os campos nome e data da compra de todos os CDs ordenados por nome

SELECT nome_cd, data_compra FROM CD ORDER BY nome_cd;

-- b) Mostrar os campos nome e data da compra dos CDs classificados por data da compra em ordem crescente

SELECT nome_cd, data_compra FROM CD ORDER BY data_compra;

-- c) Mostrar o total gasto com a compra dos CDs

SELECT SUM(valor_pago) FROM CD;

-- d) Mostrar o nome do CD e o nome das músicas de todos os CDs

SELECT CD.nome_cd, musica.nome_msc FROM CD, musica WHERE CD.id_cd = musica.cd_id;

-- e) Mostrar o nome e o artista de todas as músicas cadastradas

SELECT CD.nome_cd, CD.artista FROM CD, musica WHERE CD.id_cd = musica.cd_id;
