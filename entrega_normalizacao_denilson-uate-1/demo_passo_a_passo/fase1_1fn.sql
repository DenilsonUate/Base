-- ============================================================================
-- FASE 1 — PRIMEIRA FORMA NORMAL (1FN)
-- Ação: eliminar os grupos repetitivos (filhos, celulares) e tornar
-- o endereço atómico (rua/avenida, número e bairro separados).
-- Ainda ficam por resolver: cidade/provincia/pais e cargo/funcao em texto
-- livre repetido — isso só se resolve na 3FN (dependências transitivas).
-- ============================================================================
USE normalizacao_demo;

DROP TABLE IF EXISTS funcionario_1fn;
CREATE TABLE funcionario_1fn (
    nuit            VARCHAR(9) PRIMARY KEY,
    nome            VARCHAR(120) NOT NULL,
    data_nasc       DATE NOT NULL,
    bi              VARCHAR(20) NOT NULL,
    email           VARCHAR(120) NOT NULL,
    rua_avenida     VARCHAR(120) NOT NULL,   -- endereço decomposto
    numero          VARCHAR(10),
    bairro          VARCHAR(80) NOT NULL,
    cidade          VARCHAR(60) NOT NULL,
    provincia       VARCHAR(60) NOT NULL,
    pais            VARCHAR(60) NOT NULL,
    cod_cargo       VARCHAR(10) NOT NULL,
    cargo           VARCHAR(80) NOT NULL,
    cod_funcao      VARCHAR(10) NOT NULL,
    funcao          VARCHAR(80) NOT NULL,
    posto_trabalho  VARCHAR(80) NOT NULL,
    data_admissao   DATE NOT NULL
);

DROP TABLE IF EXISTS filho_1fn;
CREATE TABLE filho_1fn (
    nuit        VARCHAR(9)   NOT NULL,
    num_filho   INT          NOT NULL,      -- 1, 2, 3...
    nome_filho  VARCHAR(120) NOT NULL,
    PRIMARY KEY (nuit, num_filho),           -- chave composta
    FOREIGN KEY (nuit) REFERENCES funcionario_1fn(nuit)
);

DROP TABLE IF EXISTS telefone_1fn;
CREATE TABLE telefone_1fn (
    nuit             VARCHAR(9)  NOT NULL,
    num_telefone     INT         NOT NULL,   -- 1, 2, 3...
    numero_celular   VARCHAR(15) NOT NULL,
    PRIMARY KEY (nuit, num_telefone),         -- chave composta
    FOREIGN KEY (nuit) REFERENCES funcionario_1fn(nuit)
);

INSERT INTO funcionario_1fn
(nuit, nome, data_nasc, bi, email, rua_avenida, numero, bairro, cidade, provincia, pais, cod_cargo, cargo, cod_funcao, funcao, posto_trabalho, data_admissao)
VALUES
('100234567','Amélia Fernanda Cossa','1985-03-12','110100123456A','amelia.cossa@empresa.co.mz','Av. Julius Nyerere','245','Sommerschield','Maputo','Maputo Cidade','Moçambique','C01','Técnico de Informática','F01','Tecnologias de Informação','Sede Maputo','2015-02-05'),
('100345678','Bernardo Alfredo Machava','1979-07-22','110100234567B','bernardo.machava@empresa.co.mz','Rua da Resistência','8','Polana Caniço','Maputo','Maputo Cidade','Moçambique','C02','Contabilista','F02','Finanças','Sede Maputo','2010-09-14'),
('100456789','Celina Armando Sitoe','1990-11-03','110200345678C','celina.sitoe@empresa.co.mz','Av. Samora Machel','12','Fomento','Matola','Maputo Província','Moçambique','C08','Assistente Administrativo','F08','Administração','Delegação Matola','2018-06-01'),
('100567890','Domingos Paulo Nhantumbo','1982-01-30','110300456789D','domingos.nhantumbo@empresa.co.mz','Rua 3','56','Chókwè-Sede','Chókwè','Gaza','Moçambique','C06','Motorista','F06','Logística','Delegação Gaza','2012-03-10'),
('100678901','Eugénia Marta Muchanga','1988-05-18','110400567890E','eugenia.muchanga@empresa.co.mz','Av. Eduardo Mondlane','301','Maxixe-Sede','Maxixe','Inhambane','Moçambique','C04','Enfermeiro','F04','Saúde','Delegação Inhambane','2016-08-20'),
('100789012','Fernando José Macuácua','1975-09-25','110500678901F','fernando.macuacua@empresa.co.mz','Av. Poder Popular','77','Macuti','Beira','Sofala','Moçambique','C03','Engenheiro Civil','F03','Engenharia','Delegação Beira','2008-01-15'),
('100890123','Graça Isabel Zunguze','1992-12-07','110600789012G','graca.zunguze@empresa.co.mz','Rua da Frescura','19','Ponta Gêa','Beira','Sofala','Moçambique','C05','Professor','F05','Educação','Delegação Beira','2019-02-02'),
('100901234','Hélder António Cuamba','1980-04-14','110700890123H','helder.cuamba@empresa.co.mz','Av. 25 de Setembro','150','Alto Maé','Maputo','Maputo Cidade','Moçambique','C07','Gestor de Recursos Humanos','F07','Recursos Humanos','Sede Maputo','2011-11-11'),
('101012345','Ivete Sara Chirindza','1995-06-29','110800901234I','ivete.chirindza@empresa.co.mz','Rua do Bagamoyo','5','Muhipiti','Nampula','Nampula','Moçambique','C01','Técnico de Informática','F01','Tecnologias de Informação','Delegação Nampula','2020-07-03'),
('101123456','João Baptista Nhaca','1978-08-09','110900012345J','joao.nhaca@empresa.co.mz','Av. Josina Machel','200','Namahera','Nampula','Nampula','Moçambique','C02','Contabilista','F02','Finanças','Delegação Nampula','2009-05-25'),
('101234567','Lúcia Ermelinda Bila','1991-02-16','111000123456K','lucia.bila@empresa.co.mz','Rua da Base','33','Chaimite','Beira','Sofala','Moçambique','C08','Assistente Administrativo','F08','Administração','Delegação Beira','2017-09-19'),
('101345678','Marcelino Inácio Tembe','1983-10-21','111100234567L','marcelino.tembe@empresa.co.mz','Av. Kwame Nkrumah','410','Coop','Maputo','Maputo Cidade','Moçambique','C03','Engenheiro Civil','F03','Engenharia','Sede Maputo','2013-04-08'),
('101456789','Noémia Alzira Massingue','1987-03-04','111200345678M','noemia.massingue@empresa.co.mz','Rua de Chimoio','67','Chingussura','Chimoio','Manica','Moçambique','C04','Enfermeiro','F04','Saúde','Delegação Manica','2014-12-12'),
('101567890','Osvaldo Simião Ubisse','1976-07-27','111300456789N','osvaldo.ubisse@empresa.co.mz','Av. 7 de Setembro','90','Matundo','Tete','Tete','Moçambique','C06','Motorista','F06','Logística','Delegação Tete','2006-10-30'),
('101678901','Paulina Fátima Uache','1993-01-15','111400567890O','paulina.uache@empresa.co.mz','Rua da Missão','24','Chalaua','Quelimane','Zambézia','Moçambique','C05','Professor','F05','Educação','Delegação Zambézia','2021-09-09'),
('101789012','Ricardo Manuel Come','1981-06-02','111500678901P','ricardo.come@empresa.co.mz','Av. Franqueza','18','Chuwaula','Pemba','Cabo Delgado','Moçambique','C07','Gestor de Recursos Humanos','F07','Recursos Humanos','Delegação Cabo Delgado','2010-07-17');

