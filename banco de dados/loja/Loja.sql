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

SELECT sobrenome,id_departamento
FROM tb_funcionarios
WHERE (salario,id_departamento) IN (SELECT salario, id_departamento
                                     FROM tb_empregados
                                      WHERE percentual_comissao IS NOT NULL);

SELECT e.sobrenome, d.nm_departamento,e.salario
FROM tb_empregado e,tb_departamento d
WHERE e.id_departamento = d.id_departamento
AND (salario , NVL(percentual_comissao, 0)) IN
                                                (SELECT salario, NVL(percentual_comissao, 0)
                                                FROM tb_funcionarios e, tb_departamento d
                                                WHERE e.id_departamento = d.id_departamento
                                                AND d.id_localizacao = 1700);
SELECT nome,sobrenome
FROM tb_empregado
WHERE salario, NVL(percentual_comissao, 0) = 
                (SELECT salarioNVL(percentual_comissao, 0)
                FROM tb_empregado
                WHERE sobrenome = 'Kocchar')
AND sobrenome != 'Kocchar';

SELECT id_empregado, sobrenome, id_departamento
FROM tb_empregado
WHERE id_departamento IN
                        (SELECT id_departamento
                        FROM tb_departamento
                        WHERE id_localizacao IN
                                                (SELECT id_localizacao
                                                FROM tb_localizacao
                                                WHERE cidade LIKE 'T%'));

CREATE TABLE tb_alteracoes_produtos (
  id_produto          INTEGER,
  id_tipo_produto     INTEGER,
  nm_produto          VARCHAR2(30) NOT NULL,
  descricao           VARCHAR2(50),
  preco               NUMBER(5, 2),
  PRIMARY KEY(id_produto),
  FOREIGN KEY(id_tipo_produto) REFERENCES tb_tipos_produtos(id_tipo_produto)
);

INSERT INTO tb_alteracoes_produtos (id_produto, id_tipo_produto, nm_produto, descricao, preco) 
VALUES (1, 1, 'Modern Science', 'A description of modern science', 40.00);

INSERT INTO tb_alteracoes_produtos (id_produto, id_tipo_produto, nm_produto, descricao, preco) 
VALUES (2, 1, 'New Chemistry', 'Introduction to Chemistry', 35.00);

INSERT INTO tb_alteracoes_produtos (id_produto, id_tipo_produto, nm_produto, descricao, preco) 
VALUES (3, 1, 'Supernova', 'A star explodes', 25.99);

INSERT INTO tb_alteracoes_produtos (id_produto, id_tipo_produto, nm_produto, descricao, preco) 
VALUES (13, 2, 'Lunar Landing', 'Documentary', 15.99);

INSERT INTO tb_alteracoes_produtos (id_produto, id_tipo_produto, nm_produto, descricao, preco) 
VALUES (14, 2, 'Submarine', 'Documentary', 15.99);

INSERT INTO tb_alteracoes_produtos (id_produto, id_tipo_produto, nm_produto, descricao, preco) 
VALUES (15, 2, 'Airplane', 'Documentary', 15.99);

-- commit the transaction
COMMIT;

CREATE TABLE tb_cargos (
id_cargo  CHAR(3),
nm_cargo  VARCHAR2(20) NOT NULL,
PRIMARY KEY(id_cargo)
);

-- insert sample data into jobs table
INSERT INTO tb_cargos (id_cargo, nm_cargo) 
VALUES ('WOR', 'Worker');

INSERT INTO tb_cargos (id_cargo, nm_cargo) 
VALUES ('MGR', 'Manager');

INSERT INTO tb_cargos (id_cargo, nm_cargo) 
VALUES ('ENG', 'Engineer');

INSERT INTO tb_cargos (id_cargo, nm_cargo) 
VALUES ('TEC', 'Technologist');

INSERT INTO tb_cargos (id_cargo, nm_cargo) 
VALUES ('PRE', 'President');

-- commit the transaction
COMMIT;

CREATE TABLE tb_divisoes (
id_divisao    CHAR(3),
nm_divisao    VARCHAR2(15) NOT NULL,
PRIMARY KEY (id_divisao)
);

-- insert sample data into divisions table
INSERT INTO tb_divisoes (id_divisao, nm_divisao) 
VALUES ('SAL', 'Sales');

INSERT INTO tb_divisoes (id_divisao, nm_divisao) 
VALUES ('OPE', 'Operations');

INSERT INTO tb_divisoes (id_divisao, nm_divisao) 
VALUES ('SUP', 'Support');

INSERT INTO tb_divisoes (id_divisao, nm_divisao) 
VALUES ('BUS', 'Business');

