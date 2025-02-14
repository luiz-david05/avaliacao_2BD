CREATE TABLE assunto (
    id INT PRIMARY KEY,
    descricao VARCHAR(45) NOT NULL
);

CREATE TABLE editora (
    id INT PRIMARY KEY,
    cnpj CHAR(14) UNIQUE NOT NULL,
    razao_social VARCHAR(100) NOT NULL
);

CREATE TABLE nacionalidade (
    id INT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL
);

CREATE TABLE autor (
    id INT PRIMARY KEY,
    cpf CHAR(11) UNIQUE NOT NULL,
    nome_autor VARCHAR(100) NOT NULL,
    dt_nasc DATE NOT NULL,
    nacionalida_id INT,
    FOREIGN KEY (nacionalida_id) REFERENCES nacionalidade(id)
);

CREATE TABLE livro (
    id INT PRIMARY KEY,
    isbn CHAR(13) UNIQUE NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    dt_lancamento DATE NOT NULL,
    editora_id INT NOT NULL,
    assunto_id INT NOT NULL,
    FOREIGN KEY (editora_id) REFERENCES editora(id),
    FOREIGN KEY (assunto_id) REFERENCES assunto(id)
);

CREATE TABLE autoria (
    autor_id INT NOT NULL,
    livro_id INT NOT NULL,
    PRIMARY KEY (autor_id, livro_id),
    FOREIGN KEY (autor_id) REFERENCES autor(id),
    FOREIGN KEY (livro_id) REFERENCES livro(id)
);

-- inserções

INSERT INTO nacionalidade (id, descricao) VALUES (1, 'Brasileira');

INSERT INTO assunto (id, descricao) VALUES 
(1, 'Romance'), 
(2, 'Ficção Científica'), 
(3, 'Poesia'), 
(4, 'Crônica'), 
(5, 'Drama'),
(6, 'Banco de Dados');

INSERT INTO editora (id, cnpj, razao_social) VALUES 
(1, '12345678000101', 'Companhia das Letras'),
(2, '22345678000102', 'Record'),
(3, '32345678000103', 'Editora Saraiva'),
(4, '42345678000104', 'Rocco'),
(5, '52345678000105', 'Nova Fronteira'),
(6, '62345678000106', 'Books Editora');

INSERT INTO autor (id, cpf, nome_autor, dt_nasc, nacionalida_id) VALUES 
(1, '11111111111', 'Machado de Assis', '1839-06-21', 1),
(2, '22222222222', 'Carlos Drummond de Andrade', '1902-10-31', 1),
(3, '33333333333', 'Paulo Coelho', '1947-08-24', 1),
(4, '44444444444', 'Jorge Amado', '1912-08-10', 1),
(5, '55555555555', 'José de Alencar', '1829-05-01', 1),
(6, '66666666666', 'Monteiro Lobato', '1882-04-16', 1),
(7, '77777777777', 'Willian Pereira Alves', '1990-01-01', 1);

INSERT INTO livro (id, isbn, titulo, preco, dt_lancamento, editora_id, assunto_id) VALUES 
(1, '1234567890123', 'Dom Casmurro', 30.00, '1899-01-01', 6, 1),
(2, '2234567890123', 'Memórias Póstumas de Brás Cubas', 25.00, '1881-01-01', 2, 1),
(3, '3234567890123', 'O Alquimista', 20.00, '1988-01-01', 3, 1),
(4, '4234567890123', 'Capitães da Areia', 15.00, '1937-01-01', 4, 1),
(5, '5234567890123', 'Iracema', 10.00, '1865-01-01', 5, 1),
(6, '6234567890123', 'O Sítio do Pica-Pau Amarelo', 5.00, '1920-01-01', 1, 1),
(7, '7234567890123', 'Banco de Dados: Teoria e Desenvolvimento', 100.00, '2019-09-27', 6, 6);

INSERT INTO autoria (autor_id, livro_id) VALUES 
(1, 1), -- Machado de Assis -> Dom Casmurro
(1, 2), -- Machado de Assis -> Memórias Póstumas de Brás Cubas
(3, 3), -- Paulo Coelho -> O Alquimista
(4, 4), -- Jorge Amado -> Capitães da Areia
(5, 5), -- José de Alencar -> Iracema
(6, 6), -- Monteiro Lobato -> O Sítio do Pica-Pau Amarelo
(7, 7); -- Willian Pereira Alves -> Banco de Dados: Teoria e Desenvolvimento

-- consultas

-- a) Livros que possuam preços entre R$ 100,00 e R$ 200,00.

SELECT * FROM livro WHERE preco BETWEEN 100.00 AND 200.00;

-- b) Livros cujos títulos possuam a palavra ‘Banco’.

