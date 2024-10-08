SELECT nm_produto,preco,preco + 2.00
FROM tb_produtos;

DESCRIBE dual;

SELECT *
FROM dual;

SELECT preco * 2 DOBRO_PREÇO
FROM tb_produtos;

SELECT preco,preco * 2 "Dobro do Preço"
FROM tb_produtos;

SELECT NOME ||''|| SOBRENOME as "Nome do Cliente"
FROM tb_clientes;

SELECT 'O funcionario ' || NOME ||' '|| SOBRENOME ||' recebe '|| SALARIO ||' mas gostario de receber ' || SALARIO * 3 "Salario dos Sonhos"
FROM tb_funcionarios;

SELECT id_cliente ,nome ,sobrenome, dt_nascimento
FROM tb_clientes
WHERE dt_nascimento IS NULL;

SELECT id_cliente, nome, sobrenome, telefone
FROM tb_clientes
WHERE telefone IS NULL;

SELECT id_cliente, nome, sobrenome,
NVL(telefone, 'Numero do telefone desconhecido') AS Numero_Telefone
FROM tb_clientes;

SELECT id_cliente, nome, sobrenome,
NVL(dt_nascimento,'22/JUN/2013') AS "Data de Nascimento"
FROM tb_clientes;

SELECT nome, LENGTH(nome) "expressao1",
sobrenome,LENGTH(sobrenome) "expressao2",
NULLIF(LENGTH(nome),LENGTH(sobrenome))"resultado"
FROM tb_funcionarios;

SELECT nome, sobrenome,
    COALESCE(telefone, TO_CHAR('telefone inexistente'))"EXEMPLO"
FROM tb_clientes;

SELECT nome, sobrenome,
    COALESCE(dt_nascimento, TO_DATE('21/08/2024')) "EXEMPLO"
FROM tb_clientes;

SELECT id_cliente
FROM tb_compras;

SELECT DISTINCT id_cliente
FROM tb_compras;

SELECT *
FROM tb_clientes
WHERE id_cliente <> 2;

SELECT id_produto 
FROM tb_produtos
WHERE id_produto >2;

SELECT ROWNUM id_produto ,nm_produto
FROM tb_produtos
WHERE ROWNUM <=3;

SELECT *
FROM tb_clientes
WHERE id_cliente > ANY(2,3,4);

SELECT *
FROM tb_clientes
WHERE id_cliente > ALL(2,3,4);

SELECT *
FROM tb_clientes
WHERE nome LIKE '_o%';

SELECT *
FROM tb_clientes
WHERE nome LIKE 'J%';

SELECT *
FROM tb_clientes
WHERE nome LIKE '____';

SELECT *
FROM tb_promocao
WHERE nome LIKE '%\%%'  ESCAPE'\';

SELECT *
FROM tb_clientes
WHERE id_cliente IN (2,3,5);

SELECT *
FROM tb_clientes
WHERE id_cliente NOT IN (2,3,5);

SELECT *
FROM tb_clientes
WHERE id_cliente NOT IN (2,3,5,NULL);

SELECT *
FROM tb_clientes
WHERE id_cliente NOT IN (2, 3, 5, NVL(NULL, 0));

SELECT *
FROM tb_clientes
WHERE id_cliente NOT BETWEEN 1 AND 3;


SELECT *
FROM tb_clientes
WHERE dt_nascimento > '01/JAN/1970' AND
      id_cliente > 3;
      
SELECT *
FROM tb_clientes
WHERE dt_nascimento > '01/JAN/1970' OR
      id_cliente > 3;

SELECT *
FROM tb_clientes
WHERE dt_nascimento > '01/JAN/1970' OR
      id_cliente < 2 AND
      telefone LIKE '%1211';

SELECT *
FROM tb_clientes
ORDER BY sobrenome;


SELECT *
FROM tb_clientes
ORDER BY nome ASC, sobrenome DESC;

SELECT id_cliente, nome, sobrenome
FROM tb_clientes
ORDER BY 1;

SELECT nm_produto, id_tipo_produto
FROM tb_produtos
WHERE id_produto = 3;

