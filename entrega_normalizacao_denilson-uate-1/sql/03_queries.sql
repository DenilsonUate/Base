-- ============================================================================
-- QUERIES DE EXEMPLO — demonstram a reconstituição da informação original
-- a partir do esquema normalizado (4FN)
-- ============================================================================
USE gestao_funcionarios;

-- ----------------------------------------------------------------------------
-- QUERY 1
-- Reconstitui a ficha completa de cada funcionário: dados pessoais, morada
-- completa (rua + bairro + cidade + província + país), cargo, função e
-- posto de trabalho — tudo o que estava numa única linha na tabela original.
-- ----------------------------------------------------------------------------
SELECT
    f.nuit,
    f.nome,
    f.data_nasc,
    f.bi,
    f.email,
    CONCAT(f.rua_avenida, ', n.º ', f.numero, ', ', f.bairro)  AS endereco,
    f.cidade,
    p.nome_provincia                                            AS provincia,
    pa.nome_pais                                                AS pais,
    c.nome_cargo                                                AS cargo,
    fu.nome_funcao                                               AS funcao,
    pt.nome_posto                                                AS posto_trabalho,
    f.data_admissao
FROM funcionario f
    JOIN cidade      ci ON ci.nome_cidade   = f.cidade
    JOIN provincia   p  ON p.nome_provincia = ci.provincia
    JOIN pais        pa ON pa.nome_pais     = p.pais
    JOIN cargo       c  ON c.cod_cargo      = f.cod_cargo
    JOIN funcao      fu ON fu.cod_funcao    = f.cod_funcao
    JOIN posto_trabalho pt ON pt.cod_posto  = f.cod_posto
ORDER BY f.nome;

-- ----------------------------------------------------------------------------
-- QUERY 2
-- Reconstitui, por funcionário, a lista de filhos e a lista de contactos
-- telefónicos agregada numa única linha (equivalente às colunas repetidas
-- "Filho 1..3" e "Celular 1..3" da tabela original), sem perder informação
-- quando um funcionário tem 0, 1, 2 ou 3 ocorrências.
-- ----------------------------------------------------------------------------
SELECT
    f.nuit,
    f.nome,
    GROUP_CONCAT(DISTINCT fi.nome_filho     ORDER BY fi.id_filho     SEPARATOR '; ') AS filhos,
    GROUP_CONCAT(DISTINCT t.numero_celular  ORDER BY t.id_telefone   SEPARATOR '; ') AS telefones
FROM funcionario f
    LEFT JOIN filho    fi ON fi.nuit_funcionario = f.nuit
    LEFT JOIN telefone t  ON t.nuit_funcionario  = f.nuit
GROUP BY f.nuit, f.nome
ORDER BY f.nome;

-- ----------------------------------------------------------------------------
-- QUERY 3
-- Contagem de funcionários por cargo e por província — uma consulta
-- analítica que só é trivial porque o esquema já não tem os nomes de
-- cargo/função/localidade repetidos como texto solto em cada linha.
-- ----------------------------------------------------------------------------
SELECT
    p.nome_provincia AS provincia,
    c.nome_cargo      AS cargo,
    COUNT(*)          AS total_funcionarios
FROM funcionario f
    JOIN cidade    ci ON ci.nome_cidade   = f.cidade
    JOIN provincia p  ON p.nome_provincia = ci.provincia
    JOIN cargo     c  ON c.cod_cargo      = f.cod_cargo
GROUP BY p.nome_provincia, c.nome_cargo
ORDER BY provincia, cargo;

-- ----------------------------------------------------------------------------
-- QUERY 4 (bónus)
-- Funcionários com mais de um número de telefone registado — uma pergunta
-- que era difícil de responder de forma genérica na tabela em 0FN (exigiria
-- verificar manualmente as colunas Celular 2 e Celular 3), mas que agora é
-- uma simples contagem por chave estrangeira.
-- ----------------------------------------------------------------------------
SELECT
    f.nuit,
    f.nome,
    COUNT(t.id_telefone) AS numero_de_telefones
FROM funcionario f
    JOIN telefone t ON t.nuit_funcionario = f.nuit
GROUP BY f.nuit, f.nome
HAVING COUNT(t.id_telefone) > 1
ORDER BY numero_de_telefones DESC, f.nome;
