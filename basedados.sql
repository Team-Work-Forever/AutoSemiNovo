CREATE TABLE Material (
    idMaterial SERIAL NOT NULL,
    nome VARCHAR(100) NOT NULL UNIQUE,
    PRIMARY key (idMaterial)
);

CREATE TABLE FormaPagamento (
    idFPagamento SERIAL NOT NULL,
    nome VARCHAR(100) NOT NULL UNIQUE,
    PRIMARY key (idFPagamento)
);

CREATE TABLE CodigoPostal (
    cPostal VARCHAR(8) NOT NULL,
    localidade VARCHAR(100) NOT NULL,
    PRIMARY key (cPostal)
);

CREATE TABLE TipoPneu (
    idTipoPneu SERIAL NOT NULL,
    nome VARCHAR(100) NOT NULL UNIQUE,
    PRIMARY key (idTipoPneu)
);

CREATE TABLE Jante (
    idJante SERIAL NOT NULL,
    nome VARCHAR(100) NOT NULL UNIQUE,
    PRIMARY key (idJante)
);

CREATE TABLE Tracao (
    idTracao SERIAL NOT NULL,
    nome VARCHAR(100) NOT NULL UNIQUE,
    PRIMARY key (idTracao)
);

CREATE TABLE Marca (
    idMarca SERIAL NOT NULL, 
    nome VARCHAR(100) NOT NULL UNIQUE, 
    stock INT NULL DEFAULT 0, 
    descricao VARCHAR(200) DEFAULT NULL,
    PRIMARY key (idMarca)
);

CREATE TABLE TipoVeiculo (
    idTipoVeiculo SERIAL NOT NULL, 
    nome VARCHAR(100) NOT NULL UNIQUE, 
    PRIMARY KEY (idTipoVeiculo)
);

CREATE TABLE Condicao (
    idCondicao SERIAL NOT NULL, 
    nome VARCHAR(100) NOT NULL UNIQUE, 
    PRIMARY key (idCondicao)
);

CREATE TABLE Combustivel (
    idCombustivel SERIAL NOT NULL, 
    nome VARCHAR(100) NOT NULL UNIQUE, 
    PRIMARY key (idCombustivel)
);

CREATE TABLE Caixa (
    idCaixa SERIAL NOT NULL, 
    nome VARCHAR(100) NOT NULL UNIQUE, 
    PRIMARY key (idCaixa)
);

CREATE TABLE TipoPintura (
    idTipoPintura SERIAL NOT NULL, 
    nome VARCHAR(100) NOT NULL, 
    PRIMARY key (idTipoPintura)
);

CREATE TABLE Estado (
    idEstado SERIAL NOT NULL, 
    nome VARCHAR(100) NOT NULL UNIQUE, 
    PRIMARY key (idEstado)
);

CREATE TABLE Motor (
    idMotor SERIAL NOT NULL, 
    nome VARCHAR(100) NOT NULL UNIQUE, 
    PRIMARY key (idMotor)
);

CREATE TABLE Cor (
    idCor SERIAL NOT NULL, 
    nome VARCHAR(100) NOT NULL UNIQUE, 
    PRIMARY key (idCor)
);

CREATE TABLE Modelo (
    idModelo SERIAL NOT NULL, 
    nome VARCHAR(100) NOT NULL UNIQUE, 
    stock INT NULL DEFAULT 0, 
    descrição VARCHAR(200) DEFAULT NULL, 
    idMarca INT NOT NULL,
    PRIMARY key (idModelo),
    CONSTRAINT idMarca_fk1
        FOREIGN KEY (idMarca)
            REFERENCES Marca (idMarca)
);

CREATE TABLE SegmentoVeiculo (
    idSegmento SERIAL NOT NULL, 
    nome VARCHAR(100) NOT NULL, 
    idTipoVeiculo INT NOT NULL,
    PRIMARY key (idSegmento),
    CONSTRAINT idTipoVeiculo_fk1
        FOREIGN key (idTipoVeiculo)
            REFERENCES TipoVeiculo (idTipoVeiculo)
);

CREATE TABLE Estofos (
    idEstofos SERIAL NOT NULL, 
    idMaterial INT NOT NULL,
    idCor INT NOT NULL,
    PRIMARY KEY (idEstofos),
    CONSTRAINT idCor_fk1
        FOREIGN KEY (idCor)
            REFERENCES Cor (idCor),
    CONSTRAINT idMaterial_fk2
        FOREIGN KEY (idMaterial)
            REFERENCES Material (idMaterial)
);

CREATE TABLE Pneu (
    idPneu SERIAL NOT NULL, 
    largura NUMERIC(9,2) NOT NULL CHECK(largura > 0), 
    perfil NUMERIC(9,2) NOT NULL CHECK(perfil > 0), 
    diametro NUMERIC(9,2) NOT NULL CHECK(diametro > 0), 
    idJante INT NOT NULL,
    idTipoPneu INT NOT NULL,
    idMarca INT NOT NULL,
    PRIMARY KEY (idPneu),
    CONSTRAINT idJante_fk1
        FOREIGN KEY (idJante)
            REFERENCES Jante (idJante),
    CONSTRAINT idTipoPneu_fk2
        FOREIGN KEY (idTipoPneu)
            REFERENCES TipoPneu (idTipoPneu),
    CONSTRAINT idMarca_fk3
        FOREIGN KEY (idMarca)
            REFERENCES Marca (idMarca)
);

CREATE TABLE Cliente (
    idCliente SERIAL NOT NULL, 
    nome VARCHAR(100) NOT NULL,
    nomeApelido VARCHAR(100) NOT NULL,
    rua VARCHAR(100) NOT NULL,
    nPorta INT NOT NULL CHECK(nPorta > 0),
    nif VARCHAR(9) NOT NULL,
    nCC NUMERIC(8) NOT NULL CHECK(nCC > 0),
    dataNasc DATE NOT NULL,
    telefone NUMERIC(9) NOT NULL,
    cPostal VARCHAR(8) NOT NULL,
    PRIMARY KEY (idCliente),
    CONSTRAINT cPostal_fk1
        FOREIGN KEY (cPostal)
            REFERENCES CodigoPostal (cPostal)
);

CREATE TABLE Aquisicao (
    numCompra SERIAL NOT NULL, 
    dataCompra DATE NOT NULL DEFAULT now(), 
    sinal NUMERIC(9,2) NOT NULL CHECK(sinal > 0), 
    idCliente INT NOT NULL,
    idEstado INT NOT NULL,
    PRIMARY KEY (numCompra),
    CONSTRAINT idCliente_fk1
        FOREIGN KEY (idCliente)
            REFERENCES Cliente (idCliente),
    CONSTRAINT idEstado_fk2
        FOREIGN KEY (idEstado)
            REFERENCES Estado (idEstado)
);

