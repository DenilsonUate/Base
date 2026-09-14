-- ============================================================================
-- FASE 4 — QUARTA FORMA NORMAL (4FN)
-- Ação: eliminar dependências MULTIVALORADAS independentes.
--
-- DEMONSTRAÇÃO DO PROBLEMA: se juntássemos filhos e telefones numa única
-- tabela 'contactos' por funcionário, cada combinação filho x telefone teria
-- de ser repetida -- um produto cartesiano artificial, sem significado real.
-- ============================================================================
USE normalizacao_demo;

-- ---- exemplo do que NÃO fazer (só para demonstração no vídeo) ----
DROP TABLE IF EXISTS contactos_errado_demo;
CREATE TABLE contactos_errado_demo AS
SELECT fi.nuit, fi.num_filho, fi.nome_filho, t.num_telefone, t.numero_celular
FROM filho_1fn fi
JOIN telefone_1fn t ON t.nuit = fi.nuit;

-- Repara: Fernando José Macuácua tem 3 filhos e 3 telefones reais (6 factos),
-- mas nesta tabela errada aparecem 3 x 3 = 9 linhas para ele -- redundância pura.
SELECT * FROM contactos_errado_demo WHERE nuit = '100789012';
SELECT nuit, COUNT(*) AS linhas_no_produto_cartesiano
FROM contactos_errado_demo GROUP BY nuit ORDER BY linhas_no_produto_cartesiano DESC;
DROP TABLE contactos_errado_demo;  -- não faz parte do esquema final, foi só demonstração

-- ---- solução correta: manter FILHO e TELEFONE como entidades independentes ----
DROP TABLE IF EXISTS filho;
CREATE TABLE filho (
    id_filho         INT AUTO_INCREMENT PRIMARY KEY,
    nuit_funcionario VARCHAR(9) NOT NULL,
    nome_filho       VARCHAR(120) NOT NULL,
    FOREIGN KEY (nuit_funcionario) REFERENCES funcionario_3fn(nuit)
);

DROP TABLE IF EXISTS telefone;
CREATE TABLE telefone (
    id_telefone      INT AUTO_INCREMENT PRIMARY KEY,
    nuit_funcionario VARCHAR(9) NOT NULL,
    numero_celular   VARCHAR(15) NOT NULL,
    FOREIGN KEY (nuit_funcionario) REFERENCES funcionario_3fn(nuit)
);

INSERT INTO filho (nuit_funcionario, nome_filho)
SELECT nuit, nome_filho FROM filho_1fn ORDER BY nuit, num_filho;

INSERT INTO telefone (nuit_funcionario, numero_celular)
SELECT nuit, numero_celular FROM telefone_1fn ORDER BY nuit, num_telefone;

-- Renomear a tabela principal para o nome definitivo do esquema
DROP TABLE IF EXISTS funcionario;
RENAME TABLE funcionario_3fn TO funcionario;

-- >>> SELECTs DE VERIFICAÇÃO — esquema final, 4FN <<<
SELECT * FROM filho;
SELECT * FROM telefone;

-- ============================================================================
-- SELECT FINAL — reconstitui TODA a informação original (equivalente à 0FN)
-- a partir do esquema totalmente normalizado, via JOIN
-- ============================================================================
SELECT
    f.nuit, f.nome, f.data_nasc, f.bi, f.email,
    CONCAT(f.rua_avenida, ', n.º ', f.numero, ', ', f.bairro) AS endereco,
    ci.nome_cidade AS cidade, p.nome_provincia AS provincia, pa.nome_pais AS pais,
    c.nome_cargo AS cargo, fu.nome_funcao AS funcao, pt.nome_posto AS posto_trabalho,
    f.data_admissao,
    GROUP_CONCAT(DISTINCT fi.nome_filho ORDER BY fi.id_filho SEPARATOR ' | ')   AS filhos,
    GROUP_CONCAT(DISTINCT t.numero_celular ORDER BY t.id_telefone SEPARATOR ' | ') AS telefones
FROM funcionario f
JOIN cidade_3fn ci      ON ci.nome_cidade = f.cidade
JOIN provincia_3fn p    ON p.nome_provincia = ci.provincia
JOIN pais_3fn pa        ON pa.nome_pais = p.pais
JOIN cargo_3fn c        ON c.cod_cargo = f.cod_cargo
JOIN funcao_3fn fu      ON fu.cod_funcao = f.cod_funcao
JOIN posto_trabalho_3fn pt ON pt.cod_posto = f.cod_posto
LEFT JOIN filho fi      ON fi.nuit_funcionario = f.nuit
LEFT JOIN telefone t    ON t.nuit_funcionario = f.nuit
GROUP BY f.nuit, f.nome, f.data_nasc, f.bi, f.email, f.rua_avenida, f.numero, f.bairro,
         ci.nome_cidade, p.nome_provincia, pa.nome_pais, c.nome_cargo, fu.nome_funcao,
         pt.nome_posto, f.data_admissao
ORDER BY f.nome;
