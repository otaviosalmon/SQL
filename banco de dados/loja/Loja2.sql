SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_produtos
UNION ALL
SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_mais_produtos;


SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_produtos
UNION 
SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_mais_produtos;

SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_produtos
INTERSECT
SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_mais_produtos;

SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_produtos
MINUS
SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_mais_produtos;

(SELECT id_produto, id_tipo_produto, nm_produto
 FROM tb_produtos
 UNION
 SELECT id_produto, id_tipo_produto, nm_produto
 FROM tb_mais_produtos)
 INTERSECT
 SELECT id_produto, id_tipo_produto, nm_produto
 FROM tb_alteracoes_produtos;
 
 SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_produtos
UNION
(SELECT id_produto, id_tipo_produto, nm_produto
 FROM tb_mais_produtos
 INTERSECT
 SELECT id_produto, id_tipo_produto, nm_produto
 FROM tb_alteracoes_produtos);
 
 SELECT TRANSLATE('MENSAGEM SECRETA',
                 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
                 'EFGHIJKLMNOPQRSTUVWXYZABCD')
FROM dual;


SELECT id_produto, 
       TRANSLATE(nm_produto,
                 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz',
                 'EFGHIJKLMNOPQRSTUVWXYZABCDefghijklmnopqrstuvwxyzabcd')
FROM tb_produtos;

SELECT TRANSLATE(12345,
                 54321,
                 67890)
FROM dual;

SELECT DECODE(1, 1, 'n e memes', 'memes')
FROM dual;


SELECT DECODE(1, 2, 1, 3)
FROM dual;
 
 SELECT DECODE(1, 2, 'n e memes', 'memes')
FROM dual;


SELECT id_produto, disponivel,
                   DECODE(disponivel, 'Y', 'Produto está disponível',
                                           'Produto não está disponível')
FROM tb_mais_produtos;


SELECT id_produto, id_tipo_produto,
       DECODE(id_tipo_produto,
              1, 'Book',
              2, 'Video',
              3, 'DVD',
              4, 'CD',
                 'Magazine')
FROM tb_produtos;

SELECT id_produto, id_tipo_produto,
                   CASE id_tipo_produto
                     WHEN 1 THEN 'Book'
                     WHEN 2 THEN 'Video'
                     WHEN 3 THEN 'DVD'
                     WHEN 4 THEN 'CD'
                     ELSE 'Magazine'
                   END
FROM tb_produtos;

SELECT id_produto, id_tipo_produto,
    CASE
       WHEN id_tipo_produto = 1 THEN 'Book'
       WHEN id_tipo_produto = 2 THEN 'Video'
       WHEN id_tipo_produto = 3 THEN 'DVD'
       WHEN id_tipo_produto = 4 THEN 'CD'
       ELSE 'Magazine'
     END
FROM tb_produtos;

SELECT id_produto, preco,
    CASE
       WHEN preco > 15.00 THEN 'Caro'
       ELSE 'Barato'
    END
FROM tb_produtos;

SELECT id_funcionario, id_gerente, nome, sobrenome
FROM tb_mais_funcionarios
START WITH id_funcionario = 1
CONNECT BY PRIOR id_funcionario = id_gerente
ORDER BY 1;

SELECT LEVEL, id_funcionario, id_gerente, nome, sobrenome
FROM tb_mais_funcionarios
START WITH id_funcionario = 1
CONNECT BY PRIOR id_funcionario = id_gerente
ORDER BY LEVEL;

SELECT LEVEL,
       LPAD(' ', 2 * LEVEL - 1) || nome || ' ' || sobrenome AS funcionario
FROM tb_mais_funcionarios
START WITH id_funcionario = 1
CONNECT BY PRIOR id_funcionario = id_gerente;

CREATE TABLE tb_status_encomenda(
id_status_encomenda  INTEGER,
status VARCHAR2(40) DEFAULT 'Encomenda disponibilizada' NOT NULL,
ultima_modificacao   DATE DEFAULT SYSDATE,
PRIMARY KEY (id_status_encomenda)
);

