# Normalização de Base de Dados — Sistema de Gestão de Funcionários

**Trabalho II** — Curso de Licenciatura em Informática, Universidade Licungo
Estudante: Denilson Uate · Docente: Daniel Gimo

## Sobre o projeto

Uma empresa moçambicana mantinha os dados dos seus 16 funcionários numa única
folha de cálculo (`Dados_Nao_Normalizados_Funcionarios.xlsx`), com dados não
atómicos (endereço, localização) e grupos repetitivos em colunas (até 3 filhos,
até 3 telefones por funcionário). Este projeto aplica o processo de
normalização de bases de dados, passo a passo, da 1.ª à 4.ª Forma Normal,
resultando num esquema relacional de 9 tabelas sem redundância nem anomalias.

## Estrutura do repositório

```
.
├── documentos/
│   └── Analise_Normalizacao.docx   # Análise e justificação de cada forma normal (1FN → 4FN)
├── diagramas/
│   └── MER.png                     # Modelo Entidade-Relacionamento com cardinalidades
├── sql/
│   ├── 01_schema.sql                # DDL — criação das 9 tabelas (PK/FK)
│   ├── 02_dados.sql                 # Dados de demonstração (os 16 funcionários originais)
│   └── 03_queries.sql               # 4 queries de exemplo com JOIN
└── README.md
```

## Como consultar

1. **Análise das formas normais** — abrir `documentos/Analise_Normalizacao.docx`.
   Contém, para cada fase (1FN a 4FN): a ação aplicada, a justificação e as
   tabelas resultantes com atributos, chaves primárias e estrangeiras. Inclui
   também a tabela de cardinalidades (secção 7).
2. **Modelo ER** — abrir `diagramas/MER.png` para o diagrama completo do
   esquema final (10 entidades, chaves e relacionamentos 1:N).
3. **Base de dados** — em MySQL (ou compatível), correr por ordem:
   ```bash
   mysql -u root -p < sql/01_schema.sql
   mysql -u root -p < sql/02_dados.sql
   mysql -u root -p < sql/03_queries.sql
   ```
   `01_schema.sql` cria a base `gestao_funcionarios` e as 9 tabelas;
   `02_dados.sql` insere os 16 funcionários reconstituídos do ficheiro Excel
   original (incluindo filhos e telefones); `03_queries.sql` demonstra, com
   `JOIN`, a reconstituição integral da informação original a partir do
   esquema normalizado.

## Esquema final (resumo)

| Tabela | Chave | Elimina |
|---|---|---|
| `pais` | nome_pais | — |
| `provincia` | nome_provincia | dependência transitiva província→país |
| `cidade` | nome_cidade | dependência transitiva cidade→província→país |
| `cargo` | cod_cargo | dependência transitiva NUIT→cód.→nome do cargo |
| `funcao` | cod_funcao | dependência transitiva NUIT→cód.→nome da função |
| `posto_trabalho` | cod_posto | dependência transitiva posto→cidade |
| `funcionario` | nuit | tabela principal, apenas atributos que dependem diretamente do NUIT |
| `filho` | id_filho | grupo repetitivo "Filho 1-3"; MVD independente de telefone |
| `telefone` | id_telefone | grupo repetitivo "Celular 1-3"; MVD independente de filho |

## Vídeo explicativo

Link do vídeo (YouTube, não listado): _[a adicionar após gravação]_
