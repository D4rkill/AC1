-- Lista de exclusão das tabelas para resetar caso necessário
DROP TABLE IF EXISTS Item CASCADE;
DROP TABLE IF EXISTS Venda CASCADE;
DROP TABLE IF EXISTS Produto CASCADE;
DROP TABLE IF EXISTS Cliente CASCADE;
DROP TABLE IF EXISTS Fornecedor CASCADE;

-- Lista com todos os creates e seus respectivos atributos
CREATE TABLE Cliente(
Id_Cliente INT PRIMARY KEY,
Nome VARCHAR(150) NOT NULL,
CPF VARCHAR(11) NOT NULL UNIQUE,
Data_Nasc DATE NOT NULL,
Email VARCHAR(80) NOT NULL UNIQUE,
Senha VARCHAR(80) NOT NULL);

CREATE TABLE Fornecedor(
Id_Fornecedor INT PRIMARY KEY,
Nome VARCHAR(150) NOT NULL,
CPF VARCHAR(11) NOT NULL UNIQUE,
Data_Nasc DATE NOT NULL,
Email VARCHAR(80) NOT NULL UNIQUE,
Senha VARCHAR(80) NOT NULL);

CREATE TABLE Venda(
Id_Venda INT PRIMARY KEY,
Total FLOAT,
Data_de_Venda TIMESTAMP NOT NULL,
Id_Cliente INT NOT NULL UNIQUE,
Id_Fornecedor INT NOT NULL UNIQUE,
CONSTRAINT v01 FOREIGN KEY(Id_Cliente) REFERENCES Cliente(Id_Cliente) ON UPDATE CASCADE,
CONSTRAINT v02 FOREIGN KEY(Id_Fornecedor) REFERENCES Fornecedor(Id_Fornecedor) ON UPDATE CASCADE);

CREATE TABLE Produto(
Id_Produto INT PRIMARY KEY,
Descricao VARCHAR(150) NOT NULL,
Preco_Unitario FLOAT NOT NULL,
Qtde INT NOT NULL);

CREATE TABLE Item(
Id_Item INT PRIMARY KEY,
Preco_Unitario FLOAT NOT NULL,
Qtde INT NOT NULL,
Id_Produto INT NOT NULL UNIQUE,
Id_Venda INT NOT NULL UNIQUE,
CONSTRAINT i01 FOREIGN KEY(Id_Produto) REFERENCES Produto(Id_Produto) ON UPDATE CASCADE,
CONSTRAINT i02 FOREIGN KEY(Id_Venda) REFERENCES Venda(Id_Venda) ON UPDATE CASCADE);

-- Lista de inserts
INSERT INTO Cliente(Id_Cliente, Nome, CPF, Data_Nasc, Email, Senha) VALUES(1, 'William', '83020130210', '2005-07-10', 'williamoliveira@gmail.com', '2913810319');
INSERT INTO Cliente(Id_Cliente, Nome, CPF, Data_Nasc, Email, Senha) VALUES(2, 'Thays', '83020930210', '2004-07-10', 'thay27123@gmail.com', '2913819469');

INSERT INTO Fornecedor(Id_Fornecedor, Nome, CPF, Data_Nasc, Email, Senha) VALUES(1, 'Mateus', '12020940160', '2002-09-10', 'masterfatoballo@gmail.com', '3003271969');
INSERT INTO Fornecedor(Id_Fornecedor, Nome, CPF, Data_Nasc, Email, Senha) VALUES(2, 'Davi', '83020940160', '2001-07-10', 'ishidaezzzzzz@gmail.com', '2913271969');

INSERT INTO Produto(Id_Produto, Descricao, Preco_Unitario, Qtde) VALUES(1, 'Maçã', 10.0, 100);
INSERT INTO Produto(Id_Produto, Descricao, Preco_Unitario, Qtde) VALUES(2, 'Chocolate', 100.0, 10000);

INSERT INTO Venda(Id_Venda, Data_de_Venda, Id_Cliente, Id_Fornecedor) VALUES(1, '2024-10-04', 1, 1);
INSERT INTO Venda(Id_Venda, Data_de_Venda, Id_Cliente, Id_Fornecedor) VALUES(2, '2024-10-04', 2, 2);

INSERT INTO Item(Id_Item, Preco_Unitario, Qtde, Id_Produto, Id_Venda) VALUES(1, 10.0, 1, 1, 1);
INSERT INTO Item(Id_Item, Preco_Unitario, Qtde, Id_Produto, Id_Venda) VALUES(2, 100.0, 2, 2, 2);

-- Update com calculo para o valor total da compra (É NECESSÁRIO COLOCAR O WHERE PARA NÃO AFETAR O COMANDO DE RESTRIÇÃO)
UPDATE Venda 
SET Total = (SELECT SUM(i.Qtde * i.Preco_Unitario) FROM Item i WHERE i.Id_Venda = Venda.Id_Venda) 
WHERE Id_Venda = 1;

UPDATE Venda 
SET Total = (SELECT SUM(i.Qtde * i.Preco_Unitario) FROM Item i WHERE i.Id_Venda = Venda.Id_Venda) 
WHERE Id_Venda = 2;

-- Lista com selects
SELECT * FROM Cliente;
SELECT * FROM Fornecedor;
SELECT * FROM Venda;
SELECT * FROM Produto;
SELECT * FROM Item;