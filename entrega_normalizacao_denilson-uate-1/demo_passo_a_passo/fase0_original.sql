-- ============================================================================
-- FASE 0 — TABELA ORIGINAL, TAL COMO ESTAVA NA FOLHA DE CÁLCULO (0FN)
-- Objetivo: recriar exatamente o problema — dados não atómicos (endereço),
-- grupos repetitivos (Filho 1-3, Celular 1-3) e nomes de cargo/função/
-- localidade repetidos em texto livre em cada linha.
-- ============================================================================
CREATE DATABASE IF NOT EXISTS normalizacao_demo CHARACTER SET utf8mb4;
USE normalizacao_demo;

DROP TABLE IF EXISTS funcionario_0fn;
CREATE TABLE funcionario_0fn (
    linha           INT AUTO_INCREMENT PRIMARY KEY,  -- não é chave de negócio, só numera a linha da folha
    nome            VARCHAR(120),
    data_nasc       DATE,
    nuit            VARCHAR(9),
    bi              VARCHAR(20),
    email           VARCHAR(120),
    endereco        VARCHAR(160),   -- NÃO ATÓMICO: rua + número + bairro juntos
    cidade          VARCHAR(60),
    provincia       VARCHAR(60),
    pais            VARCHAR(60),
    cargo           VARCHAR(80),
    cod_cargo       VARCHAR(10),
    funcao          VARCHAR(80),
    cod_funcao      VARCHAR(10),
    posto_trabalho  VARCHAR(80),
    data_admissao   DATE,
    filho1          VARCHAR(120),   -- GRUPO REPETITIVO
    filho2          VARCHAR(120),
    filho3          VARCHAR(120),
    celular1        VARCHAR(15),    -- GRUPO REPETITIVO
    celular2        VARCHAR(15),
    celular3        VARCHAR(15)
);

