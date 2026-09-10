-- ============================================================================
-- TRABALHO II — NORMALIZAÇÃO DE BASE DE DADOS
-- Sistema de Gestão de Funcionários — Universidade Licungo
-- Script DDL: criação do esquema normalizado (4FN)
-- ============================================================================

CREATE DATABASE IF NOT EXISTS gestao_funcionarios
    CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE gestao_funcionarios;

-- ----------------------------------------------------------------------------
-- Hierarquia geográfica (elimina a dependência transitiva
-- cidade -> provincia -> pais)
-- ----------------------------------------------------------------------------
CREATE TABLE pais (
    nome_pais       VARCHAR(60)  NOT NULL,
    PRIMARY KEY (nome_pais)
);

CREATE TABLE provincia (
    nome_provincia  VARCHAR(60)  NOT NULL,
    pais            VARCHAR(60)  NOT NULL,
    PRIMARY KEY (nome_provincia),
    CONSTRAINT fk_provincia_pais
        FOREIGN KEY (pais) REFERENCES pais(nome_pais)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE cidade (
    nome_cidade     VARCHAR(60)  NOT NULL,
    provincia       VARCHAR(60)  NOT NULL,
    PRIMARY KEY (nome_cidade),
    CONSTRAINT fk_cidade_provincia
        FOREIGN KEY (provincia) REFERENCES provincia(nome_provincia)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- ----------------------------------------------------------------------------
-- Tabelas de referência (eliminam a dependência transitiva
-- nuit -> cod_cargo -> nome_cargo, e equivalente para função)
-- ----------------------------------------------------------------------------
CREATE TABLE cargo (
    cod_cargo       VARCHAR(10)  NOT NULL,
    nome_cargo      VARCHAR(80)  NOT NULL,
    PRIMARY KEY (cod_cargo)
);

CREATE TABLE funcao (
    cod_funcao      VARCHAR(10)  NOT NULL,
    nome_funcao     VARCHAR(80)  NOT NULL,
    PRIMARY KEY (cod_funcao)
);

CREATE TABLE posto_trabalho (
    cod_posto       VARCHAR(10)  NOT NULL,
    nome_posto      VARCHAR(80)  NOT NULL,
    cidade          VARCHAR(60)  NOT NULL,
    PRIMARY KEY (cod_posto),
    CONSTRAINT fk_posto_cidade
        FOREIGN KEY (cidade) REFERENCES cidade(nome_cidade)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- ----------------------------------------------------------------------------
-- Entidade principal (3FN: apenas atributos que dependem inteira e
-- diretamente do NUIT)
-- ----------------------------------------------------------------------------
CREATE TABLE funcionario (
    nuit            VARCHAR(9)   NOT NULL,
    nome            VARCHAR(120) NOT NULL,
    data_nasc       DATE         NOT NULL,
    bi              VARCHAR(20)  NOT NULL,
    email           VARCHAR(120) NOT NULL,
    rua_avenida     VARCHAR(120) NOT NULL,
    numero          VARCHAR(10),
    bairro          VARCHAR(80)  NOT NULL,
    data_admissao   DATE         NOT NULL,
    cidade          VARCHAR(60)  NOT NULL,
    cod_cargo       VARCHAR(10)  NOT NULL,
    cod_funcao      VARCHAR(10)  NOT NULL,
    cod_posto       VARCHAR(10)  NOT NULL,
    PRIMARY KEY (nuit),
    UNIQUE (bi),
    UNIQUE (email),
    CONSTRAINT fk_func_cidade
        FOREIGN KEY (cidade) REFERENCES cidade(nome_cidade)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_func_cargo
        FOREIGN KEY (cod_cargo) REFERENCES cargo(cod_cargo)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_func_funcao
        FOREIGN KEY (cod_funcao) REFERENCES funcao(cod_funcao)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_func_posto
        FOREIGN KEY (cod_posto) REFERENCES posto_trabalho(cod_posto)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- ----------------------------------------------------------------------------
-- Grupos repetitivos extraídos na 1FN — mantidos como tabelas independentes
-- na 4FN, pois filhos e telefones são dependências multivaloradas
-- independentes entre si (nenhum determina o outro)
-- ----------------------------------------------------------------------------
CREATE TABLE filho (
    id_filho         INT AUTO_INCREMENT,
    nuit_funcionario VARCHAR(9)   NOT NULL,
    nome_filho       VARCHAR(120) NOT NULL,
    PRIMARY KEY (id_filho),
    CONSTRAINT fk_filho_funcionario
        FOREIGN KEY (nuit_funcionario) REFERENCES funcionario(nuit)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE telefone (
    id_telefone      INT AUTO_INCREMENT,
    nuit_funcionario VARCHAR(9)  NOT NULL,
    numero_celular   VARCHAR(15) NOT NULL,
    PRIMARY KEY (id_telefone),
    CONSTRAINT fk_telefone_funcionario
        FOREIGN KEY (nuit_funcionario) REFERENCES funcionario(nuit)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- Índices de apoio às pesquisas mais comuns
CREATE INDEX idx_filho_nuit     ON filho(nuit_funcionario);
CREATE INDEX idx_telefone_nuit  ON telefone(nuit_funcionario);
CREATE INDEX idx_func_cidade    ON funcionario(cidade);
CREATE INDEX idx_func_cargo     ON funcionario(cod_cargo);
