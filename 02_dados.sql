-- ============================================================================
-- Dados de demonstração — reconstituídos a partir de
-- Dados_Nao_Normalizados_Funcionarios.xlsx (16 funcionários)
-- ============================================================================
USE gestao_funcionarios;

-- ----------------------------------------------------------------------------
-- Geografia
-- ----------------------------------------------------------------------------
INSERT INTO pais (nome_pais) VALUES ('Moçambique');

INSERT INTO provincia (nome_provincia, pais) VALUES
('Maputo Cidade',   'Moçambique'),
('Maputo Província','Moçambique'),
('Gaza',            'Moçambique'),
('Inhambane',       'Moçambique'),
('Sofala',          'Moçambique'),
('Nampula',         'Moçambique'),
('Manica',          'Moçambique'),
('Tete',            'Moçambique'),
('Zambézia',        'Moçambique'),
('Cabo Delgado',    'Moçambique');

INSERT INTO cidade (nome_cidade, provincia) VALUES
('Maputo',    'Maputo Cidade'),
('Matola',    'Maputo Província'),
('Chókwè',    'Gaza'),
('Maxixe',    'Inhambane'),
('Beira',     'Sofala'),
('Nampula',   'Nampula'),
('Chimoio',   'Manica'),
('Tete',      'Tete'),
('Quelimane', 'Zambézia'),
('Pemba',     'Cabo Delgado');

-- ----------------------------------------------------------------------------
-- Cargos e funções (tabela de referência do ficheiro original)
-- ----------------------------------------------------------------------------
INSERT INTO cargo (cod_cargo, nome_cargo) VALUES
('C01', 'Técnico de Informática'),
('C02', 'Contabilista'),
('C03', 'Engenheiro Civil'),
('C04', 'Enfermeiro'),
('C05', 'Professor'),
('C06', 'Motorista'),
('C07', 'Gestor de Recursos Humanos'),
('C08', 'Assistente Administrativo');

INSERT INTO funcao (cod_funcao, nome_funcao) VALUES
('F01', 'Tecnologias de Informação'),
('F02', 'Finanças'),
('F03', 'Engenharia'),
('F04', 'Saúde'),
('F05', 'Educação'),
('F06', 'Logística'),
('F07', 'Recursos Humanos'),
('F08', 'Administração');

-- ----------------------------------------------------------------------------
-- Postos de trabalho
-- ----------------------------------------------------------------------------
INSERT INTO posto_trabalho (cod_posto, nome_posto, cidade) VALUES
('P01', 'Sede Maputo',            'Maputo'),
('P02', 'Delegação Matola',       'Matola'),
('P03', 'Delegação Gaza',         'Chókwè'),
('P04', 'Delegação Inhambane',    'Maxixe'),
('P05', 'Delegação Beira',        'Beira'),
('P06', 'Delegação Nampula',      'Nampula'),
('P07', 'Delegação Manica',       'Chimoio'),
('P08', 'Delegação Tete',         'Tete'),
('P09', 'Delegação Zambézia',     'Quelimane'),
('P10', 'Delegação Cabo Delgado', 'Pemba');