CREATE TABLE Fatura (
    numFatura SERIAL NOT NULL, 
    precoSIva NUMERIC(9,2) NOT NULL CHECK(precoSIva > 0), 
    precoCIva NUMERIC(9,2) DEFAULT NULL CHECK(precoCIva > 0), 
    taxa NUMERIC(9,2) NOT NULL CHECK(taxa > 0), 
    dataEmissao DATE NOT NULL DEFAULT now(), 
    extras NUMERIC(9,2) NOT NULL CHECK(extras >= 0), 
    numCompra INT NOT NULL,
    idFPagamento INT NOT NULL,
    PRIMARY KEY (numFatura),
    CONSTRAINT numCompra_fk1
        FOREIGN KEY (numCompra)
            REFERENCES Aquisicao (numCompra),
    CONSTRAINT idFPagamento_fk2
        FOREIGN KEY (idFPagamento)
            REFERENCES FormaPagamento (idFPagamento)
);

CREATE TABLE Vendedor (
    idVendedor SERIAL NOT NULL, 
    nome VARCHAR(100) NOT NULL, 
    nomeApelido VARCHAR(100) NOT NULL, 
    rua VARCHAR(100) NOT NULL, 
    nPorta INT NOT NULL CHECK(nPorta > 0), 
    cPostal VARCHAR(8) NOT NULL, 
    telefone NUMERIC(9) NOT NULL,
    PRIMARY KEY (idVendedor),
    CONSTRAINT cPostal_fk1
        FOREIGN KEY (cPostal)
            REFERENCES CodigoPostal (cPostal)
);

CREATE TABLE CorTipoPintura (
    idCor INT NOT NULL, 
    idTipoPintura INT NOT NULL, 
    PRIMARY KEY (idCor, idTipoPintura),
    CONSTRAINT idCor_fk1
        FOREIGN KEY (idCor)
            REFERENCES Cor (idCor),
    CONSTRAINT idTipoPintura_fk2
        FOREIGN KEY (idTipoPintura)
            REFERENCES TipoPintura (idTipoPintura)
);

CREATE TABLE Veiculo (
    matricula VARCHAR(8) NOT NULL, 
    precoBase NUMERIC(9,2) NOT NULL CHECK(precoBase > 0), 
    ano INT NOT NULL CHECK(ano > 0), 
    quilometros NUMERIC(9,2) NOT NULL CHECK(quilometros > 0), 
    cilindrada NUMERIC(9,2) NOT NULL CHECK(cilindrada >= 0), 
    potencia NUMERIC(9,2) NOT NULL CHECK(potencia > 0), 
    garantia INT NOT NULL DEFAULT 12, 
    nPorta INT NOT NULL CHECK(nPorta >= 0), 
    lotacao INT NOT NULL, 
    emissaoC02 NUMERIC(9,2) NOT NULL CHECK(emissaoC02 >= 0), 
    consumoUrbano NUMERIC(9,2) NOT NULL CHECK(consumoUrbano > 0), 
    nPneus INT NOT NULL CHECK(nPneus > 0),
    foiVendido BOOLEAN DEFAULT FALSE,
    idTracao INT NOT NULL, 
    idMotor INT NOT NULL, 
    idTipoVeiculo INT NOT NULL, 
    idSegmento INT NOT NULL,
    idCondicao INT NOT NULL, 
    corBase INT NOT NULL,
    tipoPintura INT NOT NULL,  
    corSecundaria INT DEFAULT NULL,
    tipoPinturaS INT DEFAULT NULL, 
    corInterior INT NOT NULL,
    idEstofos INT NOT NULL,
    idCaixa INT NOT NULL, 
    idCombustivel INT NOT NULL, 
    idModelo INT NOT NULL,
    PRIMARY KEY (matricula),
    CONSTRAINT idTracao_fk1
        FOREIGN KEY (idTracao)
            REFERENCES Tracao (idTracao),
    CONSTRAINT idMotor_fk2
        FOREIGN KEY (idMotor)
            REFERENCES Motor (idMotor),
    CONSTRAINT idTipoVeiculo_fk3
        FOREIGN KEY (idTipoVeiculo)
            REFERENCES TipoVeiculo (idTipoVeiculo),
    CONSTRAINT idSegmentoVeiculo_fk4
        FOREIGN KEY (idSegmento)
            REFERENCES SegmentoVeiculo (idSegmento),
    CONSTRAINT idCondicao_fk4
        FOREIGN KEY (idCondicao)
            REFERENCES Condicao (idCondicao),
    CONSTRAINT corBase_fk5
        FOREIGN KEY (corBase, tipoPintura)
            REFERENCES CorTipoPintura (idCor, idTipoPintura),
    CONSTRAINT corSecundaria_fk6
        FOREIGN KEY (corSecundaria, tipoPinturaS)
            REFERENCES CorTipoPintura (idCor, idTipoPintura),
    CONSTRAINT corInterior_fk7
        FOREIGN KEY (corInterior)
            REFERENCES Cor (idCor),
    CONSTRAINT idEstofos_fk8
        FOREIGN KEY (idEstofos)
            REFERENCES Estofos (idEstofos),
    CONSTRAINT idCaixa_fk9
        FOREIGN KEY (idCaixa)
            REFERENCES Caixa (idCaixa),
    CONSTRAINT idCombustivel_fk10
        FOREIGN KEY (idCombustivel)
            REFERENCES Combustivel (idCombustivel),
    CONSTRAINT idModelo_fk12
        FOREIGN KEY (idModelo)
            REFERENCES Modelo (idModelo)
);

CREATE TABLE LinhaCompra (
    numCompra INT NOT NULL, 
    matricula VARCHAR(8) DEFAULT NULL,
    quantidade INT NOT NULL CHECK(quantidade > 0),
    precoBase NUMERIC(9,2) NOT NULL CHECK(precoBase > 0),
    PRIMARY KEY (numCompra, matricula),
    CONSTRAINT numCompra_fk1
        FOREIGN KEY (numCompra)
            REFERENCES Aquisicao (numCompra),
    CONSTRAINT matricula_fk2
        FOREIGN KEY (matricula)
            REFERENCES Veiculo (matricula)
);

CREATE TABLE LinhaVendedor (
    numCompra INT NOT NULL, 
    idVendedor INT DEFAULT NULL,
    PRIMARY KEY (numCompra, idVendedor),
    CONSTRAINT numCompra_fk1
        FOREIGN KEY (numCompra)
            REFERENCES Aquisicao (numCompra),
    CONSTRAINT idVendedor_fk2
        FOREIGN KEY (idVendedor)
            REFERENCES Vendedor (idVendedor)
);

CREATE TABLE Pneus (
    nPneus SERIAL NOT NULL,
    matricula VARCHAR(8) NOT NULL, 
    idPneu INT NOT NULL,
    PRIMARY KEY (nPneus),
    CONSTRAINT matricula_fk1
        FOREIGN KEY (matricula)
            REFERENCES Veiculo (matricula),
    CONSTRAINT idPneu_fk2
        FOREIGN KEY (idPneu)
            REFERENCES Pneu (idPneu)
);


create or replace function log_somar_extras()
  returns trigger 
  language plpgsql
  as
$$
begin
	if new.extras > 0 then

        update fatura
        set precosiva = precosiva + new.extras
        where numfatura = new.numfatura;
	end if;

	return new;