SELECT nm_tipo_produto
FROM tb_tipos_produtos
WHERE id_tipo_produto = 2;

SELECT tb_produtos.nm_produto,
       tb_tipos_produtos.nm_tipo_produto
FROM tb_produtos, tb_tipos_produtos
WHERE tb_produtos.id_tipo_produto = tb_tipos_produtos.id_tipo_produto
AND tb_produtos.id_produto = 3;

SELECT tb_produtos.nm_produto,
       tb_tipos_produtos.nm_tipo_produto
FROM tb_produtos, tb_tipos_produtos
WHERE tb_produtos.id_tipo_produto = tb_tipos_produtos.id_tipo_produto
ORDER BY tb_produtos.nm_produto;

SELECT p.nm_produto, tp.nm_tipo_produto
FROM tb_produtos p, tb_tipos_produtos tp
WHERE p.id_tipo_produto = tp.id_tipo_produto
ORDER BY p.nm_produto;

SELECT p.id_tipo_produto, tp.id_tipo_produto
FROM tb_produtos p, tb_tipos_produtos tp;

SELECT c.nome,c.sobrenome,p.nm_produto AS produto,
    tp.nm_tipo_produto AS tipo
FROM tb_clientes c, tb_compras co, tb_produtos p, tb_tipos_produtos tp
WHERE c.id_cliente = co.id_cliente AND
    p.id_produto = co.id_produto AND
    p.id_tipo_produto = tp.id_tipo_produto
ORDER BY p.nm_produto;

SELECT f.nome,f.sobrenome,f.cargo,f.salario,gs.id_salario
FROM tb_funcionarios f, tb_grades_salarios gs
WHERE f.salario BETWEEN gs.base_salario AND gs.teto_salario
ORDER BY gs.id_salario;

SELECT p.nm_produto AS produto ,tp.nm_tipo_produto AS tipo
FROM tb_produtos p, tb_tipos_produtos tp
WHERE p.id_tipo_produto = tp.id_tipo_produto(+)
ORDER BY 1;

SELECT p.nm_produto AS produto ,tp.nm_tipo_produto AS tipo
FROM tb_produtos p, tb_tipos_produtos tp
WHERE p.id_tipo_produto(+) = tp.id_tipo_produto
ORDER BY 1;

SELECT p.nm_produto AS produto ,tp.nm_tipo_produto AS tipo
FROM tb_produtos p, tb_tipos_produtos tp
WHERE p.id_tipo_produto(+) = tp.id_tipo_produto(+)
ORDER BY 1;
--n funfa
SELECT p.nm_produto AS produto ,tp.nm_tipo_produto AS tipo
FROM tb_produtos p, tb_tipos_produtos tp
WHERE p.id_tipo_produto(+) = tp.id_tipo_produto
ORDER BY p.id_tipo_produto;

SELECT f.nome ||' '|| f.sobrenome ||' trabalha para '|| g.nome
FROM tb_funcionarios f,tb_funcionarios g
WHERE f.id_gerente = g.id_funcionario
ORDER by f.nome;

SELECT f.nome ||' trabalha para  '|| NVL(g.sobrenome, 'os acionistas')
FROM tb_funcionarios f,tb_funcionarios g
WHERE f.id_gerente = g.id_gerente(+)
ORDER by f.sobrenome DESC;

SELECT p.nm_produto AS PRODUTO ,tp.nm_tipo_produto AS TIPO
FROM tb_produtos p
INNER JOIN tb_tipos_produtos tp ON (p.id_tipo_produto = tp.id_tipo_produto)
ORDER BY p.nm_produto;

SELECT f.nome,f.sobrenome,f.cargo,f.salario,gs.id_salario
FROM tb_funcionarios f
INNER JOIN tb_grades_salarios gs ON (f.salario BETWEEN gs.base_salario
                    AND gs.teto_salario)
ORDER BY gs.id_salario;

SELECT p.nm_produto AS PRODUTO, tp.nm_tipo_produto AS TIPO
FROM tb_produtos p
INNER JOIN tb_tipos_produtos tp
USING (id_tipo_produto);

