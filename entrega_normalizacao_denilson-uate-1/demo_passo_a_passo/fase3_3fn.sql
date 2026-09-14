-- ============================================================================
-- FASE 3 — TERCEIRA FORMA NORMAL (3FN)
-- Ação: eliminar as dependências TRANSITIVAS identificadas na fase 2,
-- extraindo cargo, função e a hierarquia geográfica para tabelas de referência.
-- ============================================================================
USE normalizacao_demo;

DROP TABLE IF EXISTS pais_3fn;
CREATE TABLE pais_3fn (nome_pais VARCHAR(60) PRIMARY KEY);

DROP TABLE IF EXISTS provincia_3fn;
CREATE TABLE provincia_3fn (
    nome_provincia VARCHAR(60) PRIMARY KEY,
    pais VARCHAR(60) NOT NULL,
    FOREIGN KEY (pais) REFERENCES pais_3fn(nome_pais)
);

DROP TABLE IF EXISTS cidade_3fn;
CREATE TABLE cidade_3fn (
    nome_cidade VARCHAR(60) PRIMARY KEY,
    provincia VARCHAR(60) NOT NULL,
    FOREIGN KEY (provincia) REFERENCES provincia_3fn(nome_provincia)
);

DROP TABLE IF EXISTS cargo_3fn;
CREATE TABLE cargo_3fn (cod_cargo VARCHAR(10) PRIMARY KEY, nome_cargo VARCHAR(80) NOT NULL);

DROP TABLE IF EXISTS funcao_3fn;
CREATE TABLE funcao_3fn (cod_funcao VARCHAR(10) PRIMARY KEY, nome_funcao VARCHAR(80) NOT NULL);

DROP TABLE IF EXISTS posto_trabalho_3fn;
CREATE TABLE posto_trabalho_3fn (
    cod_posto VARCHAR(10) PRIMARY KEY,
    nome_posto VARCHAR(80) NOT NULL,
    cidade VARCHAR(60) NOT NULL,
    FOREIGN KEY (cidade) REFERENCES cidade_3fn(nome_cidade)
);

DROP TABLE IF EXISTS funcionario_3fn;
CREATE TABLE funcionario_3fn (
    nuit            VARCHAR(9) PRIMARY KEY,
    nome            VARCHAR(120) NOT NULL,
    data_nasc       DATE NOT NULL,
    bi              VARCHAR(20) NOT NULL,
    email           VARCHAR(120) NOT NULL,
    rua_avenida     VARCHAR(120) NOT NULL,
    numero          VARCHAR(10),
    bairro          VARCHAR(80) NOT NULL,
    cidade          VARCHAR(60) NOT NULL,
    cod_cargo       VARCHAR(10) NOT NULL,
    cod_funcao      VARCHAR(10) NOT NULL,
    cod_posto       VARCHAR(10) NOT NULL,
    data_admissao   DATE NOT NULL,
    FOREIGN KEY (cidade)     REFERENCES cidade_3fn(nome_cidade),
    FOREIGN KEY (cod_cargo)  REFERENCES cargo_3fn(cod_cargo),
    FOREIGN KEY (cod_funcao) REFERENCES funcao_3fn(cod_funcao),
    FOREIGN KEY (cod_posto)  REFERENCES posto_trabalho_3fn(cod_posto)
);

INSERT INTO pais_3fn VALUES ('Moçambique');

INSERT INTO provincia_3fn (nome_provincia, pais) VALUES
('Maputo Cidade','Moçambique'),
('Maputo Província','Moçambique'),
('Gaza','Moçambique'),
('Inhambane','Moçambique'),
('Sofala','Moçambique'),
('Nampula','Moçambique'),
('Manica','Moçambique'),
('Tete','Moçambique'),
('Zambézia','Moçambique'),
('Cabo Delgado','Moçambique');

INSERT INTO cidade_3fn (nome_cidade, provincia) VALUES
('Maputo','Maputo Cidade'),
('Matola','Maputo Província'),
('Chókwè','Gaza'),
('Maxixe','Inhambane'),
('Beira','Sofala'),
('Nampula','Nampula'),
('Chimoio','Manica'),
('Tete','Tete'),
('Quelimane','Zambézia'),
('Pemba','Cabo Delgado');

INSERT INTO cargo_3fn (cod_cargo, nome_cargo) VALUES
('C01','Técnico de Informática'),
('C02','Contabilista'),
('C08','Assistente Administrativo'),
('C06','Motorista'),
('C04','Enfermeiro'),
('C03','Engenheiro Civil'),
('C05','Professor'),
('C07','Gestor de Recursos Humanos');

INSERT INTO funcao_3fn (cod_funcao, nome_funcao) VALUES
('F01','Tecnologias de Informação'),
('F02','Finanças'),
('F08','Administração'),
('F06','Logística'),
('F04','Saúde'),
('F03','Engenharia'),
('F05','Educação'),
('F07','Recursos Humanos');

INSERT INTO posto_trabalho_3fn (cod_posto, nome_posto, cidade) VALUES
('P01','Sede Maputo','Maputo'),
('P02','Delegação Matola','Matola'),
('P03','Delegação Gaza','Chókwè'),
('P04','Delegação Inhambane','Maxixe'),
('P05','Delegação Beira','Beira'),
('P06','Delegação Nampula','Nampula'),
('P07','Delegação Manica','Chimoio'),
('P08','Delegação Tete','Tete'),
('P09','Delegação Zambézia','Quelimane'),
('P10','Delegação Cabo Delgado','Pemba');