end;
$$;
create or replace trigger somar_extras
  after insert
  on fatura
  for each row
  execute procedure log_somar_extras();


create or replace function log_preco_taxa()
  returns trigger 
  language plpgsql
  as
$$
begin
	if new.taxa > 0 then
        update fatura
        set precoCIva = precoSIva * (1 + (new.taxa / 100))
        where numfatura = new.numfatura;
	end if;

	return new;
end;
$$;
create or replace trigger preco_taxa
  after insert
  on fatura
  for each row
  execute procedure log_preco_taxa();


INSERT INTO formapagamento (nome) VALUES ('Pronto Pagamento');
INSERT INTO formapagamento (nome) VALUES ('Credito Automovel');
INSERT INTO formapagamento (nome) VALUES ('Financiamento');
INSERT INTO formapagamento (nome) VALUES ('Renting');
INSERT INTO formapagamento (nome) VALUES ('Numerário');

INSERT INTO codigopostal (cPostal, localidade) VALUES ('4490-666', 'Povoa de Varzim');
INSERT INTO codigopostal (cPostal, localidade) VALUES ('1000-139', 'Lisboa');
INSERT INTO codigopostal (cPostal, localidade) VALUES ('3360-139', 'Cantanhede');
INSERT INTO codigopostal (cPostal, localidade) VALUES ('2205-025', 'Abrantes');
INSERT INTO codigopostal (cPostal, localidade) VALUES ('4705-480', 'Braga');
INSERT INTO codigopostal (cPostal, localidade) VALUES ('4490-251', 'Povoa de Varzim');
INSERT INTO codigopostal (cPostal, localidade) VALUES ('4905-067', 'Barcelos');
INSERT INTO codigopostal (cPostal, localidade) VALUES ('3040-474', 'Coimbra');
INSERT INTO codigopostal (cPostal, localidade) VALUES ('3360-032', 'Penacova');
INSERT INTO codigopostal (cPostal, localidade) VALUES ('3420-177', 'Tabua');
INSERT INTO codigopostal (cPostal, localidade) VALUES ('4200-014', 'Porto');
INSERT INTO codigopostal (cPostal, localidade) VALUES ('4475-045', 'Maia');
INSERT INTO codigopostal (cPostal, localidade) VALUES ('4795-894', 'Santo Tirso');
INSERT INTO codigopostal (cPostal, localidade) VALUES ('4480-330', 'Vila do Conde');
INSERT INTO codigopostal (cPostal, localidade) VALUES ('4900-281', 'Viana do Castelo');
INSERT INTO codigopostal (cPostal, localidade) VALUES ('4940-027', 'Paredes de Coura');
INSERT INTO codigopostal (cPostal, localidade) VALUES ('2645-539', 'Cascais');
INSERT INTO codigopostal (cPostal, localidade) VALUES ('3520-039', 'Nelas');
INSERT INTO codigopostal (cPostal, localidade) VALUES ('7150-123', 'Borba');
INSERT INTO codigopostal (cPostal, localidade) VALUES ('2610-181', 'Amadora');

INSERT INTO tipopneu (nome) VALUES ('Pneu de Verao');
INSERT INTO tipopneu (nome) VALUES ('Pneu de Inverno');
INSERT INTO tipopneu (nome) VALUES ('Pneu de 4 estacoes');
INSERT INTO tipopneu (nome) VALUES ('Pneu com tecnologia Run-flat');

INSERT INTO jante (nome) VALUES ('Jantes de Ferro');
INSERT INTO jante (nome) VALUES ('Jantes de Liga Leve');

INSERT INTO tracao (nome) VALUES ('Tracao Dianteira');
INSERT INTO tracao (nome) VALUES ('Tracao Traseira');
INSERT INTO tracao (nome) VALUES ('Tracao 4x4');
INSERT INTO tracao (nome) VALUES ('Tracao AWD');

INSERT INTO marca (nome, stock) VALUES ('Porsche', 1);
INSERT INTO marca (nome, stock) VALUES ('BMW', 5);
INSERT INTO marca (nome, stock) VALUES ('Mercedes-Benz', 3);
INSERT INTO marca (nome, stock) VALUES ('Citroen', 3);
INSERT INTO marca (nome, stock) VALUES ('Fiat', 3);
INSERT INTO marca (nome, stock) VALUES ('Continental', 0);
INSERT INTO marca (nome, stock) VALUES ('Michelin', 0);
INSERT INTO marca (nome, stock) VALUES ('Bridgestone', 0);
INSERT INTO marca (nome, stock) VALUES ('Pirelli', 0);

INSERT INTO tipoveiculo (nome) VALUES ('Carro');
INSERT INTO tipoveiculo (nome) VALUES ('Camiao');
INSERT INTO tipoveiculo (nome) VALUES ('Mota');
INSERT INTO tipoveiculo (nome) VALUES ('Autocaravana');
INSERT INTO tipoveiculo (nome) VALUES ('Carrinha');

INSERT INTO condicao (nome) VALUES ('Usado');

INSERT INTO combustivel (nome) VALUES ('Diesel');
INSERT INTO combustivel (nome) VALUES ('Gasolina');
INSERT INTO combustivel (nome) VALUES ('Eletrico');

INSERT INTO caixa (nome) VALUES ('Automatica');
INSERT INTO caixa (nome) VALUES ('Manual');
INSERT INTO caixa (nome) VALUES ('Semi-Automatica');

INSERT INTO tipopintura (nome) VALUES ('Metalizado');
INSERT INTO tipopintura (nome) VALUES ('Perola');

INSERT INTO estado (nome) VALUES ('Concluida');
INSERT INTO estado (nome) VALUES ('Em progresso');
INSERT INTO estado (nome) VALUES ('Anulada');

INSERT INTO motor (nome) VALUES ('3.0-litre V6');

INSERT INTO cor (nome) VALUES ('Preto');
INSERT INTO cor (nome) VALUES ('Cinzento');
INSERT INTO cor (nome) VALUES ('Branco');
INSERT INTO cor (nome) VALUES ('Amarelo');
INSERT INTO cor (nome) VALUES ('Marron');
INSERT INTO cor (nome) VALUES ('Marron Escuro');
INSERT INTO cor (nome) VALUES ('Marron Claro');
INSERT INTO cor (nome) VALUES ('Vermelho');