SELECT c.nome,c.sobrenome,p.nm_produto AS produto,
    tp.nm_tipo_produto
FROM tb_clientes c
INNER JOIN tb_compras co USING (id_cliente)
INNER JOIN tb_produtos p USING (id_produto)
INNER JOIN tb_tipos_produtos tp USING (id_tipo_produto)
ORDER BY p.nm_produto;

SELECT p.nm_produto AS produto, tp.nm_tipo_produto AS tipo
FROM tb_produtos p
LEFT OUTER JOIN tb_tipos_produtos tp USING (id_tipo_produto)
ORDER BY p.nm_produto;

SELECT p.nm_produto AS produto, tp.nm_tipo_produto AS tipo
FROM tb_produtos p
RIGHT OUTER JOIN tb_tipos_produtos tp USING (id_tipo_produto)
ORDER BY p.nm_produto;

SELECT p.nm_produto AS produto, tp.nm_tipo_produto AS tipo
FROM tb_produtos p
FULL OUTER JOIN tb_tipos_produtos tp USING (id_tipo_produto)
ORDER BY p.nm_produto;

SELECT f.nome ||' '||f.sobrenome||' trabalha para '||g.nome
FROM tb_funcionarios f
INNER JOIN tb_funcionarios g ON(f.id_gerente = g.id_funcionario)
ORDER BY f.nome;

SELECT *
FROM tb_tipos_produtos
CROSS JOIN tb_produtos;

SELECT id_produto,nm_produto,preco
FROM tb_produtos
WHERE id_produto = &v_id_produto;

SELECT nm_produto ,&v_coluna
FROM &v_tabela
WHERE &v_coluna = &v_id_produto;

SELECT nm_produto, &&v_coluna
FROM &v_tabela
WHERE &&v_coluna = &v_id_produto;

DEFINE v_id_produto = 7;

SELECT nm_produto, id_produto
FROM tb_produtos
WHERE id_produto = &v_id_produto;

ACCEPT v_id NUMBER FORMAT 99 PROMPT 'Entre com o ID';

SELECT id_produto , nm_produto ,preco
FROM tb_produtos
WHERE id_produto = &v_id;

UNDEFINE v_id_produto;

@ C:/temp/teste~3.sql 6 19.99

SELECT ' DROP TABLE ' ||table_name||';'
FROM user_tables;

CREATE TABLE tb_teste(
id          INTEGER,
valor       VARCHAR2(100)
);

BEGIN
  FOR v_loop IN 1..100000 LOOP
    INSERT INTO tb_teste(id, valor)
    VALUES
    (v_loop, 'DBA_' || v_loop);
  END LOOP;
END;



COMMIT;

SELECT *
FROM tb_teste
ORDER BY 1 DESC;



CREATE TABLE tb_cliente_teste(
id_cliente          INTEGER,
ds_cliente          VARCHAR2(40),
nm_cliente          VARCHAR2(40),
valor               NUMERIC,
fg_ativo            INTEGER,
CONSTRAINT pk_tb_cliente_teste_id_cliente PRIMARY KEY(id_cliente)
);

CREATE OR REPLACE PROCEDURE manipula_dados(
    p_id_cliente IN tb_cliente_teste.id_cliente%TYPE,
    p_descricao  IN tb_cliente_teste.ds_cliente%TYPE,
    p_nome       IN tb_cliente_teste.nm_cliente%TYPE,
    p_valor      IN tb_cliente_teste.valor%TYPE,
    p_fg_ativo   IN tb_cliente_teste.fg_ativo%TYPE,
    p_opcao      IN CHAR)
AS
  v_controle  INTEGER;