SELECT * FROM livro WHERE titulo LIKE '%Banco%';

-- c) Livros que foram lançados há mais de 5 anos.

SELECT * FROM livro WHERE dt_lancamento < (CURRENT_DATE - INTERVAL '5 years');

-- d) Quantidade total de livros.

SELECT COUNT(*) FROM livro;

-- e) Soma total dos preços dos livros.

SELECT SUM(preco) FROM livro;

-- f) Maior preço dos livros.

SELECT MAX(preco) FROM livro;

-- g) Quantidade de livros para cada assunto.

SELECT assunto.descricao, COUNT(*) FROM livro, assunto WHERE livro.assunto_id = assunto.id GROUP BY assunto.descricao;

-- h) Assuntos cujo preço médio dos livros ultrapassa R$ 50,00.

SELECT assunto.descricao, AVG(livro.preco) FROM livro, assunto WHERE livro.assunto_id = assunto.id GROUP BY assunto.descricao HAVING AVG(livro.preco) > 50.00;

-- i) Assuntos que possuem pelo menos 2 livros.

SELECT assunto.descricao, COUNT(*) FROM livro, assunto WHERE livro.assunto_id = assunto.id GROUP BY assunto.descricao HAVING COUNT(*) >= 2;

-- j) Nome e CPF dos autores que nasceram após 1° de janeiro de 1970.

SELECT nome_autor, cpf FROM autor WHERE dt_nasc > '1970-01-01';

-- k) Nome e CPF dos autores que não são brasileiros.

SELECT nome_autor, cpf FROM autor WHERE nacionalida_id != 1;

-- l) Listagem dos livros contendo título, assunto e preço, ordenada em ordem crescente por assunto.

SELECT livro.titulo, assunto.descricao, livro.preco FROM livro, assunto WHERE livro.assunto_id = assunto.id ORDER BY assunto.descricao;

-- m) Listagem contendo os preços e os títulos dos livros, ordenada em ordem decrescente de preço.

SELECT livro.titulo, livro.preco FROM livro ORDER BY livro.preco DESC;

-- n) Listagem dos nomes dos autores brasileiros com mês e ano de nascimento, por ordem decrescente de idade e por ordem crescente de nome do autor.

SELECT nome_autor, EXTRACT(YEAR FROM dt_nasc) AS ano_nasc, EXTRACT(MONTH FROM dt_nasc) AS mes_nasc FROM autor WHERE nacionalida_id = 1 ORDER BY EXTRACT(YEAR FROM dt_nasc) DESC, nome_autor;

-- o) Listagem das editoras e dos títulos dos livros lançados pela editora, ordenada por nome da editora e pelo título do livro.

SELECT editora.razao_social, livro.titulo FROM editora, livro WHERE editora.id = livro.editora_id ORDER BY editora.razao_social, livro.titulo;

-- p) Listagem de assuntos, contendo os títulos dos livros dos respectivos assuntos, ordenada pela descrição do assunto.

SELECT assunto.descricao, livro.titulo FROM assunto, livro WHERE assunto.id = livro.assunto_id ORDER BY assunto.descricao;

-- q) Listagem dos nomes dos autores e os livros de sua autoria, ordenada pelo nome do autor.

SELECT autor.nome_autor, livro.titulo FROM autor, livro, autoria WHERE autor.id = autoria.autor_id AND livro.id = autoria.livro_id ORDER BY autor.nome_autor;

-- r) Editoras que publicaram livros escritos pelo autor ‘Machado de Assis’.

SELECT editora.razao_social FROM editora, livro, autoria, autor WHERE editora.id = livro.editora_id AND livro.id = autoria.livro_id AND autor.id = autoria.autor_id AND autor.nome_autor = 'Machado de Assis';

-- s) preço do livro mais caro publicado pela editora ‘Books Editora’ sobre banco de dados.
 -- RESPOSTA FACIL
SELECT MAX(preco) FROM livro WHERE editora_id = 6 AND assunto_id = 6;

-- RESPOSTA DIFICIL
SELECT MAX(preco) FROM livro WHERE editora_id = (SELECT id FROM editora WHERE razao_social = 'Books Editora') AND assunto_id = (SELECT id FROM assunto WHERE descricao = 'Banco de Dados');

-- t) Nome e CPF do autor brasileiro que tenha nascido antes de 1° de janeiro de 1950 e os títulos dos livros de sua autoria, ordenado pelo nome do autor e pelo título do livro.

SELECT autor.nome_autor, autor.cpf, livro.titulo FROM autor, livro, autoria WHERE autor.id = autoria.autor_id AND livro.id = autoria.livro_id AND autor.nacionalida_id = 1 AND autor.dt_nasc < '1950-01-01' ORDER BY autor.nome_autor, livro.titulo;