INSERT INTO modelo (nome, stock, idMarca) VALUES ('Macan Spirit', 1, 1);
INSERT INTO modelo (nome, stock, idMarca) VALUES ('520 Serie 5', 1, 2);
INSERT INTO modelo (nome, stock, idMarca) VALUES ('X5 Serie X', 1, 2);
INSERT INTO modelo (nome, stock, idMarca) VALUES ('218 Serie 2', 1, 2);
INSERT INTO modelo (nome, stock, idMarca) VALUES ('R 1200 GS', 1, 2);
INSERT INTO modelo (nome, stock, idMarca) VALUES ('i3 Serie i', 1, 2);
INSERT INTO modelo (nome, stock, idMarca) VALUES ('CLA 45 AMG Classe CLA', 1, 3);
INSERT INTO modelo (nome, stock, idMarca) VALUES ('A 35 AMG Classe A', 1, 3);
INSERT INTO modelo (nome, stock, idMarca) VALUES ('Actros 1835L', 1, 3);
INSERT INTO modelo (nome, stock, idMarca) VALUES ('CX', 1, 4);
INSERT INTO modelo (nome, stock, idMarca) VALUES ('Jumper CamperVan', 1, 4);
INSERT INTO modelo (nome, stock, idMarca) VALUES ('C4 Cactus 1.2 PureTech Shine', 1, 4);
INSERT INTO modelo (nome, stock, idMarca) VALUES ('Ducato 2.0 Multijet L1H1', 1, 5);
INSERT INTO modelo (nome, stock, idMarca) VALUES ('500 1.3 16V Multijet Pop', 1, 5);
INSERT INTO modelo (nome, stock, idMarca) VALUES ('Ducato', 1, 5);

INSERT INTO segmentoveiculo (nome, idTipoVeiculo) VALUES ('SUV/TT', 1);
INSERT INTO segmentoveiculo (nome, idTipoVeiculo) VALUES ('Carrinha', 1);
INSERT INTO segmentoveiculo (nome, idTipoVeiculo) VALUES ('Coupe', 1);
INSERT INTO segmentoveiculo (nome, idTipoVeiculo) VALUES ('Utilitário', 1);
INSERT INTO segmentoveiculo (nome, idTipoVeiculo) VALUES ('Citadino', 1);
INSERT INTO segmentoveiculo (nome, idTipoVeiculo) VALUES ('Transportes', 2);
INSERT INTO segmentoveiculo (nome, idTipoVeiculo) VALUES ('Sedan', 1);
INSERT INTO segmentoveiculo (nome, idTipoVeiculo) VALUES ('Furgao', 4);
INSERT INTO segmentoveiculo (nome, idTipoVeiculo) VALUES ('Furgao', 5);
INSERT INTO segmentoveiculo (nome, idTipoVeiculo) VALUES ('Trail', 3);
INSERT INTO segmentoveiculo (nome, idTipoVeiculo) VALUES ('Pequeno Citadino', 1);
INSERT INTO segmentoveiculo (nome, idTipoVeiculo) VALUES ('Capucine', 1);

INSERT INTO material (nome) VALUES ('Couro');
INSERT INTO material (nome) VALUES ('Tecido');
INSERT INTO material (nome) VALUES ('Napa');

INSERT INTO estofos (idMaterial, idCor) VALUES (1, 1);
INSERT INTO estofos (idMaterial, idCor) VALUES (1, 2);
INSERT INTO estofos (idMaterial, idCor) VALUES (1, 3);
INSERT INTO estofos (idMaterial, idCor) VALUES (1, 4);
INSERT INTO estofos (idMaterial, idCor) VALUES (1, 5);
INSERT INTO estofos (idMaterial, idCor) VALUES (1, 6);
INSERT INTO estofos (idMaterial, idCor) VALUES (1, 7);
INSERT INTO estofos (idMaterial, idCor) VALUES (2, 1);
INSERT INTO estofos (idMaterial, idCor) VALUES (2, 2);
INSERT INTO estofos (idMaterial, idCor) VALUES (2, 3);
INSERT INTO estofos (idMaterial, idCor) VALUES (2, 4);
INSERT INTO estofos (idMaterial, idCor) VALUES (2, 5);
INSERT INTO estofos (idMaterial, idCor) VALUES (2, 6);
INSERT INTO estofos (idMaterial, idCor) VALUES (2, 7);
INSERT INTO estofos (idMaterial, idCor) VALUES (3, 1);
INSERT INTO estofos (idMaterial, idCor) VALUES (3, 2);
INSERT INTO estofos (idMaterial, idCor) VALUES (3, 3);
INSERT INTO estofos (idMaterial, idCor) VALUES (3, 4);
INSERT INTO estofos (idMaterial, idCor) VALUES (3, 5);
INSERT INTO estofos (idMaterial, idCor) VALUES (3, 6);
INSERT INTO estofos (idMaterial, idCor) VALUES (3, 7);

INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 55, 16, 1, 1, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 55, 16, 1, 2, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 55, 16, 1, 3, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 55, 16, 1, 4, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 55, 16, 2, 1, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 55, 16, 2, 2, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 55, 16, 2, 3, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 55, 16, 2, 4, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 55, 17, 1, 1, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 55, 17, 1, 2, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 55, 17, 1, 3, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 55, 17, 1, 4, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 55, 17, 2, 1, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 55, 17, 2, 2, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 55, 17, 2, 3, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 55, 17, 2, 4, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 55, 19, 1, 1, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 55, 19, 1, 2, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 55, 19, 1, 3, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 55, 19, 1, 4, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 55, 19, 2, 1, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 55, 19, 2, 2, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 55, 19, 2, 3, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 55, 19, 2, 4, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 45, 16, 1, 1, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 45, 16, 1, 2, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 45, 16, 1, 3, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 45, 16, 1, 4, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 45, 16, 2, 1, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 45, 16, 2, 2, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 45, 16, 2, 3, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 45, 16, 2, 4, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 45, 17, 1, 1, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 45, 17, 1, 2, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 45, 17, 1, 3, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 45, 17, 1, 4, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 45, 17, 2, 1, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 45, 17, 2, 2, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 45, 17, 2, 3, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 45, 17, 2, 4, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 45, 19, 1, 1, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 45, 19, 1, 2, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 45, 19, 1, 3, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 45, 19, 1, 4, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 45, 19, 2, 1, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 45, 19, 2, 2, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 45, 19, 2, 3, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (205, 45, 19, 2, 4, 7);

INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 55, 16, 1, 1, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 55, 16, 1, 2, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 55, 16, 1, 3, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 55, 16, 1, 4, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 55, 16, 2, 1, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 55, 16, 2, 2, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 55, 16, 2, 3, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 55, 16, 2, 4, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 55, 17, 1, 1, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 55, 17, 1, 2, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 55, 17, 1, 3, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 55, 17, 1, 4, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 55, 17, 2, 1, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 55, 17, 2, 2, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 55, 17, 2, 3, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 55, 17, 2, 4, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 55, 19, 1, 1, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 55, 19, 1, 2, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 55, 19, 1, 3, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 55, 19, 1, 4, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 55, 19, 2, 1, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 55, 19, 2, 2, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 55, 19, 2, 3, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 55, 19, 2, 4, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 45, 16, 1, 1, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 45, 16, 1, 2, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 45, 16, 1, 3, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 45, 16, 1, 4, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 45, 16, 2, 1, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 45, 16, 2, 2, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 45, 16, 2, 3, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 45, 16, 2, 4, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 45, 17, 1, 1, 9);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 45, 17, 1, 2, 9);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 45, 17, 1, 3, 9);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 45, 17, 1, 4, 9);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 45, 17, 2, 1, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 45, 17, 2, 2, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 45, 17, 2, 3, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 45, 17, 2, 4, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 45, 19, 1, 1, 9);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 45, 19, 1, 2, 9);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 45, 19, 1, 3, 9);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 45, 19, 1, 4, 9);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 45, 19, 2, 1, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 45, 19, 2, 2, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 45, 19, 2, 3, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (225, 45, 19, 2, 4, 7);

INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 55, 16, 1, 1, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 55, 16, 1, 2, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 55, 16, 1, 3, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 55, 16, 1, 4, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 55, 16, 2, 1, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 55, 16, 2, 2, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 55, 16, 2, 3, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 55, 16, 2, 4, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 55, 17, 1, 1, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 55, 17, 1, 2, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 55, 17, 1, 3, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 55, 17, 1, 4, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 55, 17, 2, 1, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 55, 17, 2, 2, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 55, 17, 2, 3, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 55, 17, 2, 4, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 55, 19, 1, 1, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 55, 19, 1, 2, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 55, 19, 1, 3, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 55, 19, 1, 4, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 55, 19, 2, 1, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 55, 19, 2, 2, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 55, 19, 2, 3, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 55, 19, 2, 4, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 45, 16, 1, 1, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 45, 16, 1, 2, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 45, 16, 1, 3, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 45, 16, 1, 4, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 45, 16, 2, 1, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 45, 16, 2, 2, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 45, 16, 2, 3, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 45, 16, 2, 4, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 45, 17, 1, 1, 9);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 45, 17, 1, 2, 9);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 45, 17, 1, 3, 9);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 45, 17, 1, 4, 9);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 45, 17, 2, 1, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 45, 17, 2, 2, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 45, 17, 2, 3, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 45, 17, 2, 4, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 45, 19, 1, 1, 9);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 45, 19, 1, 2, 9);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 45, 19, 1, 3, 9);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 45, 19, 1, 4, 9);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 45, 19, 2, 1, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 45, 19, 2, 2, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 45, 19, 2, 3, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (195, 45, 19, 2, 4, 7);

INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 55, 16, 1, 1, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 55, 16, 1, 2, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 55, 16, 1, 3, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 55, 16, 1, 4, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 55, 16, 2, 1, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 55, 16, 2, 2, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 55, 16, 2, 3, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 55, 16, 2, 4, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 55, 17, 1, 1, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 55, 17, 1, 2, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 55, 17, 1, 3, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 55, 17, 1, 4, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 55, 17, 2, 1, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 55, 17, 2, 2, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 55, 17, 2, 3, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 55, 17, 2, 4, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 55, 19, 1, 1, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 55, 19, 1, 2, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 55, 19, 1, 3, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 55, 19, 1, 4, 8);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 55, 19, 2, 1, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 55, 19, 2, 2, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 55, 19, 2, 3, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 55, 19, 2, 4, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 45, 16, 1, 1, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 45, 16, 1, 2, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 45, 16, 1, 3, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 45, 16, 1, 4, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 45, 16, 2, 1, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 45, 16, 2, 2, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 45, 16, 2, 3, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 45, 16, 2, 4, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 45, 17, 1, 1, 9);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 45, 17, 1, 2, 9);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 45, 17, 1, 3, 9);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 45, 17, 1, 4, 9);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 45, 17, 2, 1, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 45, 17, 2, 2, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 45, 17, 2, 3, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 45, 17, 2, 4, 6);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 45, 19, 1, 1, 9);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 45, 19, 1, 2, 9);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 45, 19, 1, 3, 9);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 45, 19, 1, 4, 9);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 45, 19, 2, 1, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 45, 19, 2, 2, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 45, 19, 2, 3, 7);
INSERT INTO pneu (largura, perfil, diametro, idJante, idTipoPneu, idMarca) VALUES (185, 45, 19, 2, 4, 7);

INSERT INTO cliente (nome, nomeApelido, nif, nCC, dataNasc, telefone, nPorta, rua, cPostal) VALUES ('David', 'Braga', 586479513, 87134920, '2003-02-05', 965864790, 10, 'Rua Granel', '4490-666');
INSERT INTO cliente (nome, nomeApelido, nif, nCC, dataNasc, telefone, nPorta, rua, cPostal) VALUES ('Gabriel', 'Capeta', 579157647, 21008764, '1999-12-20', 915700387, 45, 'Rua do Sube e Desce', '1000-139');
INSERT INTO cliente (nome, nomeApelido, nif, nCC, dataNasc, telefone, nPorta, rua, cPostal) VALUES ('Hugo', 'Guedes', 947861816, 10348942, '1975-05-23', 918700249, 99, 'Rua Manuel Oliveira', '3360-139');
INSERT INTO cliente (nome, nomeApelido, nif, nCC, dataNasc, telefone, nPorta, rua, cPostal) VALUES ('Francisco', 'Aventura', 247940385, 24860078, '1969-09-01', 937591305, 69, 'Avenida Castro', '2205-025');
INSERT INTO cliente (nome, nomeApelido, nif, nCC, dataNasc, telefone, nPorta, rua, cPostal) VALUES ('Afonso', 'Fonseca', 792136489, 12467259, '1986-04-20', 968600579, 33, 'Rua Jorge Miguel', '4705-480');

INSERT INTO aquisicao (dataCompra, sinal, idCliente, idEstado) VALUES ('2022-02-15', 90, 1, 1);
INSERT INTO aquisicao (dataCompra, sinal, idCliente, idEstado) VALUES ('2021-05-06', 150, 2, 3);
INSERT INTO aquisicao (dataCompra, sinal, idCliente, idEstado) VALUES ('2022-12-16', 16000, 4, 1);
INSERT INTO aquisicao (dataCompra, sinal, idCliente, idEstado) VALUES ('2023-01-17', 40, 2, 2);

INSERT INTO fatura (precoSIva, taxa, extras, numCompra, idFPagamento) VALUES (77500, 23, 0, 1, 1);
INSERT INTO fatura (precoSIva, taxa, extras, numCompra, idFPagamento) VALUES (60500, 23, 2000, 3, 3);
INSERT INTO fatura (precoSIva, taxa, extras, numCompra, idFPagamento) VALUES (46500, 23, 5000, 4, 4); 

INSERT INTO vendedor (nome, nomeApelido, telefone, nPorta, rua, cPostal) VALUES ('Diogo', 'Assuncao', 967216982, 15, 'Rua Fernando Pessoa', '4490-251');
INSERT INTO vendedor (nome, nomeApelido, telefone, nPorta, rua, cPostal) VALUES ('Albertina', 'Ferreira', 910463870, 06, 'Avenida Flores', '4905-067');
INSERT INTO vendedor (nome, nomeApelido, telefone, nPorta, rua, cPostal) VALUES ('Andre', 'Ventura', 930279802, 66, 'Avenida Ventaria', '3040-474');
INSERT INTO vendedor (nome, nomeApelido, telefone, nPorta, rua, cPostal) VALUES ('Rui', 'Foste', 93480357, 2820, 'Rua Fuge', '3360-032');
INSERT INTO vendedor (nome, nomeApelido, telefone, nPorta, rua, cPostal) VALUES ('Maia', 'Maria', 917503249, 220, 'Rua Cesario Verde', '3420-177');