BEGIN
  --verifica a existência de tuplas na "tb_cliente_teste"
  SELECT COUNT(1) INTO v_controle
  FROM tb_cliente_teste
  WHERE id_cliente = p_id_cliente
  AND fg_ativo = 1; 
  
  --opcao = I (INSERT)
  IF (p_opcao = 'I') THEN
    IF (v_controle != 1) THEN
      INSERT INTO tb_cliente_teste(id_cliente, ds_cliente, nm_cliente, valor, fg_ativo)
      VALUES
      (p_id_cliente, p_descricao, p_nome, p_valor, p_fg_ativo);
      
      COMMIT;
      
      dbms_output.put_line('Cliente inserido com sucesso!');
    ELSE
      dbms_output.put_line('ID do cliente já existe');
    END IF;
  END IF;  
  
  -- opcao = U (UPDATE)
  IF (p_opcao = 'U') THEN
    IF (v_controle = 1) THEN
      UPDATE tb_cliente_teste SET ds_cliente = p_descricao,
                                  nm_cliente = p_nome,
                                  valor      = p_valor,
                                  fg_ativo   = p_fg_ativo
      WHERE id_cliente = p_id_cliente
      AND fg_ativo = 1;
      
      COMMIT;
      
      dbms_output.put_line('Cliente alterado com sucesso!');
    ELSE
      dbms_output.put_line('ID do cliente não existe');
    END IF;
  END IF;
  
  -- opcao = D (DELETE)
  IF (p_opcao = 'D') THEN
    IF (v_controle = 1) THEN
      DELETE
      FROM tb_cliente_teste
      WHERE id_cliente = p_id_cliente
      AND fg_ativo = 1;
      
      COMMIT;
      
      dbms_output.put_line('Cliente excluído com sucesso!');
    ELSE
      dbms_output.put_line('ID do cliente não existe');
    END IF;
  END IF;
  
EXCEPTION
  WHEN others THEN
    ROLLBACK;
  
END manipula_dados;

-- Habilitar a saída DBMS
-- Menu Exibir > Saída DBMS
-- opcao inserir (parâmetro opcao = I)
CALL manipula_dados(1, 'Cliente 1', 'Nome do cliente 1', 22, 1, 'I');

-- opcao inserir (parâmetro opcao = I)
CALL manipula_dados(2, 'Cliente 2', 'Nome do cliente 2', 99, 1, 'I');


-- opcao alterar (parâmetro opcao = U)
CALL manipula_dados(2, 'Cliente alterado hoje', 'Alterado', 110, 1, 'U');

-- opcao excluir (parâmetro opcao = D)
CALL manipula_dados(2, NULL, NULL, NULL, NULL, 'D');

SELECT *
FROM tb_cliente_teste;

SELECT ASCII('a'), ASCII('A'), ASCII('z'), ASCII('Z'), ASCII('0'), ASCII('9')
FROM dual;

SELECT CHR(97), CHR(65), CHR(122), CHR(90), CHR(48), CHR(57)
FROM dual;


SELECT CONCAT(nome, sobrenome)
FROM tb_funcionarios;

SELECT id_produto, INITCAP(ds_produto)
FROM tb_produtos;

SELECT nm_produto, INSTR(nm_produto, 'Science')
FROM tb_produtos
WHERE id_produto = 1;

SELECT nm_produto, INSTR(nm_produto ,'e',1,2)
FROM tb_produtos
WHERE id_produto = 1;

SELECT nm_produto, LENGTH(nm_produto)
FROM tb_produtos;

SELECT UPPER (nome) , LOWER (sobrenome)
FROM tb_funcionarios;

SELECT RPAD (nm_produto, 30,'.'),LPAD(preco,8,'*+')
FROM tb_produtos
WHERE id_produto < 4;

SELECT 
    LTRIM ('  Olá pessoal tudo joia?'),
    RTRIM (' Oi tudo bem"abcabc', 'abc'),
    TRIM ('0' FROM '000Treinamento em Oracle"00000')
FROM dual;

SELECT id_cliente, NVL(telefone, 'Telefone inexistente')
FROM tb_clientes
ORDER BY id_cliente DESC;

SELECT REPLACE (nm_produto, 'Science', 'Physics')
FROM tb_produtos
WHERE id_produto = 1;

SELECT sobrenome
FROM tb_clientes
WHERE SOUNDEX (sobrenome) = SOUNDEX ('whyte');

