-- ============================================================================
-- FASE 2 — SEGUNDA FORMA NORMAL (2FN)
-- Ação: eliminar dependências PARCIAIS (atributo não-chave que depende só
-- de PARTE de uma chave composta).
--
-- Verificação:
--  - funcionario_1fn tem chave SIMPLES (nuit) -> não pode haver dependência
--    parcial aqui (só existe em chaves compostas). 2FN garantida por definição.
--  - filho_1fn / telefone_1fn têm chave COMPOSTA (nuit + num_filho / num_telefone).
--    'nome_filho' só faz sentido para o PAR completo (nuit, num_filho); não existe
--    nenhum atributo que dependa apenas de 'nuit' isoladamente dentro destas duas
--    tabelas (isso já foi todo extraído para funcionario_1fn na fase anterior).
--
-- Conclusão: NÃO há dependências parciais a eliminar. Copiamos as tabelas com o
-- sufixo _2fn apenas para manter a numeração das fases coerente na demonstração —
-- a estrutura interna é idêntica à da 1FN.
-- ============================================================================
USE normalizacao_demo;

DROP TABLE IF EXISTS funcionario_2fn;
CREATE TABLE funcionario_2fn AS SELECT * FROM funcionario_1fn;
ALTER TABLE funcionario_2fn ADD PRIMARY KEY (nuit);

DROP TABLE IF EXISTS filho_2fn;
CREATE TABLE filho_2fn AS SELECT * FROM filho_1fn;
ALTER TABLE filho_2fn ADD PRIMARY KEY (nuit, num_filho);

DROP TABLE IF EXISTS telefone_2fn;
CREATE TABLE telefone_2fn AS SELECT * FROM telefone_1fn;
ALTER TABLE telefone_2fn ADD PRIMARY KEY (nuit, num_telefone);

-- >>> SELECTs DE VERIFICAÇÃO — estrutura igual à 1FN, sem dependências parciais <<<
SELECT * FROM funcionario_2fn;
SELECT * FROM filho_2fn;
SELECT * FROM telefone_2fn;

-- Pergunta para motivar a 3FN (explicar no vídeo):
-- Em funcionario_2fn, 'cargo' depende de 'cod_cargo', que por sua vez depende
-- de 'nuit' -- não é uma dependência DIRETA do nuit. O mesmo acontece com
-- funcao, e com cidade->provincia->pais. Isto é uma dependência TRANSITIVA.
-- Prova disto: reparar que o mesmo cod_cargo aparece sempre com o mesmo nome:
SELECT DISTINCT cod_cargo, cargo FROM funcionario_2fn ORDER BY cod_cargo;
SELECT DISTINCT cidade, provincia, pais FROM funcionario_2fn ORDER BY cidade;