INSERT INTO tb_status_encomenda(id_status_encomenda)
VALUES
(1);

INSERT INTO tb_status_encomenda(id_status_encomenda, status, ultima_modificacao)
VALUES
(2, 'Encomenda enviada', '01-MAI-2013');

UPDATE tb_status_encomenda
  SET status = DEFAULT
WHERE id_status_encomenda = 2;

SELECT *
FROM tb_status_encomenda;


MERGE INTO tb_produtos p
USING tb_produtos_alterados pa ON(p.id_produto = pa.id_produto)
WHEN MATCHED THEN
  UPDATE 
    SET 
      p.id_tipo_produto = pa.id_tipo_produto,
      p.nm_produto = pa.nm_produto,
      p.ds_produto = pa.ds_produto,
      p.preco = pa.preco,
      p.fg_ativo = pa.fg_ativo
WHEN NOT MATCHED THEN
  INSERT (
    p.id_produto, p.id_tipo_produto, p.nm_produto,
    p.ds_produto, p.preco, p.fg_ativo)
  VALUES (
    pa.id_produto, pa.id_tipo_produto, pa.nm_produto,
    pa.ds_produto, pa.preco, pa.fg_ativo);
    
SELECT id_produto, id_tipo_produto, nm_produto, preco
FROM tb_produtos
WHERE id_produto IN (1, 2, 3, 13, 14, 15);

INSERT INTO tb_clientes
VALUES
(12, 'Geraldo','Henrique','31-JUL-1977','800-112233',1);

COMMIT;

UPDATE tb_clientes
    SET nome ='José'
WHERE id_cliente = 1;

SELECT *
FROM tb_clientes
ORDER BY 1;

ROLLBACK;

SELECT id_produto, preco
FROM tb_produtos
WHERE id_produto IN (4,6);
--id 4 = 13,95 id = 6 =49,99

UPDATE tb_produtos
    SET preco = preco*1.20
WHERE id_produto = 4;
COMMIT;
SAVEPOINT save1;

UPDATE tb_produtos
    SET preco = preco*1.30
WHERE id_produto =6;

SELECT id_produto, preco
FROM tb_produtos
WHERE id_produto IN (4,6);

ROLLBACK TO SAVEPOINT save1;

SELECT id_produto,preco
FROM tb_produtos
WHERE id_produto IN(4,6);


SELECT id_produto, nm_produto, preco
FROM tb_produtos
WHERE id_produto <= 5;

UPDATE tb_produtos
  SET preco = preco * 0.75
WHERE id_produto <= 5;

COMMIT;

EXECUTE DBMS_FLASHBACK.ENABLE_AT_TIME(SYSDATE - 10/1440);

SELECT id_produto,nm_produto,preco
FROM tb_produtos
WHERE id_produto <=5;

EXECUTE DBMS_FLASHBACK.DISABLE();

VARIABLE scn_atual NUMBER;;

EXECUTE :scn_atual := DBMS_FLASHBACK.GET_SYSTEM_CHANGE_NUMBER();

PRINT scn_atual;

INSERT INTO tb_produtos(id_produto,
    id_tipo_produto,
    nm_produto,
    ds_produto,
    preco,
    fg_ativo)
VALUES(16,1,'Fisica','Livro sobre fisica',39.95,1);

COMMIT;

EXECUTE DBMS_FLASHBACK.ENABLE_AT_SYSTEM_CHANGE_NUMBER(:scn_atual);

SELECT *
FROM tb_produtos
WHERE id_produto = 16;

EXECUTE DBMS_FLASHBACK.DISABLE();

DROP TABLE tb_teste;

CREATE TABLE tb_teste(
id          INTEGER,
valor       VARCHAR2(100)
);

BEGIN
  FOR v_loop IN 1..100 LOOP
    INSERT INTO tb_teste(id, valor)
    VALUES
    (v_loop, 'DBA_' || v_loop);
  END LOOP;
END;

SELECT *
FROM tb_teste;

DROP TABLE tb_teste;

FLASHBACK TABLE tb_teste TO BEFORE DROP;