SELECT nm_produto, SUBSTR(nm_produto, 2, 7)
FROM tb_produtos
WHERE id_produto < 4;

SELECT SUBSTR('Administrador de Banco de Dados - DBA', 34, 4)
FROM dual;

SELECT nm_produto, UPPER(SUBSTR(nm_produto, 2, 8))
FROM tb_produtos
WHERE id_produto < 4;

SELECT CEIL(5.8), CEIL(-5.2)
FROM dual;


SELECT FLOOR(5.8), FLOOR(-5.2)
FROM dual;

SELECT MOD(8,3), MOD(8,4)
FROM dual;

SELECT POWER(2,1), POWER(2,3)
FROM dual;

SELECT ROUND(5.75), ROUND(5.75, 1), ROUND(5.75, -1)
FROM dual;


SELECT SIGN(-5), SIGN(5), SIGN(0)
FROM dual;

SELECT SQRT(25), ROUND(SQRT(5), 2)
FROM dual;

SELECT TRUNC(5.75), TRUNC(5.75, 1), TRUNC(5.75, -1)
FROM dual;

SELECT TO_CHAR(12345.67)
FROM dual;

SELECT TO_CHAR(12345.67, '99,999.99')
FROM dual;

SELECT TO_CHAR(12345.67, '099,999.99')
FROM dual;

SELECT TO_CHAR(12345.67, '$99,999.99')
FROM dual;

SELECT TO_CHAR(00.67, 'B9.99')
FROM dual;

SELECT TO_CHAR(12345.67, 'C99,999.99')
FROM dual;

SELECT TO_CHAR(1235.67,'C99,999.99')
FROM dual;

SELECT TO_CHAR(12345.67,'999G99')
FROM dual;

SELECT TO_CHAR(-12345.6,'99,999.99MI')
FROM dual;

SELECT TO_CHAR(-12345.67,'99,999.99PR')
FROM dual;

SELECT TO_CHAR(2013,'RN')
FROM dual;

SELECT TO_CHAR(1234567,'TM')
FROM dual;

SELECT TO_CHAR(12345.67,'S99999.99')
FROM dual;

SELECT TO_CHAR(12345.67, 'U99,999.99')
FROM dual;


SELECT TO_CHAR(12345.67, '99999V99')
FROM dual;


SELECT TO_CHAR(12345678.90, '99,999.99')
FROM dual;

SELECT id_produto, 'O preço do produto é:' || TO_CHAR(preco, 'L99.99')
FROM tb_produtos
WHERE id_produto < 5;

SELECT TO_NUMBER('970,13')
FROM dual;

SELECT TO_NUMBER('970,13') + 25,50
FROM dual;

SELECT TO_NUMBER ('-$12,345.67' , '$99,999.99')
FROM dual;

SELECT
    CAST(1234.67 AS VARCHAR(10)),
    CAST('9A4F' AS RAW(2)), 
    CAST ('01-DEZ-2007' AS DATE),
    CAST(12345.678 AS NUMBER(10,2))
FROM dual;

SELECT 
   CAST(preco AS VARCHAR2(10)),
   CAST(preco + 2 AS NUMBER(7,2)),
   CAST(preco AS BINARY_DOUBLE)
FROM tb_produtos
WHERE id_produto = 1;

SELECT id_cliente,nome,sobrenome,dt_nascimento
FROM tb_clientes
WHERE REGEXP_LIKE(TO_CHAR(dt_nascimento,'YYYY'), '196[5-8]$');

SELECT id_cliente,nome,sobrenome,dt_nascimento
FROM tb_clientes
WHERE REGEXP_LIKE(nome,'j','i');

SELECT
   REGEXP_INSTR('Teste de expressão regular', 'e', 6, 2) AS resultado
FROM dual;

SELECT 
   REGEXP_REPLACE('Teste de expressão regular', 
                  'd[[:alpha:]]{1}', 'Oracle') AS resultado
FROM dual;

SELECT
   REGEXP_SUBSTR('Teste de expressão regular', 'e[[:alpha:]]{8}') AS resultado
FROM dual;


