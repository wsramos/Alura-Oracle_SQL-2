/* 
------------------------------CREATE VIEW VW_VENDAS_VALIDAS-------------------------------------------
AUTOR: WILLIAM SAMPAIO RAMOS
DATA: 23/08/2022
DESCRIÇÃO: CRIAÇÃO DE VIEW PARA AVALIAR SE O TOTAL DE VENDAS DO CLIENTE É VÁLIDO DE ACORDO COM O LIMITE DE COMPRAS
------------------------------------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW VW_VENDAS_VALIDAS
AS
SELECT
    TC.NOME    
    ,SUM(INF.QUANTIDADE) AS TOTAL_COMPRAS
    ,VOLUME_DE_COMPRA
    ,(CASE 
        WHEN TC.VOLUME_DE_COMPRA >= SUM(INF.QUANTIDADE) THEN 'VENDAS VÁLIDAS'
        ELSE 'VENDAS INVÁLIDAS'
    END) AS TP_VENDA
    ,TO_CHAR(NF.DATA_VENDA, 'MM-YYYY') AS MES_ANO
FROM TABELA_DE_CLIENTES TC
INNER JOIN NOTAS_FISCAIS NF ON TC.CPF = NF.CPF
INNER JOIN ITENS_NOTAS_FISCAIS INF ON NF.NUMERO = INF.NUMERO
GROUP BY TC.NOME, TC.CPF, TC.VOLUME_DE_COMPRA, TO_CHAR(NF.DATA_VENDA, 'MM-YYYY')
ORDER BY MES_ANO;

COMMIT;

/