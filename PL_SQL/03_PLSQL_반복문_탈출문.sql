
-- WHILE문
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


-- 탈출문
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


-- FOR문
DECLARE
    v_num NUMBER := 7;
BEGIN
    FOR i IN 1..9
    LOOP
        dbms_output.put_line(v_num || ' x ' || i || ' = ' || v_num * i);
    END LOOP;
END;


-- CONTINUE문
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

-- 1. 모든 구구단을 출력하는 익명 블록을 만드세요. (2 ~ 9단)
-- 짝수단만 출력해 주세요. (2, 4, 6, 8)
-- 참고로 오라클 연산자 중에는 나머지를 알아내는 연산자가 없어요. (% 없음~)

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



-- 2. INSERT를 300번 실행하는 익명 블록을 처리하세요.
-- board라는 이름의 테이블을 만드세요. (bno, writer, title 컬럼이 존재합니다.)
-- bno는 SEQUENCE로 올려 주시고, writer와 title에 번호를 붙여서 INSERT 진행해 주세요.
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