-- ----------------------------------------------------------------------------
-- Funcionários
-- ----------------------------------------------------------------------------
INSERT INTO funcionario
(nuit, nome, data_nasc, bi, email, rua_avenida, numero, bairro, data_admissao, cidade, cod_cargo, cod_funcao, cod_posto)
VALUES
('100234567','Amélia Fernanda Cossa',    '1985-03-12','110100123456A','amelia.cossa@empresa.co.mz',   'Av. Julius Nyerere',    '245','Sommerschield',  '2015-02-05','Maputo',   'C01','F01','P01'),
('100345678','Bernardo Alfredo Machava', '1979-07-22','110100234567B','bernardo.machava@empresa.co.mz','Rua da Resistência',    '8',  'Polana Caniço',  '2010-09-14','Maputo',   'C02','F02','P01'),
('100456789','Celina Armando Sitoe',     '1990-11-03','110200345678C','celina.sitoe@empresa.co.mz',    'Av. Samora Machel',     '12', 'Fomento',        '2018-06-01','Matola',   'C08','F08','P02'),
('100567890','Domingos Paulo Nhantumbo', '1982-01-30','110300456789D','domingos.nhantumbo@empresa.co.mz','Rua 3',               '56', 'Chókwè-Sede',    '2012-03-10','Chókwè',   'C06','F06','P03'),
('100678901','Eugénia Marta Muchanga',   '1988-05-18','110400567890E','eugenia.muchanga@empresa.co.mz','Av. Eduardo Mondlane',  '301','Maxixe-Sede',    '2016-08-20','Maxixe',   'C04','F04','P04'),
('100789012','Fernando José Macuácua',   '1975-09-25','110500678901F','fernando.macuacua@empresa.co.mz','Av. Poder Popular',    '77', 'Macuti',         '2008-01-15','Beira',    'C03','F03','P05'),
('100890123','Graça Isabel Zunguze',     '1992-12-07','110600789012G','graca.zunguze@empresa.co.mz',   'Rua da Frescura',       '19', 'Ponta Gêa',      '2019-02-02','Beira',    'C05','F05','P05'),
('100901234','Hélder António Cuamba',    '1980-04-14','110700890123H','helder.cuamba@empresa.co.mz',   'Av. 25 de Setembro',    '150','Alto Maé',       '2011-11-11','Maputo',   'C07','F07','P01'),
('101012345','Ivete Sara Chirindza',     '1995-06-29','110800901234I','ivete.chirindza@empresa.co.mz', 'Rua do Bagamoyo',       '5',  'Muhipiti',       '2020-07-03','Nampula',  'C01','F01','P06'),
('101123456','João Baptista Nhaca',      '1978-08-09','110900012345J','joao.nhaca@empresa.co.mz',      'Av. Josina Machel',     '200','Namahera',       '2009-05-25','Nampula',  'C02','F02','P06'),
('101234567','Lúcia Ermelinda Bila',     '1991-02-16','111000123456K','lucia.bila@empresa.co.mz',      'Rua da Base',           '33', 'Chaimite',       '2017-09-19','Beira',    'C08','F08','P05'),
('101345678','Marcelino Inácio Tembe',   '1983-10-21','111100234567L','marcelino.tembe@empresa.co.mz', 'Av. Kwame Nkrumah',     '410','Coop',           '2013-04-08','Maputo',   'C03','F03','P01'),
('101456789','Noémia Alzira Massingue',  '1987-03-04','111200345678M','noemia.massingue@empresa.co.mz','Rua de Chimoio',        '67', 'Chingussura',    '2014-12-12','Chimoio',  'C04','F04','P07'),
('101567890','Osvaldo Simião Ubisse',    '1976-07-27','111300456789N','osvaldo.ubisse@empresa.co.mz',  'Av. 7 de Setembro',     '90', 'Matundo',        '2006-10-30','Tete',     'C06','F06','P08'),
('101678901','Paulina Fátima Uache',     '1993-01-15','111400567890O','paulina.uache@empresa.co.mz',   'Rua da Missão',         '24', 'Chalaua',        '2021-09-09','Quelimane','C05','F05','P09'),
('101789012','Ricardo Manuel Come',      '1981-06-02','111500678901P','ricardo.come@empresa.co.mz',    'Av. Franqueza',         '18', 'Chuwaula',       '2010-07-17','Pemba',    'C07','F07','P10');

-- ----------------------------------------------------------------------------
-- Filhos (grupo repetitivo extraído na 1FN)
-- ----------------------------------------------------------------------------
INSERT INTO filho (nuit_funcionario, nome_filho) VALUES
('100234567','Cátia Cossa'),
('100345678','Nelson Machava'),
('100345678','Ivete Machava'),
('100345678','Suzana Machava'),
('100567890','Paulo Nhantumbo Jr'),
('100567890','Alzira Nhantumbo'),
('100678901','Marta Muchanga'),
('100789012','José Macuácua'),
('100789012','Beatriz Macuácua'),
('100789012','Adriano Macuácua'),
('100901234','António Cuamba Jr'),
('100901234','Filomena Cuamba'),
('101123456','Baptista Nhaca Jr'),
('101234567','Ermelinda Bila'),
('101345678','Inácio Tembe Jr'),
('101345678','Rosa Tembe'),
('101567890','Simião Ubisse Jr'),
('101567890','Alcinda Ubisse'),
('101567890','Custódio Ubisse'),
('101789012','Manuel Come Jr');

-- ----------------------------------------------------------------------------
-- Telefones (grupo repetitivo extraído na 1FN)
-- ----------------------------------------------------------------------------
INSERT INTO telefone (nuit_funcionario, numero_celular) VALUES
('100234567','841234567'),
('100234567','821234567'),
('100345678','845678901'),
('100456789','861122334'),
('100567890','847890123'),
('100567890','878901234'),
('100678901','849012345'),
('100789012','823456789'),
('100789012','843456789'),
('100789012','863456789'),
('100890123','844567890'),
('100890123','824567890'),
('100901234','825678901'),
('101012345','846789012'),
('101123456','827890123'),
('101123456','847890124'),
('101234567','848901234'),
('101345678','829012345'),
('101345678','849012346'),
('101345678','869012347'),
('101456789','841122334'),
('101567890','822233445'),
('101567890','842233445'),
('101678901','843344556'),
('101789012','824455667'),
('101789012','844455667');
