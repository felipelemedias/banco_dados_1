DROP TABLE IF EXISTS Usuarios, Tarefas, Comentarios, Categorias, Prioridades, Anexos, Equipes, Membros, Projetos, Notificacoes, Etapas, Usuarios_recebeNotificacao, Usuarios_realizaTarefas, Tarefa_possuiComentarios, Tarefa_contemAnexos, Equipes_trabalhamProjetos; 

-- Tabela Projetos //6
CREATE TABLE Projetos (
id_projeto INT PRIMARY KEY NOT NULL,
nome VARCHAR(100) NOT NULL,
descricao TEXT,
data_inicio DATE,
data_fim DATE
);

-- Tabela Categorias //6
CREATE TABLE Categorias (
id_categoria INT PRIMARY KEY NOT NULL,
nome VARCHAR(50) NOT NULL
);

-- Tabela Prioridades //3
CREATE TABLE Prioridades (
id_prioridades INT PRIMARY KEY NOT NULL,
nome VARCHAR(50) NOT NULL,
valor INT NOT NULL
);

-- Tabela Usuários //6
CREATE TABLE Usuarios (
id_usuario INT PRIMARY KEY NOT NULL,
nome VARCHAR(50) NOT NULL,
email VARCHAR(100) NOT NULL,
senha VARCHAR(100) NOT NULL
);

-- Tabela Tarefas //6
CREATE TABLE Tarefas (
id_tarefa INT PRIMARY KEY NOT NULL,
titulo VARCHAR(100) NOT NULL,
descricao TEXT,
data_criacao DATE NOT NULL,
data_vencimento DATE,
status VARCHAR(20) NOT NULL,
id_categoria INT,
prioridade INT,
id_projeto INT,
FOREIGN KEY (prioridade) REFERENCES Prioridades(id_prioridades),
FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria),
FOREIGN KEY (id_projeto) REFERENCES Projetos(id_projeto)
);

-- Tabela Comentários //3
CREATE TABLE Comentarios (
id_comentario INT PRIMARY KEY NOT NULL,
id_tarefa INT,
texto_comentario TEXT,
criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (id_tarefa) REFERENCES Tarefas(id_tarefa)
);

-- Tabela Anexos //3
CREATE TABLE Anexos (
id_anexos INT PRIMARY KEY NOT NULL,
nome_arquivo VARCHAR(100) NOT NULL,
caminho_arquivo VARCHAR(255) NOT NULL
);

-- Tabela Equipes //6
CREATE TABLE Equipes (
id_equipes INT PRIMARY KEY NOT NULL,
nome VARCHAR(100) NOT NULL
);

-- Tabela Membros //3
CREATE TABLE Membros (
id_membros INT PRIMARY KEY NOT NULL,
id_equipe INT,
FOREIGN KEY (id_equipe) REFERENCES Equipes(id_equipes)
);

