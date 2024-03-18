
-- WHILE��
DECLARE
    v_total NUMBER := 0;
    v_count NUMBER := 1;    -- begin
BEGIN
    WHILE v_count <= 10     -- end
    LOOP
        v_total := v_total + v_count;
        v_count := v_count + 1;     -- step
    END LOOP;
    
    dbms_output.put_line(v_total);
END;


-- Ż�⹮
DECLARE
    v_total NUMBER := 0;
    v_count NUMBER := 1;    -- begin
BEGIN
    WHILE v_count <= 10     -- end
    LOOP
        EXIT
            WHEN v_count = 5;  -- break
        v_total := v_total + v_count;
        v_count := v_count + 1;     -- step
    
    END LOOP;
    
    dbms_output.put_line(v_total);
END;


-- FOR��
DECLARE
    v_num NUMBER := 7;
BEGIN
    FOR i IN 1..9
    LOOP
        dbms_output.put_line(v_num || ' x ' || i || ' = ' || v_num * i);
    END LOOP;
END;


-- CONTINUE��
DECLARE
    v_num NUMBER := 7;
BEGIN
    FOR i IN 1..9
    LOOP
        CONTINUE WHEN
            MOD(i, 2) = 0;
            dbms_output.put_line(v_num || ' x ' || i || ' = ' || v_num * i);
    END LOOP;
END;


--------------------------------------------------------------------------------

-- 1. ��� �������� ����ϴ� �͸� ����� ���弼��. (2 ~ 9��)
-- ¦���ܸ� ����� �ּ���. (2, 4, 6, 8)
-- ����� ����Ŭ ������ �߿��� �������� �˾Ƴ��� �����ڰ� �����. (% ����~)

DECLARE
BEGIN
    FOR i IN 2..9
    LOOP
        CONTINUE WHEN
            MOD(i, 2) = 0;
            FOR j IN 1..9
                LOOP
                    dbms_output.put_line(i || ' x ' || j || ' = ' || i * j);            
                END LOOP;
                dbms_output.put_line('-----------------------------------------');            
    END LOOP;

END;



-- 2. INSERT�� 300�� �����ϴ� �͸� ����� ó���ϼ���.
-- board��� �̸��� ���̺��� ���弼��. (bno, writer, title �÷��� �����մϴ�.)
-- bno�� SEQUENCE�� �÷� �ֽð�, writer�� title�� ��ȣ�� �ٿ��� INSERT ������ �ּ���.
-- ex) 1, test1, title1 -> 2 test2 title2 -> 3 test3 title3 ....

CREATE SEQUENCE board_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 10000
;
DROP SEQUENCE board_seq;

CREATE TABLE
    board (
        bno NUMBER(3) PRIMARY KEY,
        writer VARCHAR(20),
        title VARCHAR(20)
    );
DROP TABLE board;

DECLARE
    v_num NUMBER := 300;
BEGIN
    FOR i IN 1..v_num
        LOOP
            INSERT INTO
                board
            VALUES
                (board_seq.NEXTVAL,
                'test' || board_seq.CURRVAL,
                'title' || board_seq.CURRVAL);            
        END LOOP;
END;

SELECT
    *
FROM
    board
ORDER BY
    bno DESC;

COMMIT;
