# Modern Data Pipeline: Multi-Source ELT para BigQuery

Este projeto demonstra a construção de um pipeline de dados escalável ponta a ponta utilizando a **Modern Data Stack**. O sistema foi desenhado para ingerir dados de múltiplas fontes heterogêneas simultaneamente, consolidando-os na nuvem e garantindo a qualidade através de contratos de dados automáticos.

## Arquitetura do Projeto (ELT Multi-Source)

O pipeline foi desenhado separando claramente a extração/carga (Python) da transformação lógica (dbt). Isso permite plugar novos "braços" de extração sem alterar o núcleo do sistema.

1. **Camada Bronze (Ingestão Polivalente):** Extração e carga bruta (`Load`) no Google BigQuery utilizando Python e `pandas-gbq` a partir de 3 naturezas de dados distintas:
   * **Fonte 1 (API REST):** Consumo de dados dinâmicos (ex: API de Municípios do IBGE).
   * **Fonte 2 (Arquivos Estáticos):** Ingestão de dados estruturados locais (ex: planilhas CSV/Excel).
   * **Fonte 3 (Banco/Cloud):** Conexão com uma segunda API externa ou base de dados pública.
2. **Camadas Prata e Ouro (Transformação e Unificação):** Modelagem e padronização utilizando **dbt Core**. Os dados brutos das 3 fontes são limpos, filtrados e unificados (através de *JOINs*) em tabelas consolidadas prontas para consumo.
3. **Qualidade e Testes:** Implementação de testes automatizados no dbt (`schema.yml`) para garantir integridade (IDs únicos, sem valores nulos e regras de negócio validadas) antes da entrega final.
4. **Governança e CI/CD:** Orquestração com **GitHub Actions**. A cada novo push, o pipeline valida o código e executa as transformações de forma segura usando GitHub Secrets.

## Stack Tecnológica

* **Linguagem:** Python 3.12
* **Data Warehouse:** Google BigQuery
* **Transformação & Data Quality:** dbt (Data Build Tool)
* **Orquestração:** GitHub Actions
* **Controle de Versão:** Git & GitHub

##  Como Reproduzir o Projeto

### Pré-requisitos
* Python instalado.
* Conta no Google Cloud Platform (GCP) com um projeto e um dataset no BigQuery criados.
* Uma Conta de Serviço (Service Account) com permissões de edição no BigQuery (chave `.json`).

### Passos
1. Clone o repositório:
   ```bash
   git clone SUA_URL_DO_GITHUB_AQUI
   cd pipeline_dados_escalavel

2. Crie e ative um ambiente virtual:

       python -m venv venv
       # No Windows:
       venv\Scripts\activate

3. Instale as dependências essenciais:


        pip install pandas db-dtypes pandas-gbq dbt-bigquery


4. Configure suas credenciais do GCP criando o arquivo credenciais_bq.json na raiz do projeto (este arquivo está no .gitignore por segurança).


5. Execute as extrações:

         python extrator_api_ibge.py
         python extrator_csv_local.py
         python extrator_api_secundaria.py


6. Entre na pasta do dbt, teste a qualidade e consolide os dados:

        cd meu_dbt
        dbt test
        dbt run

7. Visualização e Entrega


Os dados finais, unificados e validados pelo dbt, são disponibilizados através de Views no BigQuery, otimizados para consumo direto em ferramentas de Business Intelligence (BI) e dashboards acadêmicos.








   