-- Tabela Notificações //3 
CREATE TABLE Notificacoes (
id_notificacao INT PRIMARY KEY NOT NULL,
mensagem TEXT,
data_envio TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Tabela Etapas //6  
CREATE TABLE Etapas (
id_etapas INT PRIMARY KEY NOT NULL,
nome VARCHAR(100) NOT NULL,
descricao TEXT,
projeto_id INT,
FOREIGN KEY (projeto_id) REFERENCES Projetos(id_projeto)
);

CREATE TABLE Usuarios_recebeNotificacao(
id_usuario int NOT NULL,
id_notificacao int,
PRIMARY KEY (id_usuario, id_notificacao),
FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
FOREIGN KEY (id_notificacao) REFERENCES Notificacoes(id_notificacao)
);

CREATE TABLE Usuarios_realizaTarefas(
id_usuario int NOT NULL,
id_tarefas int,
PRIMARY KEY (id_usuario, id_tarefas),
FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
FOREIGN KEY (id_tarefas) REFERENCES Tarefas(id_tarefa)
);

CREATE TABLE Tarefa_possuiComentarios(
id_tarefa int NOT NULL,
id_comentario int,
PRIMARY KEY (id_tarefa, id_comentario),
FOREIGN KEY (id_tarefa) REFERENCES Tarefas(id_tarefa),
FOREIGN KEY (id_comentario) REFERENCES Comentarios(id_comentario)
);

CREATE TABLE Tarefa_contemAnexos(
id_tarefa int NOT NULL,
id_anexos int,
PRIMARY KEY (id_tarefa, id_anexos),
FOREIGN KEY (id_tarefa) REFERENCES Tarefas(id_tarefa),
FOREIGN KEY (id_anexos) REFERENCES Anexos(id_anexos)
);

CREATE TABLE Equipes_trabalhamProjetos(
id_equipes int NOT NULL,
id_projeto int,
PRIMARY KEY (id_equipes, id_projeto),
FOREIGN KEY (id_equipes) REFERENCES Equipes(id_equipes),
FOREIGN KEY (id_projeto) REFERENCES Projetos(id_projeto)
);

-- ALTER TABLE --

-- Essa alteração adicionará uma nova coluna chamada "concluida" à tabela "Tarefas". A coluna será do tipo BOOLEAN e terá um valor padrão de "FALSE".
ALTER TABLE Tarefas
ADD COLUMN concluida BOOLEAN DEFAULT FALSE;

-- Essa alteração adicionará uma nova coluna chamada "ativo" à tabela "Usuarios". A coluna será do tipo BOOLEAN e terá um valor padrão de "TRUE".
ALTER TABLE Usuarios
ADD COLUMN ativo BOOLEAN DEFAULT TRUE;

-- INSERTS --

INSERT INTO Projetos (id_projeto, nome, descricao, data_inicio, data_fim)
VALUES
  (1, 'Projeto 1', 'Descrição do Projeto 1', '2023-01-01', '2023-02-28'),
  (2, 'Projeto 2', 'Descrição do Projeto 2', '2023-03-01', '2023-04-30'),
  (3, 'Projeto 3', 'Descrição do Projeto 3', '2023-05-01', '2023-06-30'),
  (4, 'Projeto 4', 'Descrição do Projeto 4', '2023-07-01', '2023-08-31'),
  (5, 'Projeto 5', 'Descrição do Projeto 5', '2023-09-01', '2023-10-31'),
  (6, 'Projeto 6', 'Descrição do Projeto 6', '2023-11-01', '2023-12-31');

INSERT INTO Categorias (id_categoria, nome)
VALUES
  (1, 'Categoria 1'),
  (2, 'Categoria 2'),
  (3, 'Categoria 3'),
  (4, 'Categoria 4'),
  (5, 'Categoria 5'),
  (6, 'Categoria 6');

INSERT INTO Prioridades (id_prioridades, nome, valor)
VALUES
  (1, 'Baixa', 1),
  (2, 'Média', 2),
  (3, 'Alta', 3);

INSERT INTO Usuarios (id_usuario, nome, email, senha)
VALUES
  (1, 'Usuário 1', 'usuario1@example.com', 'senha1'),
  (2, 'Usuário 2', 'usuario2@example.com', 'senha2'),
  (3, 'Usuário 3', 'usuario3@example.com', 'senha3'),
  (4, 'Usuário 4', 'usuario4@example.com', 'senha4'),
  (5, 'Usuário 5', 'usuario5@example.com', 'senha5'),
  (6, 'Usuário 6', 'usuario6@example.com', 'senha6');

INSERT INTO Tarefas (id_tarefa, titulo, descricao, data_criacao, data_vencimento, status, id_categoria, prioridade, id_projeto)
VALUES
  (1, 'Tarefa 1', 'Descrição da Tarefa 1', '2023-01-01', '2023-01-15', 'Em andamento', 1, 2, 1),
  (2, 'Tarefa 2', 'Descrição da Tarefa 2', '2023-02-01', '2023-02-15', 'Concluída', 2, 1, 1),
  (3, 'Tarefa 3', 'Descrição da Tarefa 3', '2023-03-01', '2023-03-15', 'Em andamento', 3, 3, 2),
  (4, 'Tarefa 4', 'Descrição da Tarefa 4', '2023-04-01', '2023-04-15', 'Pendente', 1, 1, 2),
  (5, 'Tarefa 5', 'Descrição da Tarefa 5', '2023-05-01', '2023-05-15', 'Em andamento', 2, 3, 3),
  (6, 'Tarefa 6', 'Descrição da Tarefa 6', '2023-06-01', '2023-06-15', 'Concluída', 3, 1, 3);

INSERT INTO Comentarios (id_comentario, id_tarefa, texto_comentario)
VALUES
  (1, 1, 'Comentário 1 da Tarefa 1'),
  (2, 1, 'Comentário 2 da Tarefa 1'),
  (3, 2, 'Comentário 1 da Tarefa 2');

INSERT INTO Anexos (id_anexos, nome_arquivo, caminho_arquivo)
VALUES
  (1, 'Arquivo 1', '/caminho/arquivo1.pdf'),
  (2, 'Arquivo 2', '/caminho/arquivo2.docx'),
  (3, 'Arquivo 3', '/caminho/arquivo3.jpg');

INSERT INTO Equipes (id_equipes, nome)
VALUES
  (1, 'Equipe 1'),
  (2, 'Equipe 2'),
  (3, 'Equipe 3'),
  (4, 'Equipe 4'),
  (5, 'Equipe 5'),
  (6, 'Equipe 6');

INSERT INTO Membros (id_membros, id_equipe)
VALUES
  (1, 1),
  (2, 2),
  (3, 3);

INSERT INTO Notificacoes (id_notificacao, mensagem)
VALUES
  (1, 'Mensagem 1'),
  (2, 'Mensagem 2'),
  (3, 'Mensagem 3');

INSERT INTO Etapas (id_etapas, nome, descricao, projeto_id)
VALUES
  (1, 'Etapa 1', 'Descrição da Etapa 1', 1),
  (2, 'Etapa 2', 'Descrição da Etapa 2', 1),
  (3, 'Etapa 3', 'Descrição da Etapa 3', 2),
  (4, 'Etapa 4', 'Descrição da Etapa 4', 2),
  (5, 'Etapa 5', 'Descrição da Etapa 5', 3),
  (6, 'Etapa 6', 'Descrição da Etapa 6', 3);
  
INSERT INTO Usuarios_recebeNotificacao (id_usuario, id_notificacao)
VALUES
  (1, 1),
  (2, 2),
  (3, 3);

INSERT INTO Usuarios_realizaTarefas (id_usuario, id_tarefas)
VALUES
  (1, 1),
  (2, 2),
  (3, 3);

INSERT INTO Tarefa_possuiComentarios (id_tarefa, id_comentario)
VALUES
  (1, 1),
  (1, 2),
  (2, 3);

INSERT INTO Tarefa_contemAnexos (id_tarefa, id_anexos)
VALUES
  (1, 1),
  (1, 2),
  (2, 3);

INSERT INTO Equipes_trabalhamProjetos (id_equipes, id_projeto)
VALUES
  (1, 1),
  (2, 1),
  (2, 2);

-- 3 UPDATES -- 

-- Consulta 1: Alterar o nome do projeto com id_projeto = 1
UPDATE Projetos SET nome = 'Projeto dos Deuses' WHERE id_projeto = 1;

-- Consulta 2: Alterar o status da tarefa com id_tarefa = 2
UPDATE Tarefas SET status = 'Tarefa quase pronta' WHERE id_tarefa = 2;

-- Consulta 3: Alterar a descrição da tarefa com id_tarefa = 3
UPDATE Tarefas SET descricao = 'Fazer PDF' WHERE id_tarefa = 3;

-- 3 DELETES -- 

-- Remover um projeto específico e todas as suas dependências:
DELETE FROM Usuarios_recebeNotificacao WHERE id_usuario = 1;
DELETE FROM Tarefa_possuiComentarios WHERE id_tarefa = 1;
DELETE FROM Equipes_trabalhamProjetos WHERE id_equipes = 1;

-- Pelo menos 4 das consultas devem utilizar duas ou mais tabelas como fonte --

-- Consulta para obter todas as tarefas com seus respectivos projetos:
SELECT T.*, P.nome AS nome_projeto
FROM Tarefas AS T
JOIN Projetos AS P ON T.id_projeto = P.id_projeto;

-- Consulta para buscar os membros de uma equipe específica:
SELECT U.*
FROM Usuarios AS U
JOIN Membros AS M ON U.id_usuario = M.id_membros
JOIN Equipes AS E ON M.id_equipe = E.id_equipes
WHERE E.nome = 'Equipe 1';

-- Selecionar todas as tarefas com suas respectivas categorias:
SELECT Tarefas.*, Categorias.nome AS nome_categoria
FROM Tarefas
INNER JOIN Categorias ON Tarefas.id_categoria = Categorias.id_categoria;


-- Selecionar todas as tarefas com seus respectivos comentários:
SELECT Tarefas.*, Comentarios.texto_comentario
FROM Tarefas
INNER JOIN Tarefa_possuiComentarios ON Tarefas.id_tarefa = Tarefa_possuiComentarios.id_tarefa
INNER JOIN Comentarios ON Tarefa_possuiComentarios.id_comentario = Comentarios.id_comentario;

-- Pelo menos 2 das consultas deve utilizar junção externa.

-- Consulta para obter todas as tarefas e seus respectivos projetos, incluindo as tarefas sem projetos associados:
-- Nesta consulta, usamos a junção externa esquerda (LEFT JOIN) para garantir que todas as tarefas sejam retornadas, mesmo que não tenham um projeto associado. A coluna "nome_projeto" exibirá o nome do projeto correspondente, se existir.
SELECT T.*, P.nome AS nome_projeto
FROM Tarefas AS T
LEFT JOIN Projetos AS P ON T.id_projeto = P.id_projeto;

-- Consulta para buscar todas as categorias e suas tarefas associadas, incluindo as categorias sem tarefas:
-- Nesta consulta, usamos a junção externa esquerda (LEFT JOIN) para garantir que todas as categorias sejam retornadas, mesmo que não tenham tarefas associadas. A coluna "titulo_tarefa" exibirá o título da tarefa correspondente, se existir.
SELECT C.*, T.titulo AS titulo_tarefa
FROM Categorias AS C
LEFT JOIN Tarefas AS T ON C.id_categoria = T.id_categoria;

-- Pelo menos 2 das consultas deve utilizar funções de agregação com agrupamento.

-- Consulta para obter o número de tarefas por categoria:
-- Esta consulta retorna o nome da categoria e o número total de tarefas associadas a cada categoria. A função de agregação COUNT é utilizada para contar o número de tarefas agrupadas por categoria.
SELECT C.nome AS nome_categoria, COUNT(T.id_tarefa) AS total_tarefas
FROM Categorias AS C
LEFT JOIN Tarefas AS T ON C.id_categoria = T.id_categoria
GROUP BY C.nome;

-- Consulta para obter a quantidade média de comentários por tarefa:
-- Nesta consulta, utilizamos as tabelas Tarefas, Tarefa_possuiComentarios e Comentarios para obter a contagem de comentários para cada tarefa. A função de agregação COUNT é utilizada para contar o número de comentários agrupados por tarefa.
SELECT T.id_tarefa, COUNT(C.id_comentario) AS total_comentarios
FROM Tarefas AS T
LEFT JOIN Tarefa_possuiComentarios AS TC ON T.id_tarefa = TC.id_tarefa
LEFT JOIN Comentarios AS C ON TC.id_comentario = C.id_comentario
GROUP BY T.id_tarefa;

-- Pelo menos 2 das consultas devem utilizar UNION, INTERCEPT ou EXCEPT.

-- Obter a lista de tarefas concluídas e a lista de tarefas pendentes:
-- Essa consulta utiliza o UNION para combinar duas consultas em uma única lista. A primeira parte da consulta retorna o título e o status das tarefas concluídas, enquanto a segunda parte retorna o título e o status das tarefas pendentes.
SELECT titulo, status FROM Tarefas WHERE status = 'Concluída'
UNION
SELECT titulo, status FROM Tarefas WHERE status = 'Pendente';

-- Obter a lista de usuários que realizam tarefas e a lista de usuários que recebem notificações:
-- Essa consulta utiliza o UNION para combinar duas consultas em uma única lista. A primeira parte da consulta retorna o nome dos usuários que realizam tarefas, adicionando uma coluna 'tipo' com o valor 'Realiza tarefas'. A segunda parte retorna o nome dos usuários que recebem notificações, adicionando uma coluna 'tipo' com o valor 'Recebe notificações'.
SELECT nome, 'Realiza tarefas' AS tipo FROM Usuarios
INNER JOIN Usuarios_realizaTarefas ON Usuarios.id_usuario = Usuarios_realizaTarefas.id_usuario
UNION
SELECT nome, 'Recebe notificações' AS tipo FROM Usuarios
INNER JOIN Usuarios_recebeNotificacao ON Usuarios.id_usuario = Usuarios_recebeNotificacao.id_usuario;

-- Pelo menos 2 das consultas devem apresentar subconsultas:

-- Utilizando a subconsulta IN:
-- Essa consulta retorna todas as tarefas que possuem a categoria com nome "Categoria 1".
SELECT *
FROM Tarefas
WHERE id_categoria IN (
  SELECT id_categoria
  FROM Categorias
  WHERE nome = 'Categoria 1'
);

-- Utilizando a subconsulta EXISTS:
-- Essa consulta retorna todos os usuários que realizaram tarefas que possuem comentários.
SELECT *
FROM Usuarios
WHERE EXISTS (
  SELECT *
  FROM Usuarios_realizaTarefas
  JOIN Tarefa_possuiComentarios ON Usuarios_realizaTarefas.id_tarefas = Tarefa_possuiComentarios.id_tarefa
  WHERE Usuarios_realizaTarefas.id_usuario = Usuarios.id_usuario
);