-- commit the transaction
COMMIT;

CREATE TABLE tb_funcionarios_2 (
id_funcionario      INTEGER,
id_divisao          CHAR(3),
id_cargo            CHAR(3),
nome                VARCHAR2(10) NOT NULL,
sobrenome           VARCHAR2(10) NOT NULL,
salario             NUMBER(6,0),
PRIMARY KEY(id_funcionario),
FOREIGN KEY(id_divisao) REFERENCES tb_divisoes(id_divisao),
FOREIGN KEY(id_cargo) REFERENCES tb_cargos(id_cargo)
);

-- insert sample data into employees2 table
INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario) 
VALUES (1, 'BUS', 'PRE', 'James', 'Smith', 800000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)   
VALUES (2, 'SAL', 'MGR', 'Ron', 'Johnson', 350000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (3, 'SAL', 'WOR', 'Fred', 'Hobbs', 140000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (4, 'SUP', 'MGR', 'Susan', 'Jones', 200000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)   
VALUES (5, 'SAL', 'WOR', 'Rob', 'Green', 350000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)   
VALUES (6, 'SUP', 'WOR', 'Jane', 'Brown', 200000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)   
VALUES (7, 'SUP', 'MGR', 'John', 'Grey', 265000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (8, 'SUP', 'WOR', 'Jean', 'Blue', 110000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (9, 'SUP', 'WOR', 'Henry', 'Heyson', 125000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (10, 'OPE', 'MGR', 'Kevin', 'Black', 225000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (11, 'OPE', 'MGR', 'Keith', 'Long', 165000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)   
VALUES (12, 'OPE', 'WOR', 'Frank', 'Howard', 125000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (13, 'OPE', 'WOR', 'Doreen', 'Penn', 145000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (14, 'BUS', 'MGR', 'Mark', 'Smith', 155000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (15, 'BUS', 'MGR', 'Jill', 'Jones', 175000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (16, 'OPE', 'ENG', 'Megan', 'Craig', 245000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (17, 'SUP', 'TEC', 'Matthew', 'Brant', 115000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)   
VALUES (18, 'OPE', 'MGR', 'Tony', 'Clerke', 200000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (19, 'BUS', 'MGR', 'Tanya', 'Conway', 200000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (20, 'OPE', 'MGR', 'Terry', 'Cliff', 215000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)   
VALUES (21, 'SAL', 'MGR', 'Steve', 'Green', 275000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)   
VALUES (22, 'SAL', 'MGR', 'Roy', 'Red', 375000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)   
VALUES (23, 'SAL', 'MGR', 'Sandra', 'Smith', 335000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)   
VALUES (24, 'SAL', 'MGR', 'Gail', 'Silver', 225000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (25, 'SAL', 'MGR', 'Gerald', 'Gold', 245000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (26, 'SAL', 'MGR', 'Eileen', 'Lane', 235000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (27, 'SAL', 'MGR', 'Doreen', 'Upton', 235000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)   
VALUES (28, 'SAL', 'MGR', 'Jack', 'Ewing', 235000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (29, 'SAL', 'MGR', 'Paul', 'Owens', 245000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)   
VALUES (30, 'SAL', 'MGR', 'Melanie', 'York', 255000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)   
VALUES (31, 'SAL', 'MGR', 'Tracy', 'Yellow', 225000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (32, 'SAL', 'MGR', 'Sarah', 'White', 235000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (33, 'SAL', 'MGR', 'Terry', 'Iron', 225000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (34, 'SAL', 'MGR', 'Christine', 'Brown', 247000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (35, 'SAL', 'MGR', 'John', 'Brown', 249000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (36, 'SAL', 'MGR', 'Kelvin', 'Trenton', 255000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)   
VALUES (37, 'BUS', 'WOR', 'Damon', 'Jones', 280000);

-- commit the transaction
COMMIT;

CREATE TABLE tb_mais_funcionarios (
id_funcionario          INTEGER,
id_gerente              INTEGER,
nome                    VARCHAR2(10) NOT NULL,
sobrenome               VARCHAR2(10) NOT NULL,
cargo                   VARCHAR2(20),
salario                 NUMBER(6, 0),
fg_ativo                INTEGER,
PRIMARY KEY (id_funcionario),
FOREIGN KEY (id_gerente) REFERENCES tb_mais_funcionarios(id_funcionario)
);

INSERT INTO tb_mais_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo)
VALUES (1, NULL, 'James', 'Smith', 'CEO', 800000, 1);
     
INSERT INTO tb_mais_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo) 
VALUES (2, 1, 'Ron', 'Johnson', 'Sales Manager', 600000, 1);

INSERT INTO tb_mais_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo) 
VALUES (3, 2, 'Fred', 'Hobbs', 'Sales Person', 200000, 1);

INSERT INTO tb_mais_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo) 
VALUES (4, 1, 'Susan', 'Jones', 'Support Manager', 500000, 1);

INSERT INTO tb_mais_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo) 
VALUES (5, 2, 'Rob', 'Green', 'Sales Person', 40000, 1);

INSERT INTO tb_mais_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo) 
VALUES (6, 4, 'Jane', 'Brown', 'Support Person', 45000, 1);

INSERT INTO tb_mais_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo) 
VALUES (7, 4, 'John', 'Grey', 'Support Manager', 30000, 1);

INSERT INTO tb_mais_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo) 
VALUES (8, 7, 'Jean', 'Blue', 'Support Person', 29000, 1);

INSERT INTO tb_mais_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo) 
VALUES (9, 6, 'Henry', 'Heyson', 'Support Person', 30000, 1);

INSERT INTO tb_mais_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo) 
VALUES (10, 1, 'Kevin', 'Black', 'Ops Manager', 100000, 1);

INSERT INTO tb_mais_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo) 
VALUES (11, 10, 'Keith', 'Long', 'Ops Person', 50000, 1);

INSERT INTO tb_mais_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo) 
VALUES (12, 10, 'Frank', 'Howard', 'Ops Person', 45000, 1);

INSERT INTO tb_mais_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo) 
VALUES (13, 10, 'Doreen', 'Penn', 'Ops Person', 47000, 1);

-- commit the transaction
COMMIT;

CREATE TABLE tb_mais_produtos (
  id_produto          INTEGER,
  id_tipo_produto     INTEGER,
  nm_produto          VARCHAR2(30) NOT NULL,
  disponivel          CHAR(1),
  PRIMARY KEY (id_produto),
  FOREIGN KEY (id_tipo_produto) REFERENCES tb_tipos_produtos(id_tipo_produto)
);

INSERT INTO tb_mais_produtos (id_produto, id_tipo_produto, nm_produto, disponivel) 
VALUES (1, 1, 'Modern Science', 'Y');

INSERT INTO tb_mais_produtos (id_produto, id_tipo_produto, nm_produto, disponivel)
VALUES (2, 1, 'Chemistry', 'Y');

INSERT INTO tb_mais_produtos (id_produto, id_tipo_produto, nm_produto, disponivel) 
VALUES (3, NULL, 'Supernova', 'N');

INSERT INTO tb_mais_produtos (id_produto, id_tipo_produto, nm_produto, disponivel) 
VALUES (4, 2, 'Lunar Landing', 'N');

INSERT INTO tb_mais_produtos (id_produto, id_tipo_produto, nm_produto, disponivel) 
VALUES (5, 2, 'Submarine', 'Y');

-- commit the transaction
COMMIT;

CREATE TABLE tb_produtos_alterados(
id_produto          INTEGER,
id_tipo_produto     INTEGER,
nm_produto          VARCHAR2(30) NOT NULL,
ds_produto          VARCHAR2(50),
preco               NUMBER(5, 2),
fg_ativo            INTEGER,
PRIMARY KEY (id_produto),
FOREIGN KEY (id_tipo_produto) REFERENCES tb_tipos_produtos(id_tipo_produto)
);

INSERT INTO tb_produtos_alterados(id_produto, id_tipo_produto, nm_produto, preco, fg_ativo)
VALUES 
(1, 1, 'Modern Science',40, 1);

INSERT INTO tb_produtos_alterados(id_produto, id_tipo_produto, nm_produto, preco, fg_ativo)
VALUES 
(2, 1, 'New Chemistry',35, 1);

INSERT INTO tb_produtos_alterados(id_produto, id_tipo_produto, nm_produto, preco, fg_ativo)
VALUES 
(3, 1, 'Super Nova',25.99, 1);

INSERT INTO tb_produtos_alterados(id_produto, id_tipo_produto, nm_produto, preco, fg_ativo)
VALUES 
(13, 2, 'Lunar Landing',15.99, 1);

INSERT INTO tb_produtos_alterados(id_produto, id_tipo_produto, nm_produto, preco, fg_ativo)
VALUES 
(14, 2, 'Submarine',15.99, 1);

INSERT INTO tb_produtos_alterados(id_produto, id_tipo_produto, nm_produto, preco, fg_ativo)
VALUES 
(15, 2, 'Airplane',15.99, 1);

COMMIT;