INSERT INTO cortipopintura (idCor, idTipoPintura) VALUES (1, 1);
INSERT INTO cortipopintura (idCor, idTipoPintura) VALUES (2, 1);
INSERT INTO cortipopintura (idCor, idTipoPintura) VALUES (3, 1);
INSERT INTO cortipopintura (idCor, idTipoPintura) VALUES (4, 1);
INSERT INTO cortipopintura (idCor, idTipoPintura) VALUES (5, 1);
INSERT INTO cortipopintura (idCor, idTipoPintura) VALUES (6, 1);
INSERT INTO cortipopintura (idCor, idTipoPintura) VALUES (7, 1);
INSERT INTO cortipopintura (idCor, idTipoPintura) VALUES (8, 1);
INSERT INTO cortipopintura (idCor, idTipoPintura) VALUES (1, 2);
INSERT INTO cortipopintura (idCor, idTipoPintura) VALUES (2, 2);
INSERT INTO cortipopintura (idCor, idTipoPintura) VALUES (3, 2);
INSERT INTO cortipopintura (idCor, idTipoPintura) VALUES (4, 2);
INSERT INTO cortipopintura (idCor, idTipoPintura) VALUES (5, 2);
INSERT INTO cortipopintura (idCor, idTipoPintura) VALUES (6, 2);
INSERT INTO cortipopintura (idCor, idTipoPintura) VALUES (7, 2);
INSERT INTO cortipopintura (idCor, idTipoPintura) VALUES (8, 2);

INSERT INTO veiculo (matricula, precoBase, ano, quilometros, cilindrada, potencia, garantia, nPorta, lotacao, emissaoC02, consumoUrbano, nPneus, foiVendido, idTracao, idMotor, idTipoVeiculo, idSegmento, idCondicao, corBase, tipoPintura, corSecundaria, tipoPinturaS, corInterior, idEstofos, idCaixa, idCombustivel, idModelo) VALUES ('RE-99-01', 77500, 2019, 56083,  1984, 245, 18, 5, 5, 20,  5.50,  4, TRUE,  4, 1, 1, 1, 1, 1, 1, null, null,  1, 2,  2, 2, 1);
INSERT INTO veiculo (matricula, precoBase, ano, quilometros, cilindrada, potencia, garantia, nPorta, lotacao, emissaoC02, consumoUrbano, nPneus, foiVendido, idTracao, idMotor, idTipoVeiculo, idSegmento, idCondicao, corBase, tipoPintura, corSecundaria, tipoPinturaS, corInterior, idEstofos, idCaixa, idCombustivel, idModelo) VALUES ('32-BU-86', 43999, 2019, 45000,  1995, 190, 18, 5, 5, 20,  5.50,  4, FALSE, 2, 1, 1, 2, 1, 2, 1, null, null,  1, 6,  1, 1, 2);
INSERT INTO veiculo (matricula, precoBase, ano, quilometros, cilindrada, potencia, garantia, nPorta, lotacao, emissaoC02, consumoUrbano, nPneus, foiVendido, idTracao, idMotor, idTipoVeiculo, idSegmento, idCondicao, corBase, tipoPintura, corSecundaria, tipoPinturaS, corInterior, idEstofos, idCaixa, idCombustivel, idModelo) VALUES ('78-YZ-27', 14900, 2005, 221000, 2993, 218, 18, 5, 5, 20,  5.50,  4, FALSE, 4, 1, 1, 8, 1, 2, 2, null, null,  2, 2,  1, 1, 3);
INSERT INTO veiculo (matricula, precoBase, ano, quilometros, cilindrada, potencia, garantia, nPorta, lotacao, emissaoC02, consumoUrbano, nPneus, foiVendido, idTracao, idMotor, idTipoVeiculo, idSegmento, idCondicao, corBase, tipoPintura, corSecundaria, tipoPinturaS, corInterior, idEstofos, idCaixa, idCombustivel, idModelo) VALUES ('45-FU-03', 25990, 2018, 99999,  1995, 150, 36, 2, 4, 20,  5.50,  4, FALSE, 1, 1, 1, 3, 1, 2, 1, null, null,  2, 2,  1, 1, 4);
INSERT INTO veiculo (matricula, precoBase, ano, quilometros, cilindrada, potencia, garantia, nPorta, lotacao, emissaoC02, consumoUrbano, nPneus, foiVendido, idTracao, idMotor, idTipoVeiculo, idSegmento, idCondicao, corBase, tipoPintura, corSecundaria, tipoPinturaS, corInterior, idEstofos, idCaixa, idCombustivel, idModelo) VALUES ('76-VE-35', 12250, 2010, 64545,  1200, 190, 18, 0, 2, 20,  5.50,  2, TRUE, 2, 1, 3, 10, 1, 3, 1, 8,    2,     1, 15, 1, 2, 5);
INSERT INTO veiculo (matricula, precoBase, ano, quilometros, cilindrada, potencia, garantia, nPorta, lotacao, emissaoC02, consumoUrbano, nPneus, foiVendido, idTracao, idMotor, idTipoVeiculo, idSegmento, idCondicao, corBase, tipoPintura, corSecundaria, tipoPinturaS, corInterior, idEstofos, idCaixa, idCombustivel, idModelo) VALUES ('19-OU-09', 24900, 2017, 24000,  0,    170, 18, 5, 4, 0,   5.50,  4, FALSE, 4, 1, 1, 4, 1, 2, 1, null, null,  2, 2,  1, 3, 6);
INSERT INTO veiculo (matricula, precoBase, ano, quilometros, cilindrada, potencia, garantia, nPorta, lotacao, emissaoC02, consumoUrbano, nPneus, foiVendido, idTracao, idMotor, idTipoVeiculo, idSegmento, idCondicao, corBase, tipoPintura, corSecundaria, tipoPinturaS, corInterior, idEstofos, idCaixa, idCombustivel, idModelo) VALUES ('63-YS-94', 86000, 2021, 6500,   1991, 421, 24, 5, 5, 20,  10.30, 4, FALSE, 2, 1, 1, 2, 1, 1, 2, null, null,  1, 1,  1, 2, 7);
INSERT INTO veiculo (matricula, precoBase, ano, quilometros, cilindrada, potencia, garantia, nPorta, lotacao, emissaoC02, consumoUrbano, nPneus, foiVendido, idTracao, idMotor, idTipoVeiculo, idSegmento, idCondicao, corBase, tipoPintura, corSecundaria, tipoPinturaS, corInterior, idEstofos, idCaixa, idCombustivel, idModelo) VALUES ('54-LI-24', 60500, 2021, 12000,  1991, 306, 18, 5, 5, 192, 5.50,  4, TRUE, 2, 1, 1, 5, 1, 4, 2, null, null,  6, 7,  1, 2, 8);
INSERT INTO veiculo (matricula, precoBase, ano, quilometros, cilindrada, potencia, garantia, nPorta, lotacao, emissaoC02, consumoUrbano, nPneus, foiVendido, idTracao, idMotor, idTipoVeiculo, idSegmento, idCondicao, corBase, tipoPintura, corSecundaria, tipoPinturaS, corInterior, idEstofos, idCaixa, idCombustivel, idModelo) VALUES ('93-GE-27', 36900, 2004, 676500, 11946,354, 18, 3, 2, 20,  5.50,  6, FALSE, 2, 1, 2, 6, 1, 3, 1, null, null,  3, 9,  3, 1, 9);
INSERT INTO veiculo (matricula, precoBase, ano, quilometros, cilindrada, potencia, garantia, nPorta, lotacao, emissaoC02, consumoUrbano, nPneus, foiVendido, idTracao, idMotor, idTipoVeiculo, idSegmento, idCondicao, corBase, tipoPintura, corSecundaria, tipoPinturaS, corInterior, idEstofos, idCaixa, idCombustivel, idModelo) VALUES ('69-DF-52', 13000, 1977, 2348,   2348, 113, 18, 5, 5, 20,  5.50,  4, FALSE, 2, 1, 1, 7, 1, 2, 1, null, null, 2, 8,  2, 2, 10);
INSERT INTO veiculo (matricula, precoBase, ano, quilometros, cilindrada, potencia, garantia, nPorta, lotacao, emissaoC02, consumoUrbano, nPneus, foiVendido, idTracao, idMotor, idTipoVeiculo, idSegmento, idCondicao, corBase, tipoPintura, corSecundaria, tipoPinturaS, corInterior, idEstofos, idCaixa, idCombustivel, idModelo) VALUES ('94-LD-53', 46500, 2015, 100000, 2200, 150, 12, 4, 5, 20,  5.50,  4, TRUE, 2, 1, 4, 8, 1, 2, 1, null, null, 2, 2,  2, 1, 11);
INSERT INTO veiculo (matricula, precoBase, ano, quilometros, cilindrada, potencia, garantia, nPorta, lotacao, emissaoC02, consumoUrbano, nPneus, foiVendido, idTracao, idMotor, idTipoVeiculo, idSegmento, idCondicao, corBase, tipoPintura, corSecundaria, tipoPinturaS, corInterior, idEstofos, idCaixa, idCombustivel, idModelo) VALUES ('38-NS-73', 12900, 2015, 144000, 1199, 110, 36, 5, 5, 107, 5,     4, FALSE, 3, 1, 1, 4, 1, 2, 2, 1,    2,    1, 9,  2, 1, 12);
INSERT INTO veiculo (matricula, precoBase, ano, quilometros, cilindrada, potencia, garantia, nPorta, lotacao, emissaoC02, consumoUrbano, nPneus, foiVendido, idTracao, idMotor, idTipoVeiculo, idSegmento, idCondicao, corBase, tipoPintura, corSecundaria, tipoPinturaS, corInterior, idEstofos, idCaixa, idCombustivel, idModelo) VALUES ('18-FE-38', 15700, 2018, 98600,  2000, 115, 18, 5, 3, 130, 15.50, 4, FALSE, 1, 1, 5, 8, 1, 3, 1, 1,    1,    2, 15, 2, 1, 13);
INSERT INTO veiculo (matricula, precoBase, ano, quilometros, cilindrada, potencia, garantia, nPorta, lotacao, emissaoC02, consumoUrbano, nPneus, foiVendido, idTracao, idMotor, idTipoVeiculo, idSegmento, idCondicao, corBase, tipoPintura, corSecundaria, tipoPinturaS, corInterior, idEstofos, idCaixa, idCombustivel, idModelo) VALUES ('84-IE-75', 7980,  2008, 134000, 1248, 75,  18, 3, 5, 20,  5.30,  4, FALSE, 2, 1, 1, 11, 1, 3, 1, 1,    2,    3, 3,  2, 1, 14);
INSERT INTO veiculo (matricula, precoBase, ano, quilometros, cilindrada, potencia, garantia, nPorta, lotacao, emissaoC02, consumoUrbano, nPneus, foiVendido, idTracao, idMotor, idTipoVeiculo, idSegmento, idCondicao, corBase, tipoPintura, corSecundaria, tipoPinturaS, corInterior, idEstofos, idCaixa, idCombustivel, idModelo) VALUES ('52-NE-29', 18500, 1999, 145000, 2800, 115, 18, 3, 5, 70,  15.50, 4, FALSE, 2, 1, 4, 12, 1, 3, 1, null, null, 2, 8,  1, 1, 15);