SELECT 
  REGEXP_COUNT('teste teste teste expressão regular', 't[[:alpha:]]{4}') AS resultado
FROM dual;

SELECT AVG(preco)
FROM tb_produtos;

SELECT CAST(AVG(preco) AS NUMBER(5,2)) "Média de Preço"
FROM tb_produtos;

SELECT AVG(preco + 2.00)
FROM tb_produtos;



SELECT AVG(DISTINCT preco)
FROM tb_produtos;


SELECT COUNT(id_produto)
FROM tb_produtos;


SELECT COUNT(ROWID)
FROM tb_produtos;

SELECT nm_produto,preco
FROM tb_produtos
WHERE preco = (SELECT MAX (preco)
FROM tb_produtos);

SELECT TO_CHAR(TO_DATE('05-FEV-1968'),'MONTH DD,YYYY')
FROM dual;

SELECT TO_DATE('04-JUL-2013'), TO_DATE('04-JUL-13')
FROM dual;

SELECT TO_DATE('Jul 06,2013', 'MONTH DD,YYYY')
FROM dual;

SELECT *
FROM nls_session_parameters;

ALTER SESSION SET NLS_DATE_FORMAT = 'Mon/dd/yyyy';

SELECT TO_DATE('7.4.13','MM.DD.YY')
FROM dual;

INSERT INTO tb_clientes(id_cliente,nome,sobrenome,dt_nascimento,telefone,fg_ativo)
VALUES(
10,
'Nome',
'Sobrenome',
TO_DATE('Jul 04, 2013 19:32:36','MONTH DD, YYYY HH24:MI:SS'),
'800-555-1215',
1);

SELECT id_cliente,
    TO_CHAR (dt_nascimento,'DD-MON-YYYY HH24:MI:SS')
FROM tb_clientes
ORDER BY id_cliente;

ROLLBACK;

SELECT ROUND(TO_DATE('May 25 ,2023'))
FROM dual;

SELECT TO_CHAR
    (ROUND
    (TO_DATE('Jul 03,2023 19:45:26','MONTH DD, YYYY HH24:MI:SS'),'HH24'),
        'MONTH DD, YYYY HH24:MI:SS')
FROM duaL;

SELECT
    EXTRACT(YEAR FROM TO_DATE('Jul 03, 2023 19:45:26',
        'MONTH DD, YYYY HH24:MI:SS')) AS YEAR,
         EXTRACT(MONTH FROM TO_DATE('Jul 03, 2023 19:45:26',
        'MONTH DD, YYYY HH24:MI:SS')) AS MONTH,
         EXTRACT(DAY FROM TO_DATE('Jul 03, 2023 19:45:26',
        'MONTH DD, YYYY HH24:MI:SS')) AS DAY
FROM dual;

SELECT
    EXTRACT(HOUR FROM TO_TIMESTAMP('Jul 03, 2023 19:45:26',
        'MONTH DD, YYYY HH24:MI:SS')) AS HORA,
     EXTRACT(MINUTE FROM TO_TIMESTAMP('Jul 03, 2023 19:45:26',
        'MONTH DD, YYYY HH24:MI:SS')) AS MINUTO,
     EXTRACT(SECOND FROM TO_TIMESTAMP('Jul 03, 2023 19:45:26',
        'MONTH DD, YYYY HH24:MI:SS')) AS SEGUNDO
FROM dual;

SELECT *
FROM tb_promocao;

SELECT 
   NUMTODSINTERVAL(1.5, 'DAY'),
   NUMTODSINTERVAL(3.25, 'HOUR'),
   NUMTODSINTERVAL(5, 'MINUTE'),
   NUMTODSINTERVAL(10.123456789, 'SECOND')
FROM dual;


SELECT 
   NUMTOYMINTERVAL(1.5, 'YEAR'),
   NUMTOYMINTERVAL(3.25, 'MONTH')
FROM dual;

SELECT nome,sobrenome
FROM tb_clientes
WHERE id_cliente = (SELECT id_cliente
                    FROM tb_clientes
                    WHERE sobrenome = 'Blue');