INSERT INTO funcionario_0fn
(nome, data_nasc, nuit, bi, email, endereco, cidade, provincia, pais, cargo, cod_cargo, funcao, cod_funcao, posto_trabalho, data_admissao, filho1, filho2, filho3, celular1, celular2, celular3)
VALUES
('Amélia Fernanda Cossa','1985-03-12','100234567','110100123456A','amelia.cossa@empresa.co.mz','Av. Julius Nyerere, n.º 245, Sommerschield','Maputo','Maputo Cidade','Moçambique','Técnico de Informática','C01','Tecnologias de Informação','F01','Sede Maputo','2015-02-05','Cátia Cossa',NULL,NULL,'841234567','821234567',NULL),
('Bernardo Alfredo Machava','1979-07-22','100345678','110100234567B','bernardo.machava@empresa.co.mz','Rua da Resistência, n.º 8, Polana Caniço','Maputo','Maputo Cidade','Moçambique','Contabilista','C02','Finanças','F02','Sede Maputo','2010-09-14','Nelson Machava','Ivete Machava','Suzana Machava','845678901',NULL,NULL),
('Celina Armando Sitoe','1990-11-03','100456789','110200345678C','celina.sitoe@empresa.co.mz','Av. Samora Machel, n.º 12, Fomento','Matola','Maputo Província','Moçambique','Assistente Administrativo','C08','Administração','F08','Delegação Matola','2018-06-01',NULL,NULL,NULL,'861122334',NULL,NULL),
('Domingos Paulo Nhantumbo','1982-01-30','100567890','110300456789D','domingos.nhantumbo@empresa.co.mz','Rua 3, n.º 56, Chókwè-Sede','Chókwè','Gaza','Moçambique','Motorista','C06','Logística','F06','Delegação Gaza','2012-03-10','Paulo Nhantumbo Jr','Alzira Nhantumbo',NULL,'847890123','878901234',NULL),
('Eugénia Marta Muchanga','1988-05-18','100678901','110400567890E','eugenia.muchanga@empresa.co.mz','Av. Eduardo Mondlane, n.º 301, Maxixe-Sede','Maxixe','Inhambane','Moçambique','Enfermeiro','C04','Saúde','F04','Delegação Inhambane','2016-08-20','Marta Muchanga',NULL,NULL,'849012345',NULL,NULL),
('Fernando José Macuácua','1975-09-25','100789012','110500678901F','fernando.macuacua@empresa.co.mz','Av. Poder Popular, n.º 77, Macuti','Beira','Sofala','Moçambique','Engenheiro Civil','C03','Engenharia','F03','Delegação Beira','2008-01-15','José Macuácua','Beatriz Macuácua','Adriano Macuácua','823456789','843456789','863456789'),
('Graça Isabel Zunguze','1992-12-07','100890123','110600789012G','graca.zunguze@empresa.co.mz','Rua da Frescura, n.º 19, Ponta Gêa','Beira','Sofala','Moçambique','Professor','C05','Educação','F05','Delegação Beira','2019-02-02',NULL,NULL,NULL,'844567890','824567890',NULL),
('Hélder António Cuamba','1980-04-14','100901234','110700890123H','helder.cuamba@empresa.co.mz','Av. 25 de Setembro, n.º 150, Alto Maé','Maputo','Maputo Cidade','Moçambique','Gestor de Recursos Humanos','C07','Recursos Humanos','F07','Sede Maputo','2011-11-11','António Cuamba Jr','Filomena Cuamba',NULL,'825678901',NULL,NULL),
('Ivete Sara Chirindza','1995-06-29','101012345','110800901234I','ivete.chirindza@empresa.co.mz','Rua do Bagamoyo, n.º 5, Muhipiti','Nampula','Nampula','Moçambique','Técnico de Informática','C01','Tecnologias de Informação','F01','Delegação Nampula','2020-07-03',NULL,NULL,NULL,'846789012',NULL,NULL),
('João Baptista Nhaca','1978-08-09','101123456','110900012345J','joao.nhaca@empresa.co.mz','Av. Josina Machel, n.º 200, Namahera','Nampula','Nampula','Moçambique','Contabilista','C02','Finanças','F02','Delegação Nampula','2009-05-25','Baptista Nhaca Jr',NULL,NULL,'827890123','847890124',NULL),
('Lúcia Ermelinda Bila','1991-02-16','101234567','111000123456K','lucia.bila@empresa.co.mz','Rua da Base, n.º 33, Chaimite','Beira','Sofala','Moçambique','Assistente Administrativo','C08','Administração','F08','Delegação Beira','2017-09-19','Ermelinda Bila',NULL,NULL,'848901234',NULL,NULL),
('Marcelino Inácio Tembe','1983-10-21','101345678','111100234567L','marcelino.tembe@empresa.co.mz','Av. Kwame Nkrumah, n.º 410, Coop','Maputo','Maputo Cidade','Moçambique','Engenheiro Civil','C03','Engenharia','F03','Sede Maputo','2013-04-08','Inácio Tembe Jr','Rosa Tembe',NULL,'829012345','849012346','869012347'),
('Noémia Alzira Massingue','1987-03-04','101456789','111200345678M','noemia.massingue@empresa.co.mz','Rua de Chimoio, n.º 67, Chingussura','Chimoio','Manica','Moçambique','Enfermeiro','C04','Saúde','F04','Delegação Manica','2014-12-12',NULL,NULL,NULL,'841122334',NULL,NULL),
('Osvaldo Simião Ubisse','1976-07-27','101567890','111300456789N','osvaldo.ubisse@empresa.co.mz','Av. 7 de Setembro, n.º 90, Matundo','Tete','Tete','Moçambique','Motorista','C06','Logística','F06','Delegação Tete','2006-10-30','Simião Ubisse Jr','Alcinda Ubisse','Custódio Ubisse','822233445','842233445',NULL),
('Paulina Fátima Uache','1993-01-15','101678901','111400567890O','paulina.uache@empresa.co.mz','Rua da Missão, n.º 24, Chalaua','Quelimane','Zambézia','Moçambique','Professor','C05','Educação','F05','Delegação Zambézia','2021-09-09',NULL,NULL,NULL,'843344556',NULL,NULL),
('Ricardo Manuel Come','1981-06-02','101789012','111500678901P','ricardo.come@empresa.co.mz','Av. Franqueza, n.º 18, Chuwaula','Pemba','Cabo Delgado','Moçambique','Gestor de Recursos Humanos','C07','Recursos Humanos','F07','Delegação Cabo Delgado','2010-07-17','Manuel Come Jr',NULL,NULL,'824455667','844455667',NULL);

-- >>> SELECT DE VERIFICAÇÃO — a tabela tal como estava na folha de cálculo <<<
SELECT * FROM funcionario_0fn;

-- Perguntas para motivar a 1FN (explicar no vídeo):
-- 1) Como listar TODOS os filhos de um funcionário sem saber à partida quantos tem?
-- 2) O que acontece se um funcionário tiver um 4º filho? É preciso alterar a tabela.
-- 3) 'endereco' mistura rua, número e bairro — não dá para pesquisar só por bairro.
