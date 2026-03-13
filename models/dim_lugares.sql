{{ config(materialized='table') }}

SELECT id, nome, status
FROM `{{ target.project }}.meu_dataset_bruto.lugares`
WHERE status = 'ativo'