SELECT id_produto, nm_produto, preco
FROM tb_produtos
WHERE preco > (SELECT AVG(preco)
               FROM tb_produtos);
               
SELECT id_tipo_produto, AVG(preco)
FROM tb_produtos
GROUP BY id_tipo_produto
HAVING AVG(preco) < (SELECT MAX(AVG(preco))
                     FROM tb_produtos
                     GROUP BY id_tipo_produto)
ORDER BY id_tipo_produto;

SELECT id_produto
FROM (SELECT id_produto
      FROM tb_produtos
      WHERE id_produto < 3);
      

SELECT p.id_produto, preco, dados_compra.count_produto
FROM tb_produtos p, (SELECT id_produto, COUNT(id_produto) count_produto
                     FROM tb_compras
                     GROUP BY id_produto) dados_compra
WHERE p.id_produto = dados_compra.id_produto;   

-- Data (08/10/2024)

SELECT id_produto, nm_produto
FROM tb_produtos
WHERE id_produto IN (SELECT id_produto
                     FROM tb_produtos
                     WHERE nm_produto LIKE '%e%');
SELECT id_produto, nm_produto
FROM tb_produtos
WHERE id_produto NOT IN (SELECT id_produto
                         FROM tb_compras);
                         

SELECT id_funcionario, nome, salario
FROM tb_funcionarios
WHERE salario < ANY (SELECT base_salario
                     FROM tb_grades_salarios);
                     
SELECT id_funcionario, nome, salario
FROM tb_funcionarios
WHERE salario > ALL (SELECT teto_salario
                     FROM tb_grades_salarios);


SELECT id_produto, id_tipo_produto, nm_produto, preco
FROM tb_produtos
WHERE (id_tipo_produto, preco) IN (SELECT id_tipo_produto, MIN(preco)
                                   FROM tb_produtos
                                   GROUP BY id_tipo_produto);

SELECT id_produto, id_tipo_produto, nm_produto, preco
FROM tb_produtos externa
WHERE preco > (SELECT AVG(preco)
               FROM tb_produtos interna
               WHERE interna.id_tipo_produto = externa.id_tipo_produto);


SELECT id_funcionario, nome, sobrenome
FROM tb_funcionarios externa
WHERE EXISTS (SELECT id_funcionario
              FROM tb_funcionarios interna
              WHERE interna.id_gerente = externa.id_funcionario);

SELECT id_funcionario, nome, sobrenome
FROM tb_funcionarios externa
WHERE EXISTS (SELECT 1
              FROM tb_funcionarios interna
              WHERE interna.id_gerente = externa.id_funcionario)

SELECT id_produto, nm_produto
FROM tb_produtos externa
WHERE NOT EXISTS (SELECT 1
                  FROM tb_compras interna
                  WHERE interna.id_produto = externa.id_produto);

SELECT id_tipo_produto, nm_tipo_produto
FROM tb_tipos_produtos externa
WHERE NOT EXISTS (SELECT 1
                  FROM tb_produtos interna
                  WHERE interna.id_tipo_produto = externa.id_tipo_produto);


SELECT id_tipo_produto, nm_tipo_produto
FROM tb_tipos_produtos
WHERE id_tipo_produto NOT IN (SELECT id_tipo_produto
                              FROM tb_produtos);


SELECT id_tipo_produto, nm_tipo_produto
FROM tb_tipos_produtos
WHERE id_tipo_produto NOT IN (SELECT NVL(id_tipo_produto, 0)
                              FROM tb_produtos);
                              
SELECT id_tipo_produto, AVG(preco)
FROM tb_produtos
GROUP BY id_tipo_produto
HAVING AVG(preco) < (SELECT MAX(AVG(preco))
                     FROM tb_produtos
                     WHERE id_produto IN (SELECT id_produto
                                          FROM tb_compras
                                          WHERE quantidade > 1)
                     GROUP BY id_tipo_produto)
ORDER BY id_tipo_produto;

SELECT sobrenome,id_departamento,salario
FROM tb_funcionarios
WHERE salario = (SELECT id_departamento, salario
                 FROM tb_empregados