INSERT INTO linhacompra (numCompra, matricula, quantidade, precoBase) VALUES (1, 'RE-99-01', 1, 77500);
INSERT INTO linhacompra (numCompra, matricula, quantidade, precoBase) VALUES (1, '76-VE-35', 1, 12250);
INSERT INTO linhacompra (numCompra, matricula, quantidade, precoBase) VALUES (2, '32-BU-86', 1, 43999);
INSERT INTO linhacompra (numCompra, matricula, quantidade, precoBase) VALUES (3, '54-LI-24', 1, 60500);
INSERT INTO linhacompra (numCompra, matricula, quantidade, precoBase) VALUES (4, '94-LD-53', 1, 46500);

INSERT INTO linhavendedor (numCompra, idVendedor) VALUES (1, 1);
INSERT INTO linhavendedor (numCompra, idVendedor) VALUES (1, 2);
INSERT INTO linhavendedor (numCompra, idVendedor) VALUES (2, 5);
INSERT INTO linhavendedor (numCompra, idVendedor) VALUES (3, 1);
INSERT INTO linhavendedor (numCompra, idVendedor) VALUES (4, 3);

INSERT INTO pneus (matricula, idPneu) VALUES ('RE-99-01', 115);
INSERT INTO pneus (matricula, idPneu) VALUES ('RE-99-01', 115);
INSERT INTO pneus (matricula, idPneu) VALUES ('RE-99-01', 115);
INSERT INTO pneus (matricula, idPneu) VALUES ('RE-99-01', 115);

INSERT INTO pneus (matricula, idPneu) VALUES ('32-BU-86', 85);
INSERT INTO pneus (matricula, idPneu) VALUES ('32-BU-86', 85);
INSERT INTO pneus (matricula, idPneu) VALUES ('32-BU-86', 85);
INSERT INTO pneus (matricula, idPneu) VALUES ('32-BU-86', 85);

INSERT INTO pneus (matricula, idPneu) VALUES ('78-YZ-27', 15);
INSERT INTO pneus (matricula, idPneu) VALUES ('78-YZ-27', 15);
INSERT INTO pneus (matricula, idPneu) VALUES ('78-YZ-27', 15);
INSERT INTO pneus (matricula, idPneu) VALUES ('78-YZ-27', 15);

INSERT INTO pneus (matricula, idPneu) VALUES ('45-FU-03', 127);
INSERT INTO pneus (matricula, idPneu) VALUES ('45-FU-03', 127);
INSERT INTO pneus (matricula, idPneu) VALUES ('45-FU-03', 127);
INSERT INTO pneus (matricula, idPneu) VALUES ('45-FU-03', 127);