INSERT INTO filho_1fn (nuit, num_filho, nome_filho) VALUES
('100234567',1,'Cátia Cossa'),
('100345678',1,'Nelson Machava'),
('100345678',2,'Ivete Machava'),
('100345678',3,'Suzana Machava'),
('100567890',1,'Paulo Nhantumbo Jr'),
('100567890',2,'Alzira Nhantumbo'),
('100678901',1,'Marta Muchanga'),
('100789012',1,'José Macuácua'),
('100789012',2,'Beatriz Macuácua'),
('100789012',3,'Adriano Macuácua'),
('100901234',1,'António Cuamba Jr'),
('100901234',2,'Filomena Cuamba'),
('101123456',1,'Baptista Nhaca Jr'),
('101234567',1,'Ermelinda Bila'),
('101345678',1,'Inácio Tembe Jr'),
('101345678',2,'Rosa Tembe'),
('101567890',1,'Simião Ubisse Jr'),
('101567890',2,'Alcinda Ubisse'),
('101567890',3,'Custódio Ubisse'),
('101789012',1,'Manuel Come Jr');

INSERT INTO telefone_1fn (nuit, num_telefone, numero_celular) VALUES
('100234567',1,'841234567'),
('100234567',2,'821234567'),
('100345678',1,'845678901'),
('100456789',1,'861122334'),
('100567890',1,'847890123'),
('100567890',2,'878901234'),
('100678901',1,'849012345'),
('100789012',1,'823456789'),
('100789012',2,'843456789'),
('100789012',3,'863456789'),
('100890123',1,'844567890'),
('100890123',2,'824567890'),
('100901234',1,'825678901'),
('101012345',1,'846789012'),
('101123456',1,'827890123'),
('101123456',2,'847890124'),
('101234567',1,'848901234'),
('101345678',1,'829012345'),
('101345678',2,'849012346'),
('101345678',3,'869012347'),
('101456789',1,'841122334'),
('101567890',1,'822233445'),
('101567890',2,'842233445'),
('101678901',1,'843344556'),
('101789012',1,'824455667'),
('101789012',2,'844455667');

-- >>> SELECTs DE VERIFICAÇÃO <<<
SELECT * FROM funcionario_1fn;
SELECT * FROM filho_1fn;
SELECT * FROM telefone_1fn;

-- Prova de que não perdemos informação: reconstitui o equivalente à 0FN
SELECT f.nuit, f.nome,
       GROUP_CONCAT(DISTINCT fi.nome_filho ORDER BY fi.num_filho SEPARATOR ' | ') AS filhos,
       GROUP_CONCAT(DISTINCT t.numero_celular ORDER BY t.num_telefone SEPARATOR ' | ') AS telefones
FROM funcionario_1fn f
LEFT JOIN filho_1fn fi ON fi.nuit = f.nuit
LEFT JOIN telefone_1fn t ON t.nuit = f.nuit
GROUP BY f.nuit, f.nome;

-- Pergunta para motivar a 2FN (explicar no vídeo):
-- Em filho_1fn e telefone_1fn a chave é composta (nuit + número de ordem).
-- 'nome_filho' e 'numero_celular' dependem só de parte da chave, ou da chave toda?