INSERT INTO funcionario_3fn
(nuit, nome, data_nasc, bi, email, rua_avenida, numero, bairro, cidade, cod_cargo, cod_funcao, cod_posto, data_admissao)
VALUES
('100234567','Amélia Fernanda Cossa','1985-03-12','110100123456A','amelia.cossa@empresa.co.mz','Av. Julius Nyerere','245','Sommerschield','Maputo','C01','F01','P01','2015-02-05'),
('100345678','Bernardo Alfredo Machava','1979-07-22','110100234567B','bernardo.machava@empresa.co.mz','Rua da Resistência','8','Polana Caniço','Maputo','C02','F02','P01','2010-09-14'),
('100456789','Celina Armando Sitoe','1990-11-03','110200345678C','celina.sitoe@empresa.co.mz','Av. Samora Machel','12','Fomento','Matola','C08','F08','P02','2018-06-01'),
('100567890','Domingos Paulo Nhantumbo','1982-01-30','110300456789D','domingos.nhantumbo@empresa.co.mz','Rua 3','56','Chókwè-Sede','Chókwè','C06','F06','P03','2012-03-10'),
('100678901','Eugénia Marta Muchanga','1988-05-18','110400567890E','eugenia.muchanga@empresa.co.mz','Av. Eduardo Mondlane','301','Maxixe-Sede','Maxixe','C04','F04','P04','2016-08-20'),
('100789012','Fernando José Macuácua','1975-09-25','110500678901F','fernando.macuacua@empresa.co.mz','Av. Poder Popular','77','Macuti','Beira','C03','F03','P05','2008-01-15'),
('100890123','Graça Isabel Zunguze','1992-12-07','110600789012G','graca.zunguze@empresa.co.mz','Rua da Frescura','19','Ponta Gêa','Beira','C05','F05','P05','2019-02-02'),
('100901234','Hélder António Cuamba','1980-04-14','110700890123H','helder.cuamba@empresa.co.mz','Av. 25 de Setembro','150','Alto Maé','Maputo','C07','F07','P01','2011-11-11'),
('101012345','Ivete Sara Chirindza','1995-06-29','110800901234I','ivete.chirindza@empresa.co.mz','Rua do Bagamoyo','5','Muhipiti','Nampula','C01','F01','P06','2020-07-03'),
('101123456','João Baptista Nhaca','1978-08-09','110900012345J','joao.nhaca@empresa.co.mz','Av. Josina Machel','200','Namahera','Nampula','C02','F02','P06','2009-05-25'),
('101234567','Lúcia Ermelinda Bila','1991-02-16','111000123456K','lucia.bila@empresa.co.mz','Rua da Base','33','Chaimite','Beira','C08','F08','P05','2017-09-19'),
('101345678','Marcelino Inácio Tembe','1983-10-21','111100234567L','marcelino.tembe@empresa.co.mz','Av. Kwame Nkrumah','410','Coop','Maputo','C03','F03','P01','2013-04-08'),
('101456789','Noémia Alzira Massingue','1987-03-04','111200345678M','noemia.massingue@empresa.co.mz','Rua de Chimoio','67','Chingussura','Chimoio','C04','F04','P07','2014-12-12'),
('101567890','Osvaldo Simião Ubisse','1976-07-27','111300456789N','osvaldo.ubisse@empresa.co.mz','Av. 7 de Setembro','90','Matundo','Tete','C06','F06','P08','2006-10-30'),
('101678901','Paulina Fátima Uache','1993-01-15','111400567890O','paulina.uache@empresa.co.mz','Rua da Missão','24','Chalaua','Quelimane','C05','F05','P09','2021-09-09'),
('101789012','Ricardo Manuel Come','1981-06-02','111500678901P','ricardo.come@empresa.co.mz','Av. Franqueza','18','Chuwaula','Pemba','C07','F07','P10','2010-07-17');

-- >>> SELECTs DE VERIFICAÇÃO <<<
SELECT * FROM pais_3fn;
SELECT * FROM provincia_3fn;
SELECT * FROM cidade_3fn;
SELECT * FROM cargo_3fn;
SELECT * FROM funcao_3fn;
SELECT * FROM posto_trabalho_3fn;
SELECT * FROM funcionario_3fn;

-- Prova de que não perdemos informação: reconstitui o texto (cargo, cidade...) via JOIN
SELECT f.nuit, f.nome, c.nome_cargo AS cargo, fu.nome_funcao AS funcao,
       ci.nome_cidade AS cidade, p.nome_provincia AS provincia, pa.nome_pais AS pais
FROM funcionario_3fn f
JOIN cargo_3fn c   ON c.cod_cargo = f.cod_cargo
JOIN funcao_3fn fu ON fu.cod_funcao = f.cod_funcao
JOIN cidade_3fn ci ON ci.nome_cidade = f.cidade
JOIN provincia_3fn p ON p.nome_provincia = ci.provincia
JOIN pais_3fn pa   ON pa.nome_pais = p.pais;

-- Pergunta para motivar a 4FN (explicar no vídeo):
-- filho_1fn/2fn e telefone_1fn/2fn continuam válidas e já separadas -- mas
-- porque é que NÃO as pusemos juntas numa única tabela 'contactos'? Ver fase 4.