INSERT INTO pneus (matricula, idPneu) VALUES ('76-VE-35', 150);
INSERT INTO pneus (matricula, idPneu) VALUES ('76-VE-35', 150);

INSERT INTO pneus (matricula, idPneu) VALUES ('19-OU-09', 5);
INSERT INTO pneus (matricula, idPneu) VALUES ('19-OU-09', 5);
INSERT INTO pneus (matricula, idPneu) VALUES ('19-OU-09', 5);
INSERT INTO pneus (matricula, idPneu) VALUES ('19-OU-09', 5);

INSERT INTO pneus (matricula, idPneu) VALUES ('63-YS-94', 49);
INSERT INTO pneus (matricula, idPneu) VALUES ('63-YS-94', 49);
INSERT INTO pneus (matricula, idPneu) VALUES ('63-YS-94', 49);
INSERT INTO pneus (matricula, idPneu) VALUES ('63-YS-94', 49);

INSERT INTO pneus (matricula, idPneu) VALUES ('54-LI-24', 78);
INSERT INTO pneus (matricula, idPneu) VALUES ('54-LI-24', 78);
INSERT INTO pneus (matricula, idPneu) VALUES ('54-LI-24', 78);
INSERT INTO pneus (matricula, idPneu) VALUES ('54-LI-24', 78);

INSERT INTO pneus (matricula, idPneu) VALUES ('93-GE-27', 168);
INSERT INTO pneus (matricula, idPneu) VALUES ('93-GE-27', 168);
INSERT INTO pneus (matricula, idPneu) VALUES ('93-GE-27', 168);
INSERT INTO pneus (matricula, idPneu) VALUES ('93-GE-27', 168);
INSERT INTO pneus (matricula, idPneu) VALUES ('93-GE-27', 168);
INSERT INTO pneus (matricula, idPneu) VALUES ('93-GE-27', 168);

INSERT INTO pneus (matricula, idPneu) VALUES ('69-DF-52', 72);
INSERT INTO pneus (matricula, idPneu) VALUES ('69-DF-52', 72);
INSERT INTO pneus (matricula, idPneu) VALUES ('69-DF-52', 72);
INSERT INTO pneus (matricula, idPneu) VALUES ('69-DF-52', 72);

INSERT INTO pneus (matricula, idPneu) VALUES ('94-LD-53', 33);
INSERT INTO pneus (matricula, idPneu) VALUES ('94-LD-53', 33);
INSERT INTO pneus (matricula, idPneu) VALUES ('94-LD-53', 33);
INSERT INTO pneus (matricula, idPneu) VALUES ('94-LD-53', 33);

INSERT INTO pneus (matricula, idPneu) VALUES ('38-NS-73', 22);
INSERT INTO pneus (matricula, idPneu) VALUES ('38-NS-73', 22);
INSERT INTO pneus (matricula, idPneu) VALUES ('38-NS-73', 22);
INSERT INTO pneus (matricula, idPneu) VALUES ('38-NS-73', 22);

INSERT INTO pneus (matricula, idPneu) VALUES ('18-FE-38', 14);
INSERT INTO pneus (matricula, idPneu) VALUES ('18-FE-38', 14);
INSERT INTO pneus (matricula, idPneu) VALUES ('18-FE-38', 14);
INSERT INTO pneus (matricula, idPneu) VALUES ('18-FE-38', 14);

INSERT INTO pneus (matricula, idPneu) VALUES ('84-IE-75', 7);
INSERT INTO pneus (matricula, idPneu) VALUES ('84-IE-75', 7);
INSERT INTO pneus (matricula, idPneu) VALUES ('84-IE-75', 7);
INSERT INTO pneus (matricula, idPneu) VALUES ('84-IE-75', 7);

INSERT INTO pneus (matricula, idPneu) VALUES ('52-NE-29', 26);
INSERT INTO pneus (matricula, idPneu) VALUES ('52-NE-29', 26);
INSERT INTO pneus (matricula, idPneu) VALUES ('52-NE-29', 26);
INSERT INTO pneus (matricula, idPneu) VALUES ('52-NE-29', 26);

create view infoveiculos (matricula, precoBase, ano, quilometros, cilindrada, potencia, garantia, nPorta, lotacao, emissaoC02, consumoUrbano, nPneus, foiVendido, atracao, motor, caixa, combustivel, modelo, marca, condicao, corBase, corSecundaria, corInterior, tipoVeiculo, segmentoVeiculo, estofos)
as select v.matricula, v.precoBase, v.ano, v.quilometros, v.cilindrada, v.potencia, v.garantia, v.nPorta, v.lotacao, v.emissaoC02, v.consumoUrbano, v.nPneus, v.foiVendido, t.nome, m.nome, cai.nome, com.nome, mod.nome, mar.nome, con.nome, c.nome || ' ' || tp.nome, cs.nome || ' ' || tps.nome, ci.nome, tv.nome, sgv.nome,  'Estofos de ' || mat.nome || ' com cor ' || cest.nome
from veiculo v
inner join tracao t 
    on v.idTracao = t.idTracao
inner join motor m 
    on v.idMotor = m.idMotor
inner join caixa cai 
    on v.idCaixa = cai.idCaixa
inner join combustivel com 
    on v.idCombustivel = com.idCombustivel
inner join modelo mod 
    on v.idModelo = mod.idModelo
inner join marca mar 
    on mod.idMarca = mar.idMarca
inner join condicao con
    on v.idCondicao = con.idCondicao
inner join cortipopintura ctp
    on (v.corBase = ctp.idCor and v.tipoPintura = ctp.idTipoPintura)
inner join cor c
    on ctp.idCor = c.idCor
inner join tipoPintura tp
    on ctp.idTipoPintura = tp.idTipoPintura
left join cortipopintura ctps
    on (v.corSecundaria = ctps.idCor and v.tipoPinturaS = ctps.idTipoPintura)
left join cor cs
    on ctps.idCor = cs.idCor
left join tipoPintura tps
    on ctps.idTipoPintura = tps.idTipoPintura
inner join cor ci
    on v.corInterior = ci.idCor
inner join tipoveiculo tv
    on v.idTipoVeiculo = tv.idTipoVeiculo
inner join segmentoveiculo sgv
    on v.idSegmento = sgv.idSegmento
inner join estofos est
    on v.idEstofos = est.idEstofos
inner join material mat
    on est.idMaterial = mat.idMaterial
inner join cor cest
    on est.idCor = cest.idCor
;

create view veiculosPneu(matricula, largura, perfil, diametro, jante, tipoPneu, marca)
as select v.matricula, p.largura, p.perfil, p.diametro, j.nome, tp.nome, m.nome
from veiculo v
inner join pneus ps
    on v.matricula = ps.matricula
inner join pneu p
    on ps.idPneu = p.idPneu
inner join jante j
    on p.idJante = j.idJante
inner join tipopneu tp
    on p.idTipoPneu = tp.idTipoPneu
inner join marca m
    on p.idMarca = m.idMarca
;

create unique index indexMatricula
on veiculo (matricula);

create unique index indexAquisicao
on aquisicao (numCompra);